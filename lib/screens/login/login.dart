import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/dialog_style.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/constants/strings.dart';
import 'package:electronic_emart_vendor/modals/User.dart';
import 'package:electronic_emart_vendor/screens/login/login_graphql.dart';
import 'package:electronic_emart_vendor/screens/registration/registration.dart';
import 'package:electronic_emart_vendor/screens/welcome/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map inputFields = {"phoneNumber": "", "password": ""};
  String errorText = "";
  bool isErrorExist = false;
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        children: <Widget>[
          Container(
            height: 240,
            color: PRIMARY_COLOR,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  nameAndLogoWidget(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Text(
                        'Supercharge your business with us!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: WHITE_COLOR,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 42.0),
            child: Text(
              'Login as Vendor',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: PRIMARY_COLOR,
                fontSize: 36,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Approved members only',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 36),
            child: CustomTextField(
              hintText: "Phone Number",
              obscureText: false,
              maxLines: 1,
              keyboardType: TextInputType.number,
              onChanged: (val) {
                setState(() {
                  inputFields['phoneNumber'] = val;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomTextField(
              hintText: "Password",
              obscureText: true,
              onChanged: (val) {
                inputFields['password'] = val;
              },
            ),
          ),
          vendorLoginMutationComponent(),
          registerContainer(),
        ],
      ),
    );
  }

  Widget loginButton(RunMutation runMutation) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        isButtonPressed
            ? Padding(
                padding: const EdgeInsets.only(right: 50.0, top: 6.0),
                child: CupertinoActivityIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 24.0, top: 6.0),
                child: PrimaryButtonWidget(
                  onPressed: () {
                    setState(() {
                      isButtonPressed = true;
                    });
                    runMutation({
                      'phoneNumber': inputFields['phoneNumber'],
                      'password': inputFields['password']
                    });
                  },
                  buttonText: 'Login',
                ),
              ),
      ],
    );
  }

  Widget registerContainer() {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: PRIMARY_COLOR.withOpacity(0.35),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Interested to join our platform? It’s easy!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'Complete the registration process, and get approved by the admin. Once done, you can sign right in and start your business!',
              style: TextStyle(
                fontSize: 12,
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TertiaryButton(
                  text: 'Contact Us',
                ),
                PrimaryButtonWidget(
                  buttonText: 'Register',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget nameAndLogoWidget() {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/images/place_holder.png',
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'App Name',
                style: TextStyle(
                  fontSize: 36,
                  color: WHITE_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'vendor App',
                style: TextStyle(
                  fontSize: 20,
                  color: WHITE_COLOR,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget vendorLoginMutationComponent() {
    return Mutation(
      options: MutationOptions(document: vendorLoginMutation),
      builder: (runMutation, result) {
        return loginButton(runMutation);
      },
      onCompleted: (dynamic resultData) async {
        if (resultData['vendorLogin']['error'] != null) {
          setState(() {
            isErrorExist = true;
            isButtonPressed = false;
            errorText = resultData['vendorLogin']['error']['message'];
          });
        }
        else{
          setState(() {
            errorText = "";
          });
        }
        if (errorText == ErrorStatus.USER_NOT_FOUND) {
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return DialogStyle(
                titleMessage: 'Account does not exist',
                contentMessage:
                    'There is no account registered with your details. If you’re new, register your account before signing in.',
                isRegister: true,
              );
            },
          );
        }
        if (errorText == ErrorStatus.PASSWORD_INVALID) {
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return DialogStyle(
                titleMessage: 'Password incorrect',
                contentMessage:
                    'The password you entered is incorrect. Please enter the correct password.',
                isRegister: false,
              );
            },
          );
        }
        if (errorText == ErrorStatus.NOT_APPROVED) {
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return DialogStyle(
                titleMessage: 'Approval pending',
                contentMessage:
                    'Your account is waiting for admin approval, and can only be accessed once it is complete.',
                isRegister: false,
              );
            },
          );
        }
        final prefs = await SharedPreferences.getInstance();
        final appState = Provider.of<AppState>(context);
        if (resultData != null && resultData['vendorLogin']['error'] == null) {
          final user = User.fromJson(resultData['vendorLogin']['user']);
          if (user != null) {
            setState(() {
              isErrorExist = false;
              errorText = "";
            });
            await prefs.setString(
                'token', resultData['vendorLogin']['jwtToken']);
            await prefs.setString('vendorId', user.id);
            appState.setJwtToken(resultData['vendorLogin']['jwtToken']);
            appState.setVendorAddressLine(user.addressType['addressLine']);
            appState.setVendorCity(user.addressType['city']);
          }
        }
        if (errorText == "") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        }
      },
    );
  }
}
