import 'package:electronic_emart_vendor/components/dialog_style.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/inventory_input/inventory_input_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';

class AnswerPost extends StatefulWidget {
  final String question;
  final String questionId;
  final String answer;
  final bool isAnswered;

  const AnswerPost({
    this.question,
    this.questionId,
    this.isAnswered,
    this.answer,
  });

  @override
  _AnswerPostState createState() => _AnswerPostState();
}

class _AnswerPostState extends State<AnswerPost> {
  TextEditingController answerController;
  Map answerText = {"answerText": ""};
  bool isButtonClicked = false;

  @override
  void initState() {
    super.initState();
    if (widget.isAnswered == true) {
      answerController = TextEditingController(text: widget.answer);
    } else {
      answerController = TextEditingController();
    }
  }

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
              controller: answerController,
              obscureText: false,
              hintText: 'Give your answer here',
              maxLines: 10,
              onChanged: (val) {
                answerText['answerText'] = val;
              },
            ),
          ),
          isButtonClicked
              ? CupertinoActivityIndicator()
              : answerQuestionMutationComponent(),
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

  Widget saveChangesButton(RunMutation runMutation) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: PrimaryButtonWidget(
        buttonText: 'Save Changes',
        onPressed: () {
          setState(() {
            isButtonClicked = true;
          });
          runMutation({
            'questionId': widget.questionId,
            'answerText': answerText['answerText'],
          });
        },
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

  Widget answerQuestionMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(
        document: answerQuestionMutation,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.getJwtToken}',
          },
        },
      ),
      builder: (runMutation, result) {
        return saveChangesButton(runMutation);
      },
      onCompleted: (dynamic resultData) {
        if (resultData != null &&
            resultData['answerQuestion']['error'] == null) {
          Navigator.pop(context);
        }
      },
    );
  }
}
