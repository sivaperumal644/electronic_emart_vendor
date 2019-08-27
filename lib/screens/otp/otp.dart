import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/nav_screens.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: layout(),
    );
  }

  Widget layout() {
    return Column(
      children: <Widget>[
        Container(padding: EdgeInsets.only(top: 20)),
        backButton(),
        Container(padding: EdgeInsets.only(top: 20)),
        text("Enter OTP", 30, PRIMARY_COLOR, false),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Text(
              "OTP Sent to +91 8899889988. Please enter the OTP to continue.",
              style: TextStyle(fontSize: 14, color: BLACK_COLOR),
              textAlign: TextAlign.center),
        ),
        SizedBox(height: 20),
        CustomTextField(
          hintText: "OTP",
          onChanged: (val) {},
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TertiaryButton(text: "Resend OTP", onPressed: () {}),
            PrimaryButtonWidget(
              buttonText: "Verify",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigateScreens(),
                  ),
                );
              },
            )
          ],
        )
      ],
    );
  }

  Widget text(String title, double size, Color color, bool isBold) {
    return Text(
      "$title",
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: isBold ? FontWeight.bold : null),
    );
  }

  Widget backButton() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 24, left: 24),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(FeatherIcons.arrowLeft, color: PRIMARY_COLOR),
          ),
        ),
      ],
    );
  }
}
