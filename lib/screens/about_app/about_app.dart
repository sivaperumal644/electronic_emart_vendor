import 'package:electronic_emart_vendor/components/secondary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 24, top: 42),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    FeatherIcons.arrowLeft,
                    color: PRIMARY_COLOR,
                  ),
                ),
              ),
              Container(padding: EdgeInsets.only(top: 24)),
              Center(
                child: Image.asset(
                  'assets/images/place_holder.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.fill,
                ),
              ),
              Container(padding: EdgeInsets.only(top: 24)),
              Center(
                child: Text(
                  'App Name',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'v 1.0',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: PRIMARY_COLOR,
                  ),
                ),
              ),
              Container(padding: EdgeInsets.only(top: 24)),
              Center(
                child: Text(
                  'App Tagline',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.all(24),
                child: Text(
                  'DEVELOPED BY',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: PRIMARY_COLOR),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'TEAM ',
                    style: TextStyle(
                        color: GREY_COLOR,
                        fontSize: 28,
                        fontFamily: 'IBMPlexMono'),
                  ),
                  Text(
                    '/',
                    style: TextStyle(
                      fontSize: 28,
                      color: GREY_COLOR,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IBMPlexMono',
                    ),
                  ),
                  Text(
                    '404FOUND',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IBMPlexMono',
                    ),
                  ),
                  Text(
                    '/',
                    style: TextStyle(
                      fontSize: 28,
                      color: GREY_COLOR,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IBMPlexMono',
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
              ),
              Center(
                child: SecondaryButton(
                  buttonText: 'About us',
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/flutter_logo.png'),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Made with Flutter',
                      style: TextStyle(
                        color: PRIMARY_COLOR,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
