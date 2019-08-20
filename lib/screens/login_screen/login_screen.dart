import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/home_screen/welcome_screen.dart';
import 'package:electronic_emart_vendor/screens/login_screen/registration_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        children: <Widget>[
          Container(
            height: 235,
            color: PRIMARY_COLOR,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: <Widget>[
                  nameAndLogoWidget(),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Text(
                      'Supercharge your business with us!',
                      style: TextStyle(
                        fontSize: 20,
                        color: WHITE_COLOR,
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
            child: CustomTextField(hintText: "Username/Email"),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomTextField(hintText: "Password"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 24.0, top: 6.0),
                child: PrimaryButtonWidget(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                  buttonText: 'Login',
                ),
              ),
            ],
          ),
          registerContainer(),
        ],
      ),
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
          padding: const EdgeInsets.only(left: 30.0),
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
}
