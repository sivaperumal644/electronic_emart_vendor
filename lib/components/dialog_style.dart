import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/registration/registration.dart';
import 'package:flutter/material.dart';

class DialogStyle extends StatelessWidget {
  final String titleMessage;
  final String contentMessage;
  final bool isRegister;
  final bool isDelete;
  final Function deleteOnPressed;

  const DialogStyle({
    this.titleMessage,
    this.contentMessage,
    this.isRegister,
    this.isDelete = false,
    this.deleteOnPressed,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Center(
        child: Text(
          titleMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: PRIMARY_COLOR,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            contentMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: BLACK_COLOR,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 32,
              left: 24,
              right: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (isRegister)
                  TertiaryButton(
                    text: isDelete ? 'Cancel' : 'Register',
                    onPressed: isDelete
                        ? () {
                            Navigator.pop(context);
                          }
                        : () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationScreen(),
                              ),
                            );
                          },
                  ),
                Container(),
                PrimaryButtonWidget(
                  buttonText: isDelete ? 'Delete' : 'Got it',
                  onPressed: isDelete
                      ? deleteOnPressed
                      : () {
                          Navigator.pop(context);
                        },
                ),
                Container()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
