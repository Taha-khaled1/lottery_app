

// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

const functions = require("firebase-functions");
const admin = require("firebase-admin");
// const {CloudSchedulerClient} = require("@google-cloud/scheduler");

admin.initializeApp();
// const db = admin.firestore();


// const functions = require("firebase-functions");
// const admin = require("firebase-admin");
// admin.initializeApp();

const db = admin.firestore();

exports.endLottery = functions.pubsub.schedule("every 10 minutes").
    timeZone("UTC").onRun(async (context) => {
      const lotteryId = await fetchCurrentLotteryId();

      if (!lotteryId) {
        console.error("No active lottery found. Exiting function.");
        return null; // Exit the function if no active lottery is found
      }

      // Fetch all tickets for the current lottery
      const ticketSnapshot = await db.collection("tickets").
          where("lottery_id", "==", lotteryId).get();

      // Check if there are no tickets
      if (ticketSnapshot.empty) {
        console.log("No tickets found. Exiting function.");
        return null; // Exit the function if there are no tickets
      }
      // Calculate prize value based on number of tickets
      const prizeValue = ticketSnapshot.docs.length * 0.1;

      // Select a random winner
      const winningTicket = ticketSnapshot.
          docs[Math.floor(Math.random() * ticketSnapshot.docs.length)];

      // Update user"s wallet for the winning user
      const winningUserRef = db.collection("users").
          doc(winningTicket.data().user_id);

      const winningUserSnapshot = await winningUserRef.get();

      if (winningUserSnapshot.exists) {
        const currentWalletValue =
        parseFloat(winningUserSnapshot.data().wallet || "0");
        const updatedWalletValue = currentWalletValue + prizeValue;

        await winningUserRef.update({
          "wallet": updatedWalletValue.toFixed(1),
        });

        await addWinners(
            winningUserSnapshot.data().name,
            winningUserSnapshot.data().image,
            prizeValue,
        );
      }

      // Update lottery document
      await db.collection("lottery").doc(lotteryId).update({
        "status": false,
        "prize": prizeValue,
        "user_id": winningTicket.data().user_id,
      });

      // Update winning ticket document
      await db.collection("tickets").doc(winningTicket.id).update({
        "status": false,
        "prize": prizeValue.toFixed(1),
        "type": "Won",
      });

      // Update all other ticket documents for this lottery
      const ticketDocs = ticketSnapshot.docs;
      for (const ticketDoc of ticketDocs) {
        if (ticketDoc.id !== winningTicket.id) {
          await ticketDoc.ref.update({
            "status": false,
            "type": "Lost",
          });
        }
      }

      // Initialize a new lottery for the next round
      await initializeNewLottery();

      return null;
    });
/**
 * Fetches the ID of the current active lottery from Firestore.
 *
 * @return {Promise<string|null>} The ID of the active l.
 */
async function fetchCurrentLotteryId() {
  const lotterySnapshot = await db.collection("lottery")
      .where("status", "==", true)
      .limit(1)
      .get();

  if (!lotterySnapshot.empty) {
    return lotterySnapshot.docs[0].id; // This is the current active lottery ID
  } else {
    console.error("No active lottery found.");
    return null; // or handle this case appropriately
  }
}
/**
 * Adds a winner to the 'winners' collection in Firestore.
 *
 * @param {string} name - The name of the winner.
 * @param {string} image - The image URL or path of the winner.
 * @param {number} prize - The prize amount won by the winner.
 * @return {Promise<void>} Resolves when the winner is added to Firestore.
 */
async function addWinners(name, image, prize) {
  await db.collection("winners").add({
    "name": name,
    "image": image,
    "prize": prize.toFixed(1),
    "create_at": new Date().toISOString(),
  });
}


/**
 * Initializes a new lotterytion.
 *
 *@return {Promise<void>} Resolves whenirestore.
 */
async function initializeNewLottery() {
  const batch = db.batch();

  // Calculate end time for the new lottery
  const endTime = new Date();
  endTime.setHours(endTime.getHours() + 1); // Add 1 hour

  // Create a new lottery document
  const newLotteryRef = db.collection("lottery").doc();

  batch.set(newLotteryRef, {
    "time_end": endTime.toISOString(),
    "create_at": new Date().toISOString(),
    "status": true,
    "prize": 0,
  });

  batch.update(newLotteryRef, {"lottery_id": newLotteryRef.id});

  await batch.commit();
}

exports.hourlyFunction = functions.pubsub.
    schedule("every 1 hours").timeZone("UTC").
    onRun((context) => {
      console.log("This will be run every hour!");
      return null;
    });

exports.everyTenMinutesFunction = functions.pubsub.
    schedule("every 10 minutes").timeZone("UTC").
    onRun((context) => {
      console.log("This will be run every 10 minutes!");
      return null;
    });
