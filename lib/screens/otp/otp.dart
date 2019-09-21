import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  final Function onOTPSuccess;

  const OTPScreen({this.phoneNumber, this.onOTPSuccess});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = "";
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final AuthResult user =
          await firebaseAuth.signInWithCredential(credential);
      final FirebaseUser currentUser = await firebaseAuth.currentUser();
      assert(user.user.uid == currentUser.uid);
    } catch (e) {
      handleError(e);
    }
  }

  verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
    };
    try {
      print("STARTING VERIFICATION of +91${widget.phoneNumber}");
      firebaseAuth.verifyPhoneNumber(
          phoneNumber: '+91${widget.phoneNumber}',
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 20),
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          },
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print("RECEIVED FROM AUTH: " + phoneAuthCredential.toString());
            widget.onOTPSuccess();
            Navigator.pop(context);
          },
          verificationFailed: (AuthException e) {
            print("AUTH VERIFICATION FAILED : " +
                e.message +
                e.code +
                e.toString());
          });
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    verifyPhone();
    phoneNo = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: layout(),
    );
  }

  Widget layout() {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: <Widget>[
          Container(padding: EdgeInsets.only(top: 20)),
          backButton(),
          Container(padding: EdgeInsets.only(top: 20)),
          Text(
            'ENTER OTP',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 30,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 24),
            child: Text(
                "OTP Sent to +91 $phoneNo. Please enter the OTP to continue.",
                style: TextStyle(fontSize: 14, color: BLACK_COLOR),
                textAlign: TextAlign.center),
          ),
          SizedBox(height: 20),
          CustomTextField(
            hintText: "OTP",
            obscureText: false,
            onChanged: (val) {
              this.smsOTP = val;
            },
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TertiaryButton(text: "Resend OTP", onPressed: () {}),
              PrimaryButtonWidget(
                buttonText: "Verify",
                onPressed: () async {
                  try {
                    final AuthCredential credential =
                        PhoneAuthProvider.getCredential(
                            verificationId: verificationId, smsCode: smsOTP);
                    print("RECEIVED CREDENTIAL : " + credential.toString());
                  } catch (e) {
                    handleError(e);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget backButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(FeatherIcons.arrowLeft, color: PRIMARY_COLOR),
      ),
    );
  }
}

void handleError(PlatformException e) {
  print(e.toString());
  print('ERROR CODE : ' + e.code);
}
