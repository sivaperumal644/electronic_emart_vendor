import 'package:electronic_emart_vendor/components/dialog_style.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/login/login.dart';
import 'package:electronic_emart_vendor/screens/otp/otp.dart';
import 'package:electronic_emart_vendor/screens/registration/validate_vendor_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String phoneNumber = '';
  String newPassword = '';
  String confirmNewPassword = '';
  bool isButtonClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: layout());
  }

  Widget layout() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        backButton(),
        texts(),
        Container(height: 12),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: CustomTextField(
            hintText: 'Phone Number',
            keyboardType: TextInputType.number,
            obscureText: false,
            counterText:
                'An OTP will be sent to this number. Please keep it ready.',
            onChanged: (val) {
              setState(() {
                phoneNumber = val;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: CustomTextField(
            hintText: 'New Password',
            obscureText: true,
            onChanged: (val) {
              setState(() {
                newPassword = val;
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: CustomTextField(
            hintText: 'Confirm New Password',
            obscureText: true,
            onChanged: (val) {
              setState(() {
                confirmNewPassword = val;
              });
            },
          ),
        ),
        isButtonClicked
            ? Container(
                padding: EdgeInsets.only(top: 40),
                child: CupertinoActivityIndicator(),
              )
            : validateVendorArgumentMutation()
      ],
    );
  }

  Widget backButton() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 24, left: 12),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
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
      padding: EdgeInsets.only(top: 20, left: 24, right: 24),
      child: Column(
        children: <Widget>[
          text("Change your Password", 30, PRIMARY_COLOR, false),
          Container(padding: EdgeInsets.only(top: 24)),
          text(
            "You can change your password in case you have forgotten it. Please enter your phone number for which you have to change the password and the new password.",
            14,
            BLACK_COLOR,
            false,
          ),
        ],
      ),
    );
  }

  Widget continueButton(RunMutation runMutation) {
    final snackbar = SnackBar(content: Text('Enter all the required fields'));
    final snackbarPhoneNumberLength =
        SnackBar(content: Text('Enter valid phone number'));
    final snackbarPasswordMismatch =
        SnackBar(content: Text('Password and confirm password does not match'));
    final snackbarPasswordLenght =
        SnackBar(content: Text('Password should be minimum of 6 characters'));
    return Container(
      padding: EdgeInsets.all(24),
      child: Builder(
        builder: (buildContext) => PrimaryButtonWidget(
          buttonText: "Continue",
          onPressed: () {
            if (phoneNumber == '' ||
                newPassword == '' ||
                confirmNewPassword == '') {
              Scaffold.of(context).showSnackBar(snackbar);
            } else if (phoneNumber.length < 10) {
              Scaffold.of(context).showSnackBar(snackbarPhoneNumberLength);
            } else if (newPassword.length < 6) {
              Scaffold.of(context).showSnackBar(snackbarPasswordLenght);
            } else if (newPassword != confirmNewPassword) {
              Scaffold.of(context).showSnackBar(snackbarPasswordMismatch);
            } else {
              setState(() {
                isButtonClicked = true;
              });
              runMutation({'phoneNumber': phoneNumber});
            }
          },
        ),
      ),
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

  Widget validateVendorArgumentMutation() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: validateVendorArguments,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
      ),
      builder: (runMutation, result) {
        return continueButton(runMutation);
      },
      onCompleted: (dynamic resultData) {
        if (resultData['validateVendorArguments']['errors'] == null) {
          if (!resultData['validateVendorArguments']['phoneNumber']) {
            setState(() {
              isButtonClicked = false;
            });
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return DialogStyle(
                  titleMessage: 'The phone number does not exist',
                  contentMessage:
                      'The phone number you have entered does not exist. Please use correct phone number to change your password.',
                  isRegister: false,
                );
              },
            );
          } else {
            setState(() {
              isButtonClicked = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPScreen(
                  phoneNumber: phoneNumber,
                  onOTPIncorrect: () {},
                  onOTPSuccess: () async {
                    final result = await appState.changePasswordMutation(
                        phoneNumber, newPassword);
                    if (result.data["updateVendorAccount"]['errors'] == null) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                        (val) => false,
                      );
                    }
                  },
                ),
              ),
            );
          }
        }
      },
    );
  }
}
