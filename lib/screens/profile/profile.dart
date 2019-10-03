import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/setting_option.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/User.dart';
import 'package:electronic_emart_vendor/screens/about_app/about_app.dart';
import 'package:electronic_emart_vendor/screens/change_bank_details/change_bank_details.dart';
import 'package:electronic_emart_vendor/screens/change_number/change_number.dart';
import 'package:electronic_emart_vendor/screens/edit_address/edit_address.dart';
import 'package:electronic_emart_vendor/screens/edit_name/edit_name.dart';
import 'package:electronic_emart_vendor/screens/login/login.dart';
import 'package:electronic_emart_vendor/screens/profile/profile_graphql.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: getVendorInfo(),
    );
  }

  Widget mainList(
      String storeName, String phoneNumber, String addressLine, String city) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Container(padding: EdgeInsets.only(top: 20)),
        textWidget('Profile', TextAlign.center, BLACK_COLOR, 16),
        Container(padding: EdgeInsets.only(top: 40)),
        textWidget(storeName, TextAlign.center, PRIMARY_COLOR, 24),
        textWidget(phoneNumber, TextAlign.center, BLACK_COLOR, 16),
        Container(padding: EdgeInsets.only(top: 20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TertiaryButton(
              text: 'Edit Name',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditName()),
                );
              },
            ),
          ],
        ),
        addressContainer(storeName, addressLine, city, phoneNumber),
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
        Container(padding: EdgeInsets.only(top: 3)),
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
        Container(padding: EdgeInsets.only(top: 3)),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangeBankDetails()),
            );
          },
          child: SettingsOption(
            title: 'Change Bank Details',
            color: BLACK_COLOR,
          ),
        ),
        Container(padding: EdgeInsets.only(top: 3)),
        InkWell(
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
          child: SettingsOption(
            title: 'Log Out',
            color: BLACK_COLOR,
          ),
        ),
        Container(padding: EdgeInsets.only(top: 3)),
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

  Widget addressContainer(
      String storeName, String addressLine, String city, String phoneNumber) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: PRIMARY_COLOR.withOpacity(0.13)),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: <Widget>[
          textWidget('Your Address', TextAlign.start, PRIMARY_COLOR, 18),
          Container(margin: EdgeInsets.only(top: 20)),
          textWidget(storeName, TextAlign.start, BLACK_COLOR, 16),
          textWidget(addressLine, TextAlign.start, BLACK_COLOR, 16),
          textWidget(city, TextAlign.start, BLACK_COLOR, 16),
          textWidget(phoneNumber, TextAlign.start, PRIMARY_COLOR, 16),
        ],
      ),
    );
  }

  Widget getVendorInfo() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getVendorInfoQuery,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
        pollInterval: 3,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null &&
            result.data['getVendorInfo']['user'] != null) {
          final user = User.fromJson(result.data['getVendorInfo']['user']);
          return mainList(user.storeName, user.phoneNumber,
              user.addressType['addressLine'], user.addressType['city']);
        }
        return Container();
      },
    );
  }
}
