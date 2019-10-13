import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/inventory_detail_screen/answer_screen.dart';
import 'package:flutter/material.dart';

class InventoryQuestion extends StatelessWidget {
  final String question;
  final String answer;
  final bool isAnswered;
  final String questionId;
  //final Function onTap;

  const InventoryQuestion({
    this.question,
    this.answer = 'ADD AN ANSWER',
    this.isAnswered,
    this.questionId,
    //this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: WHITE_COLOR,
          borderRadius: BorderRadius.circular(12),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: isAnswered ? WHITE_COLOR : PRIMARY_COLOR.withOpacity(0.5),
              offset: Offset(2.0, 6.0),
              blurRadius: 4.0,
            ),
          ],
          border: Border.all(
            width: 1.5,
            color: isAnswered ? GREY_COLOR : PRIMARY_COLOR,
          ),
        ),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: WHITE_COLOR,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnswerPost(
                    isAnswered: isAnswered,
                    answer: answer,
                    question: question,
                    questionId: questionId,
                  ),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            question,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: PRIMARY_COLOR,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.edit,
                          color: PRIMARY_COLOR,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1.5,
                  color: GREY_COLOR.withOpacity(0.75),
                ),
                isAnswered
                    ? Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          answer,
                          style: TextStyle(
                            color: BLACK_COLOR,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(20),
                        child: Center(
                          child: Text(
                            answer,
                            style: TextStyle(
                              color: PRIMARY_COLOR,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
