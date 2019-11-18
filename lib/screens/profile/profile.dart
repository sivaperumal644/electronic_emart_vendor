import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/amount_to_pay_widget.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/setting_option.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/modals/User.dart';
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
import 'package:url_launcher/url_launcher.dart';

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

  Widget mainList(String storeName, String phoneNumber, String addressLine,
      String city, double amountToPay) {
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
        AmountToBePaid(amountToPay: amountToPay),
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
        getAdminInfo(),
        Container(padding: EdgeInsets.only(top: 3)),
        // InkWell(
        //   onTap: () async {
        //     final prefs = await SharedPreferences.getInstance();
        //     await prefs.clear();

        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => LoginScreen(),
        //       ),
        //     );
        //   },
        //   child: SettingsOption(
        //     title: 'Log Out',
        //     color: BLACK_COLOR,
        //   ),
        // ),
        notifyMutationComponent(),
        Container(padding: EdgeInsets.only(top: 3)),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(24.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'About app',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: PRIMARY_COLOR.withOpacity(0.75)),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(height: 16),
                        Image.asset(
                          'assets/images/app_logo.png',
                          width: 150,
                          height: 150,
                        ),
                        Text(
                          '© BeShoppi 2019',
                          style: TextStyle(
                            color: BLACK_COLOR,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          width: MediaQuery.of(context).size.width,
                          height: 0.5,
                          color: PRIMARY_COLOR.withOpacity(0.7),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/images/flutter_logo.png'),
                              Container(width: 12),
                              Text(
                                'Made with Flutter',
                                style: TextStyle(
                                  color: PRIMARY_COLOR,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(height: 12),
                        GestureDetector(
                          onTap: () {
                            launch(
                                'https://roshanrahman.github.io/emart-web/about.html');
                          },
                          child: Text(
                            'About the developers',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: PRIMARY_COLOR,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          width: MediaQuery.of(context).size.width,
                          height: 0.5,
                          color: PRIMARY_COLOR.withOpacity(0.7),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 16),
                          child: PrimaryButtonWidget(
                            buttonText: 'Okay',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
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

  Widget helpLineAndMailButton(
      email, phoneNumber1, phoneNumber2, phoneNumber3) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            launchURL(email, 'Regarding Be Shoppi Vendor App', 'Write here');
          },
          child: SettingsOption(
            title: 'Mail your queries',
            color: BLACK_COLOR,
          ),
        ),
        Container(padding: EdgeInsets.only(top: 3)),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  title: Text(
                    'Choose a number',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(height: 6),
                      phoneNumberRow(phoneNumber1),
                      phoneNumberRow(phoneNumber2),
                      phoneNumberRow(phoneNumber3),
                    ],
                  ),
                );
              },
            );
          },
          child: SettingsOption(
            title: 'Help Line',
            color: BLACK_COLOR,
          ),
        ),
      ],
    );
  }

  Widget phoneNumberRow(String number) {
    if (number != null)
      return InkWell(
        onTap: () {
          launch("tel://$number");
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                number,
                style: TextStyle(
                  color: BLACK_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.call),
            ],
          ),
        ),
      );
    else
      return Container();
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

  launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget addressContainer(
      String storeName, String addressLine, String city, String phoneNumber) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: PRIMARY_COLOR.withOpacity(0.5)),
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

  Widget getAdminInfo() {
    return Query(
      options: QueryOptions(
        document: getVendorInfoQuery,
        fetchPolicy: FetchPolicy.noCache,
        pollInterval: 1,
      ),
      builder: (QueryResult result, {VoidCallback refetch}) {
        if (result.hasErrors)
          return Center(child: Text("Oops something went wrong"));
        if (result.data != null &&
            result.data['getVendorInfo']['user'] != null) {
          final user = User.fromJson(result.data['getVendorInfo']['user']);
          return helpLineAndMailButton(user.email, user.phoneNumber,
              user.alternativePhone1, user.alternativePhone2);
        }
        return Container();
      },
    );
  }

  Widget getVendorInfo() {
    final appState = Provider.of<AppState>(context);
    return Query(
      options: QueryOptions(
        document: getVendorInfoQuery,
        fetchPolicy: FetchPolicy.noCache,
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
          return mainList(
            user.storeName,
            user.phoneNumber,
            user.addressType['addressLine'],
            user.addressType['city'],
            double.parse(user.amountToPay),
          );
        }
        return Container();
      },
    );
  }

  Widget notifyMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
        options: MutationOptions(
          document: fcmIntegerateToken,
          context: {
            'headers': <String, String>{
              'Authorization': 'Bearer ${appState.jwtToken}',
            },
          },
        ),
        builder: (
          RunMutation runMutation,
          QueryResult result,
        ) {
          return InkWell(
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              runMutation({"fcmToken": null});
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: SettingsOption(
              title: 'Log Out',
              color: BLACK_COLOR,
            ),
          );
        },
        update: (Cache cache, QueryResult result) {
          return cache;
        },
        onCompleted: (dynamic resultData) async {
          print(resultData);
        });
  }
}
