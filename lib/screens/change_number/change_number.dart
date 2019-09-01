import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/otp/otp.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class ChangeNumber extends StatefulWidget {
  @override
  _ChangeNumber createState() => _ChangeNumber();
}

class _ChangeNumber extends State<ChangeNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: layout(),
    );
  }

  Widget layout() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        backButton(),
        texts(),
        textFields(),
        continueButton(),
      ],
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

  Widget texts() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 24, right: 24),
      child: Column(
        children: <Widget>[
          text("Change your Number", 30, PRIMARY_COLOR, false),
          Container(padding: EdgeInsets.only(top: 24)),
          text(
              "Enter your new phone number to use for login purposes. This will not be used for delivery.",
              14,
              BLACK_COLOR,
              false),
        ],
      ),
    );
  }

  Widget textFields() {
    return Container(
      padding: EdgeInsets.all(24),
      child: CustomTextField(
        hintText: "New Phone Number",
        obscureText: false,
        onChanged: (val) {},
      ),
    );
  }

  Widget continueButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(24),
          child: PrimaryButtonWidget(
            buttonText: "Continue",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OTPScreen()),
              );
            },
          ),
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
      textAlign: TextAlign.center,
    );
  }
}
