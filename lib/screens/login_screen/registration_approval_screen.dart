import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:flutter/material.dart';

class RegistrationApproval extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      'Registration Sent',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: PRIMARY_COLOR, fontSize: 36),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: contentText(
                        'Your registration has been sent for approval. The administrator will verify the details you provided.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: contentText(
                        'You’ll be able to access your account once the administrator approves your request.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: contentText(
                        'You will be contacted by the administrator shortly.'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 120.0),
                    child: contentText('For any clarifications,'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: contentText('You can call us at'),
                  ),
                  Text(
                    '+91 995567434',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: contentText('or email us at'),
                  ),
                  Text(
                    'admin@appname.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 140.0),
                    child: contentText(
                        'You can access this information anytime by selecting ‘Contact Us’ from the login screen.'),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: PRIMARY_COLOR.withOpacity(0.3), width: 1),
                  ),
                  color: WHITE_COLOR),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24.0, right: 24.0, top: 12.0, bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    PrimaryButtonWidget(
                      buttonText: 'Got it',
                      onPressed: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentText(content) {
    return Text(
      content,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }
}
