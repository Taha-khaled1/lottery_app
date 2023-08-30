// import 'package:get/get.dart';

import 'package:get/get_navigation/src/root/internacionalization.dart';

class MyTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          "lang": "اختر اللغة",
          "vent": "فضفض",
          "edit_account": "تعديل الحساب",
          "share_app": "مشاركة التطبيق",
          "privacy_policy": "سياسة الخصوصية",
          "terms_and_conditions": "الشروط والأحكام",
          "logout": "تسجيل الخروج",
          "delete_account": "حذف الحساب",
          "name": "الاسم",
          "country": "الدولة",
          "save_changes": "حفظ التغييرات",
          "home": "البيت",
          "account": "الحساب",
          "login_with_google": "المتابعة بواسطة حساب جوجل",
          "login_with_facebook": "المتابعة بواسطة حساب فيسبوك",
          "best_community":
              "المجتمع الأفضل للتحدث مع أشخاص عشوائيين بسرعة وسرية تامة",
          "welcome": "أهلاً وسهلاً",
          "delete_account_message":
              "سيتم حذف حسابك نهائياً من قاعدة البيانات الخاصة بنا",
          "delete_account_confirmation": "هل أنت متأكد من حذف الحساب؟",
          "cancel": "تراجع",
          "delete_account_warning":
              "سيتم حذف حسابك نهائياً من قاعدة البيانات الخاصة بنا في خلال 30 يومًا من الآن، ويمكنك الدخول إليه في هذه الفترة.",
          "status": "الحالة",
          "yes": "نعم",
          "change": "تغيير",
          "search": "البحث",
          "pricontaent": privContaentAR,
          "termsontaent": termsAR,
          "doexist": "هل تريد الخروج من التطبيق",
          "male": "ذكر",
          "female": "أنثى",
          "all": "الكل",
          "delete": "حذف",
          "friends": "الاصدقاء",
          "user_added": 'تم اضافة المستخدم بنجاح',
          "user_deleted": 'تم حذف المستخدم بنجاح',
          "agree_privacy_policy": 'أوافق على شروط الخدمة وسياسة الخصوصية',
          "agree": "اوافق",
          "refuse": "رفض",
          "edit_profile_succss": "تم تحديث بيانات الحساب بنجاح",
          "no_users_found": "لا يوجد مستخدمين متوفرين الان",
          "try_again": "ارجوك حاول في وقت لاحق",
          "worldwide": "جميع العالم",
          "image_sent": "صوره",
          "search_for_best_match": "البحث عن أفضل تطابق لك",
          "bypass": "تجاوز",
          "correspondence": "مراسله",
          // "name": "الاسم",
          "gender": "النوع",

          "your_friends": "اصدقاؤك",
          "friendship_requests": "طلبات الصداقه",

          "write_massge": "اكتب رسالتك",
          // "country": "الدوله",
          "users": "المستخدمين",
          "user": "المستخدم", "audio_sent": "رساله صوتيه",
          "chat_request": "تم ارسال طلب محادثه",
          "currency": "عملة",
          "currencies": "عملات",
          "your_currencies": "عملاتك",
          "getting_currencies": "الحصول على عملات",
          "age": "العمر",
          "write_your_age": "اكتب عمرك",
          "watching_ads": "مشاهدة الإعلان",
          "you_have_won": "لقد ربحت ",
          "you_got": "لقد حصلت ",
          "show_ad_before_loaded": "تحذير: محاولة إظهار الاعلان قبل التحميل",
          "ad_loaded": "يتم تحميل الاعلان ",
          "something_wrong": "يوجد خطاء ما",
          "quantity": "الكميه ",
        },
        "en": {
          "you_have_won": "You have won",
          "you_got": "you got",
          "show_ad_before_loaded": "Warning: attempt to show ad before loaded",
          "ad_loaded": "The ad is being loaded",
          "something_wrong": "Something went wrong",
          "quantity": "Quantity",

          "your_currencies": "Your currencies",
          "currency": "Currency",
          "currencies": "Currencies",
          "getting_currencies": "Getting Currencies",
          "age": "Age",
          "write_your_age": "Write your age",
          "watching_ads": "Watching ads",

          "your_friends": "Your friends",
          "friendship_requests": "Friendship Requests",
          "write_massge": "write your message",
          "audio_sent": "voice message",
          "chat_request": "A chat request has been sent.",
          "bypass": "bypass",
          "correspondence": "correspondence",
          // "name": "name",
          "gender": "gender",
          // "country": "country",
          "users": "users",
          "user": "user",
          "image_sent": "image",
          "edit_profile_succss": "Account information updated successfully",
          "delete": "delete",
          "friends": "Friends",
          "user_added": 'User added successfully',
          'user_deleted': 'User deleted successfully',
          "no_users_found": "No users found",
          "try_again": "Please try again later.",
          "agree_privacy_policy.":
              "I agree to the terms of service and privacy policy.",
          "agree": "Agree",
          "refuse": "Refuse",
          "male": "Male",
          "female": "Female",
          "all": "All",
          "worldwide": "Worldwide",
          "search_for_best_match": "Search for the best match for you",
          "lang": "Choose Language",
          "yes": "yes",
          "doexist": 'Do you want to exit the app?',
          "vent": "Vent",
          "edit_account": "Edit Account",
          "share_app": "Share App",
          "privacy_policy": "Privacy Policy",
          "terms_and_conditions": "Terms and Conditions",
          "logout": "Logout",
          "delete_account": "Delete Account",
          "name": "Name",
          "country": "Country",
          "save_changes": "Save Changes",
          "home": "Home",
          "account": "Account",
          "login_with_google": "Login with Google",
          "login_with_facebook": "Login with Facebook",
          "best_community":
              "The best community to chat with random people quickly and with complete privacy",
          "welcome": "Welcome",
          "delete_account_message":
              "Your account will be permanently deleted from our database",
          "delete_account_confirmation":
              "Are you sure you want to delete your account?",
          "cancel": "Cancel",
          "delete_account_warning":
              "Your account will be permanently deleted from our database within 30 days from now, and you can access it during this time.",
          "status": "Status",
          "change": "Change",
          "pricontaent": privContaentEN,
          "termsontaent": termsEN,
          "search": "Search"
        }
      };
}

String privContaentAR = '''
        
        
    <!DOCTYPE html >
<html  dir="rtl" lang="ar">
<head>
  <title>سياسة الخصوصية</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      line-height: 1.5;
    }

    h1 {
      color: #fff;
      font-size: 24px;
    }

    h2 {
      color: #fff;
      font-size: 18px;
    }

    p {
      color: #777;
      font-size: 16px;
    }

    ul {
      color: #777;
      font-size: 16px;
      list-style-type: disc;
      padding-left: 20px;
    }
  </style>
</head>
<body>
  <h1>سياسة الخصوصية</h1>

  <h2>مقدمة</h2>
  <p>
    نحن في [اسم الموقع] نحرص على خصوصيتك ونتفهم أهمية حماية معلوماتك الشخصية. تحترم هذه السياسة خصوصية المستخدمين لدينا وتوضح كيفية جمعنا واستخدامنا وحمايتنا لمعلوماتهم.
  </p>

  <h2>المعلومات التي نجمعها</h2>
  <p>
    يجمع [اسم الموقع] المعلومات التي تقدمها عند التسجيل في التطبيق، بما في ذلك اسم المستخدم وعنوان البريد الإلكتروني. نحن أيضًا نجمع معلومات تقنية مثل عنوان IP ومعلومات المتصفح لتحسين خدماتنا وتوفير تجربة أفضل للمستخدمين.
  </p>

  <h2>استخدام المعلومات</h2>
  <p>
    تستخدم [اسم الموقع] المعلومات التي نجمعها لتقديم وتحسين خدماتنا، بما في ذلك توفير محادثات عشوائية بين المستخدمين وإدارة حسابات المستخدمين. قد نستخدم المعلومات أيضًا للتواصل معك بشأن تحديثات أو إشعارات مهمة.
  </p>

  <h2>الحفاظ على الخصوصية</h2>
  <p>
    نحن نلتزم بحماية خصوصيتك ونضمن أمان المعلومات الشخصية التي تقدمها لنا. نحن نتخذ إجراءات أمنية مناسبة لحماية المعلومات من الوصول غير المصرح به أو الاستخدام أو التغيير أو الكشف.
  </p>

  <h2>مشاركة المعلومات</h2>
  <p>
    نحن لا نبيع أو نشارك المعلومات الشخصية للمستخدمين مع أطراف ثالثة بدون موافقتهم، باستثناء الحالات التي يُطلب فيها ذلك بموجب القانون أو لتنفيذ شروط استخدامنا.
  </p>

  <h2>التحديثات على السياسة</h2>
  <p>
    قد نقوم بتحديث سياسة الخصوصية هذه من حين لآخر. سنقوم بنشر أي تغييرات على هذه الصفحة ونوصي المستخدمين بمراجعة الصفحة بانتظام للاطلاع على أحدث المعلومات.
  </p>

  <h2>اتصل بنا</h2>
  <p>
    إذا كان لديك أي أسئلة أو استفسارات حول سياسة الخصوصية، يرجى الاتصال بنا عبر [إدراج معلومات الاتصال].
  </p>
</body>
</html>

        
        
        ''';
String privContaentEN = '''


<!DOCTYPE html>
<html dir="ltr" lang="en">
<head>
  <title>Privacy Policy</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      line-height: 1.5;
    }

    h1 {
      color: #fff;
      font-size: 24px;
    }

    h2 {
      color: #fff;
      font-size: 18px;
    }

    p {
      color: #777;
      font-size: 16px;
    }

    ul {
      color: #777;
      font-size: 16px;
      list-style-type: disc;
      padding-left: 20px;
    }
  </style>
</head>
<body>
  <h1>Privacy Policy</h1>

  <h2>Introduction</h2>
  <p>
    We at [Website Name] value your privacy and understand the importance of protecting your personal information. This policy respects the privacy of our users and explains how we collect, use, and safeguard their information.
  </p>

  <h2>Information We Collect</h2>
  <p>
    [Website Name] collects the information you provide when registering on the application, including your username and email address. We also collect technical information such as IP address and browser information to improve our services and provide a better user experience.
  </p>

  <h2>Use of Information</h2>
  <p>
    [Website Name] uses the collected information to provide and enhance our services, including facilitating random conversations between users and managing user accounts. We may also use the information to communicate with you regarding updates or important notifications.
  </p>

  <h2>Privacy Protection</h2>
  <p>
    We are committed to protecting your privacy and ensuring the security of the personal information you provide to us. We take appropriate security measures to protect the information from unauthorized access, use, alteration, or disclosure.
  </p>

  <h2>Information Sharing</h2>
  <p>
    We do not sell or share users' personal information with third parties without their consent, except in cases where it is required by law or to enforce our terms of use.
  </p>

  <h2>Updates to the Policy</h2>
  <p>
    We may update this privacy policy from time to time. Any changes will be posted on this page, and we encourage users to review the page regularly for the latest information.
  </p>

  <h2>Contact Us</h2>
  <p>
    If you have any questions or inquiries about the privacy policy, please contact us via [insert contact information].
  </p>
</body>
</html>




''';
String termsAR = '''

<!DOCTYPE html>
<html  dir="rtl" lang="ar">
<head>
  <title>شروط وأحكام</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      line-height: 1.5;
    }

    h1 {
      color: #fff;
      font-size: 24px;
    }

    h2 {
      color: #fff;
      font-size: 18px;
    }

    p {
      color: #777;
      font-size: 16px;
    }

    ul {
      color: #777;
      font-size: 16px;
      list-style-type: disc;
      padding-left: 20px;
    }
  </style>
</head>
<body>
  <h1>شروط وأحكام</h1>

  <p>يرجى قراءة هذه الشروط والأحكام بعناية قبل استخدام التطبيق.</p>

  <h2>1. قبول الشروط</h2>
  <p>باستخدام هذا التطبيق، فإنك توافق على هذه الشروط والأحكام بالكامل وتلتزم بها.</p>

  <h2>2. الاستخدام الصحيح</h2>
  <p>يجب عليك استخدام التطبيق فقط للأغراض المشروعة ووفقًا للقوانين واللوائح المعمول بها.</p>

  <h2>3. الحقوق الملكية</h2>
  <p>يحتفظ التطبيق بجميع حقوق الملكية الفكرية المتعلقة بالمحتوى والعلامات التجارية والشعارات والأيقونات والصور والنصوص وأي عناصر أخرى تظهر في التطبيق.</p>

  <h2>4. السلوك غير المقبول</h2>
  <p>لا يُسمح بالتصرف بطرق غير مقبولة في التطبيق، بما في ذلك الاحتيال والتلاعب والتعدي على خصوصية المستخدمين الآخرين والترويج للمحتوى غير الملائم.</p>

  <h2>5. التعويض</h2>
  <p>توافق على تعويض وحماية التطبيق وأصحابه وموظفيه والتعويض عن أي مطالبات أو خسائر أو أضرار أو مسؤوليات (بما في ذلك الرسوم القانونية المعقولة) الناجمة عن استخدامك للتطبيق.</p>

  <h2>6. التغييرات على الشروط</h2>
  <p>يحق لنا تحديث هذه الشروط والأحكام من وقت لآخر. سيتم نشر أي تغييرات على هذه الصفحة، وسيتم تطبيق التغييرات فور نشرها.</p>

  <h2>7. الاتصال</h2>
  <p>إذا كان لديك أي أسئلة أو استفسارات حول شروط وأحكام التطبيق، يرجى الاتصال بنا عبر [إدراج معلومات الاتصال].</p>
</body>
</html>



''';
String termsEN = '''

<!DOCTYPE html>
<html dir="ltr" lang="en">
<head>
  <title>Terms and Conditions</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 20px;
      line-height: 1.5;
    }

    h1 {
      color: #fff;
      font-size: 24px;
    }

    h2 {
      color: #fff;
      font-size: 18px;
    }

    p {
      color: #777;
      font-size: 16px;
    }

    ul {
      color: #777;
      font-size: 16px;
      list-style-type: disc;
      padding-left: 20px;
    }
  </style>
</head>
<body>
  <h1>Terms and Conditions</h1>

  <p>Please read these terms and conditions carefully before using the application.</p>

  <h2>1. Acceptance of Terms</h2>
  <p>By using this application, you fully accept and agree to these terms and conditions.</p>

  <h2>2. Proper Use</h2>
  <p>You must use the application only for lawful purposes and in accordance with applicable laws and regulations.</p>

  <h2>3. Intellectual Property Rights</h2>
  <p>The application retains all intellectual property rights related to the content, trademarks, logos, icons, images, texts, and any other elements appearing in the application.</p>

  <h2>4. Unacceptable Behavior</h2>
  <p>Unacceptable behavior in the application, including fraud, manipulation, infringement on the privacy of other users, and promotion of inappropriate content, is strictly prohibited.</p>

  <h2>5. Indemnification</h2>
  <p>You agree to indemnify and hold harmless the application, its owners, employees, and affiliates from any claims, losses, damages, or liabilities (including reasonable legal fees) arising out of your use of the application.</p>

  <h2>6. Changes to the Terms</h2>
  <p>We reserve the right to update these terms and conditions from time to time. Any changes will be posted on this page, and the changes will be effective immediately upon posting.</p>

  <h2>7. Contact</h2>
  <p>If you have any questions or inquiries regarding the terms and conditions, please contact us via [insert contact information].</p>
</body>
</html>



''';
