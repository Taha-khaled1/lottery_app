import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:free_lottery/presentation_layer/components/appbar.dart';
import 'package:free_lottery/presentation_layer/resources/color_manager.dart';

class TermsAndConditionsPage extends StatelessWidget {
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
  <title>Terms and Conditions</title>
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
  <p>If you have any questions or inquiries regarding the terms and conditions, please contact us via email.</p>
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
