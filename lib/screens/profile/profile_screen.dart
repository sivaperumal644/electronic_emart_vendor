import 'package:electronic_emart_vendor/components/setting_option.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/about_app/about_app.dart';
import 'package:electronic_emart_vendor/screens/change_number/change_number.dart';
import 'package:electronic_emart_vendor/screens/edit_address/edit_address.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(padding: EdgeInsets.only(top: 20)),
          textWidget('Profile', TextAlign.center, BLACK_COLOR, 16),
          Container(padding: EdgeInsets.only(top: 40)),
          textWidget('Arthur Morgan', TextAlign.center, PRIMARY_COLOR, 24),
          textWidget('+91 9988778899', TextAlign.center, BLACK_COLOR, 16),
          Container(padding: EdgeInsets.only(top: 20)),
          textWidget('Edit Name', TextAlign.center, PRIMARY_COLOR, 16),
          addressContainer(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditAddress()),
              );
            },
            child: SettingsOption(
              title: 'Edit your Address',
              color: BLACK_COLOR,
            ),
          ),
          Container(padding: EdgeInsets.only(top: 10)),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangeNumber()),
              );
            },
            child: SettingsOption(
              title: 'Change Phone Number',
              color: BLACK_COLOR,
            ),
          ),
          Container(padding: EdgeInsets.only(top: 10)),
          SettingsOption(
            title: 'Log Out',
            color: BLACK_COLOR,
          ),
          Container(padding: EdgeInsets.only(top: 10)),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutApp()),
              );
            },
            child: SettingsOption(
              title: 'About app',
              color: PRIMARY_COLOR,
            ),
          )
        ],
      ),
    );
  }

  Widget textWidget(
      String text, TextAlign textAlign, Color color, double size) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget addressContainer() {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: PRIMARY_COLOR.withOpacity(0.13)),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: <Widget>[
          textWidget('Your Address', TextAlign.start, PRIMARY_COLOR, 18),
          textWidget('This will be used for delivery', TextAlign.start,
              PRIMARY_COLOR.withOpacity(0.35), 12),
          Container(margin: EdgeInsets.only(top: 20)),
          textWidget('Mr. Vineesh', TextAlign.start, BLACK_COLOR, 16),
          textWidget('10/45, ABC Street, Lorem Ipsum,', TextAlign.start,
              BLACK_COLOR, 16),
          textWidget('Coimbatore - 456067', TextAlign.start, BLACK_COLOR, 16),
          textWidget('+91 8898896969', TextAlign.start, PRIMARY_COLOR, 16),
        ],
      ),
    );
  }
}
