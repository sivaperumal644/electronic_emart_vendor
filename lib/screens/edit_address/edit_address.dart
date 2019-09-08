import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class EditAddress extends StatefulWidget {
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
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
      ],
    );
  }

  Widget backButton() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 24, top: 24, bottom: 16),
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
      ],
    );
  }

  Widget texts() {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 0, 24, 10),
      child: Column(
        children: <Widget>[
          text("Edit your Address", 30, PRIMARY_COLOR, false),
          Container(padding: EdgeInsets.only(top: 16)),
          text(
            "Please enter your details carefully.",
            14,
            BLACK_COLOR,
            false,
          )
        ],
      ),
    );
  }

  Widget textFields() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          CustomTextField(
            hintText: "Address",
            obscureText: false,
            onChanged: (val) {},
          ),
          SizedBox(height: 20),
          CustomTextField(
            hintText: "City",
            obscureText: false,
            onChanged: (val) {},
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            child: PrimaryButtonWidget(
              buttonText: "Save Changes",
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget text(String title, double size, Color color, bool isBold) {
    return Text(
      "$title",
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : null,
      ),
      textAlign: TextAlign.center,
    );
  }
}
