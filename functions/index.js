

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
// every 4 hours
// every 10 minutes
exports.endLotteryAppFinal = functions.pubsub.schedule("every 4 hours").
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
        console.log("No tickets found.");

        // Fetch the current time_end value
        // const lotteryDoc = await db.collection("lottery").doc(lotteryId).
        // get();
        // const currentEndTimeStr = lotteryDoc.data().time_end;

        // Sanitize the currentEndTimeStr
        // const sanitizedEndTimeStr = currentEndTimeStr.
        //     replace(/\s+/g, " ").replace(/:\s+/g, ":");

        // Convert the sanitized string to a Date object
        // const endTimeDate = new Date(sanitizedEndTimeStr);

        // Add 10 minutes
        // endTimeDate.setMinutes(endTimeDate.getMinutes() + 10);

        // Convert the Date object back to the desired string format
        // eslint-disable-next-line max-len
        // const updatedEndTimeStr = `${endTimeDate.getFullYear()}-${String(endTimeDate.getMonth() + 1).padStart(2, "0")}-${String(endTimeDate.getDate()).padStart(2, "0")} ${String(endTimeDate.getHours()).padStart(2, "0")}:${String(endTimeDate.getMinutes()).padStart(2, "0")}:${String(endTimeDate.getSeconds()).padStart(2, "0")}.${String(endTimeDate.getMilliseconds()).padStart(6, "0")}`;

        const endTime = new Date();
        // endTime.setHours(endTime.getHours() + 1); // Add 1 hour
        // endTime.setMinutes(endTime.getMinutes() + 10);
        endTime.setHours(endTime.getHours() + 4);
        // Update the time_end value in Firestore
        await db.collection("lottery").doc(lotteryId).update({
          // "time_end": updatedEndTimeStr,
          "time_end": endTime.toISOString(),
        });

        return null; // Exit the function if there are no tickets
      }
      // Calculate prize value based on number of tickets
      const prizeValue = ticketSnapshot.docs.length * 0.01;

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
        const settingDoc = await db.
            collection("setting").doc("setting").get();
        let percentage = settingDoc.data().percentage;
        // Convert string percentage to number
        if (percentage) {
          percentage = parseInt(percentage, 10);
        }
        const discountedPrize = prizeValue * (1 - percentage / 100);
        const updatedWalletValue = currentWalletValue + discountedPrize;

        await winningUserRef.update({
          "wallet": updatedWalletValue.toFixed(2),
        });


        const ticketId = winningTicket.data().ticket_id;
        const ticketNumber = winningTicket.data().ticket_number;
        await addWinners(
            winningUserSnapshot.data().name,
            winningUserSnapshot.data().image,
            prizeValue,
            ticketId,
            ticketNumber,
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
        "prize": prizeValue.toFixed(2),
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
      const usersSnapshot = await db.collection("users").get();
      const tokens = usersSnapshot.docs.map((doc) => doc.data().fcm).
          filter((token) => token);
      const message = {
        notification: {
          title: "Lottery Results",
          body: `The lottery has ended! Check if you've won!`,
        },
        tokens: tokens,
      };

      await admin.messaging().sendEachForMulticast(message);
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
 * @param {string} ticketId - The image URL or path of the winner.
 * @param {number} ticketNumber - The prize amount won by the winner.
 * @return {Promise<void>} Resolves when the winner is added to Firestore.
 */
async function addWinners(name, image, prize, ticketId, ticketNumber) {
  await db.collection("winners").add({
    "name": name,
    "image": image,
    "prize": prize.toFixed(2),
    "ticket_id": ticketId,
    "ticket_number": ticketNumber,
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
  // endTime.setHours(endTime.getHours() + 1); // Add 1 hour
  // endTime.setMinutes(endTime.getMinutes() + 10);
  endTime.setHours(endTime.getHours() + 4);
  // Create a new lottery document
  const newLotteryRef = db.collection("lottery").doc();

  batch.set(newLotteryRef, {
    "time_end": endTime.toISOString(),
    "create_at": new Date().toISOString(),
    "status": true,
    "prize": 0,
    "totalticket": 0,
  });

  batch.update(newLotteryRef, {"lottery_id": newLotteryRef.id});

  await batch.commit();
}
