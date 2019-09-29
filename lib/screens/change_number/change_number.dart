import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/dialog_style.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/otp/otp.dart';
import 'package:electronic_emart_vendor/screens/profile/profile_graphql.dart';
import 'package:electronic_emart_vendor/screens/registration/validate_vendor_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class ChangeNumber extends StatefulWidget {
  @override
  _ChangeNumber createState() => _ChangeNumber();
}

class _ChangeNumber extends State<ChangeNumber> {
  String phoneNumber = "";
  bool isNumberExist = false;
  bool isButtonClicked = false;

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
        isButtonClicked
            ? CupertinoActivityIndicator()
            : changePhoneNumberMutation()
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
          text("Change your Number", 30, PRIMARY_COLOR, false),
          Container(padding: EdgeInsets.only(top: 24)),
          text(
            "Enter your new phone number to use for login purposes. This will not be used for delivery.",
            14,
            BLACK_COLOR,
            false,
          ),
        ],
      ),
    );
  }

  Widget textFields() {
    return Container(
      padding: EdgeInsets.all(24),
      child: CustomTextField(
        hintText: "New Phone Number",
        keyboardType: TextInputType.number,
        obscureText: false,
        onChanged: (val) {
          phoneNumber = val;
        },
      ),
    );
  }

  Widget continueButton(RunMutation runMutation) {
    final snackbar = SnackBar(
      content: Text('Enter a valid number with 10 digits'),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(24),
          child: Builder(
            builder: (buildContext) => PrimaryButtonWidget(
              buttonText: "Continue",
              onPressed: () {
                setState(() {
                  isNumberExist = false;
                });
                if (phoneNumber.length < 10) {
                  Scaffold.of(buildContext).showSnackBar(snackbar);
                } else {
                  setState(() {
                    isButtonClicked = true;
                  });
                  runMutation({'phoneNumber': phoneNumber});
                }
              },
            ),
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

  Widget validateVendorArgumentMutation(RunMutation runMutationUpdate) {
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
          if (resultData['validateVendorArguments']['phoneNumber']) {
            setState(() {
              isButtonClicked = false;
            });
            print('inside the phone number exist.');
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return DialogStyle(
                  titleMessage: 'The phone number already exist',
                  contentMessage:
                      'The phone number you have entered already exist. Please use another phone number to change your number.',
                  isRegister: false,
                );
              },
            );
          } else {
            print('phone Number does not exist');
            setState(() {
              isButtonClicked = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPScreen(
                  phoneNumber: phoneNumber,
                  onOTPIncorrect: () {
                    print('on otp incorrect');
                  },
                  onOTPSuccess: () {
                    print('onOTPSucess');
                    runMutationUpdate({'phoneNumber': phoneNumber});
                  },
                ),
              ),
            );
            setState(() {});
          }
        }
      },
    );
  }

  Widget changePhoneNumberMutation() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: updateVendorAccountMutation,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
      ),
      builder: (runMutation, result) {
        return validateVendorArgumentMutation(runMutation);
      },
      onCompleted: (dynamic resultData) {
        if (resultData != null &&
            resultData['updateVendorAccount']['error'] == null) {
          Navigator.pop(context);
        }
      },
    );
  }
}
