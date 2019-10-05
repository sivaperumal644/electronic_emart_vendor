import 'package:electronic_emart_vendor/components/dialog_style.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class AnswerPost extends StatefulWidget {
  final String question;

  const AnswerPost({this.question});

  @override
  _AnswerPostState createState() => _AnswerPostState();
}

class _AnswerPostState extends State<AnswerPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          appBar(),
          Container(
            margin: EdgeInsets.all(24),
            child: Text(
              widget.question,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(24),
            child: CustomTextField(
              obscureText: false,
              hintText: 'Give your answer here',
              maxLines: 10,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: PrimaryButtonWidget(
              buttonText: 'Save Changes',
              onPressed: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24),
            child: TertiaryButton(
              isRed: true,
              text: 'Delete Question',
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return DialogStyle(
                        titleMessage: 'Delete question?',
                        contentMessage:
                            'This question along with any answers, will be permanently deleted.',
                        isRegister: true,
                        isDelete: true,
                        deleteOnPressed: () {},
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget appBar() {
    return Container(
      margin: EdgeInsets.only(top: 24.0, left: 12.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              FeatherIcons.arrowLeft,
              color: PRIMARY_COLOR,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Container(width: 20),
          Text(
            'Customer Question',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: PRIMARY_COLOR,
            ),
          )
        ],
      ),
    );
  }
}
