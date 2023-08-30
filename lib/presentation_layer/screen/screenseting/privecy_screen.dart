import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';
import 'package:free_lottery/presentation_layer/resources/strings_manager.dart';
import 'package:free_lottery/presentation_layer/src/components_packge.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      backgroundColor: ColorManager.background,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Html(data: '''

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
      color: #7206FC;
      font-size: 24px;
    }

    h2 {
      color: #7206FC;
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
    We at Timekeeping pro value your privacy and understand the importance of protecting your personal information. This policy respects the privacy of our users and explains how we collect, use, and safeguard their information.
  </p>

  <h2>Information We Collect</h2>
  <p>
    Timekeeping pro collects the information you provide when registering on the application, including your username and email address. We also collect technical information such as IP address and browser information to improve our services and provide a better user experience.
  </p>

  <h2>Use of Information</h2>
  <p>
    Timekeeping pro uses the collected information to provide and enhance our services, including facilitating random conversations between users and managing user accounts. We may also use the information to communicate with you regarding updates or important notifications.
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
    If you have any questions or inquiries about the privacy policy, please contact us via email.
  </p>
</body>
</html>


'''),
            ],
          ),
        ),
      ),
    );
  }
}
