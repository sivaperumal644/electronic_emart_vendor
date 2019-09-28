import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationSent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Container(margin: EdgeInsets.only(top: 50.0)),
                  Text(
                    'Registration Sent',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: PRIMARY_COLOR, fontSize: 36),
                  ),
                  Container(margin: EdgeInsets.only(top: 50.0)),
                  contentText(
                    'Your registration has been sent for approval. The administrator will verify the details you provided.',
                  ),
                  Container(margin: EdgeInsets.only(top: 16.0)),
                  contentText(
                    'You’ll be able to access your account once the administrator approves your request.',
                  ),
                  Container(margin: EdgeInsets.only(top: 16.0)),
                  contentText(
                    'You will be contacted by the administrator shortly.',
                  ),
                  Container(margin: EdgeInsets.only(top: 120.0)),
                  contentText('For any clarifications,'),
                  Container(margin: EdgeInsets.only(top: 12.0)),
                  contentText('You can call us at'),
                  Text(
                    '+91 995567434',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 16.0)),
                  contentText('or email us at'),
                  Text(
                    'admin@appname.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 16.0, bottom: 90.0)),
                  contentText(
                      'You can access this information anytime by selecting ‘Contact Us’ from the login screen.'),
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
                      onPressed: () {
                        appState.setPanBackUrl(null);
                        appState.setPanFrontUrl(null);
                        appState.setShopPhotoUrl(null);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
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
