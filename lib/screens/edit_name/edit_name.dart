import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/profile/profile_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class EditName extends StatefulWidget {
  @override
  _EditName createState() => _EditName();
}

class _EditName extends State<EditName> {
  String storeName = "";
  bool isEmpty = false;
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
        updateNameMutationComponent()
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
          text("Change your Store Name", 30, PRIMARY_COLOR, false),
          Container(padding: EdgeInsets.only(top: 24)),
          text(
            "Enter your new Store name. This name will be shown to customer and admin.",
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
        hintText: "New Store name",
        obscureText: false,
        errorText: isEmpty ? 'Enter a name' : null,
        onChanged: (val) {
          storeName = val;
        },
      ),
    );
  }

  Widget continueButton(RunMutation runMutation) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        isButtonClicked
            ? Container(
                margin: EdgeInsets.only(right: 50),
                child: CupertinoActivityIndicator(),
              )
            : Container(
                padding: EdgeInsets.only(right: 24.0),
                child: PrimaryButtonWidget(
                  buttonText: "Continue",
                  onPressed: () {
                    if (storeName == "") {
                      setState(() {
                        isEmpty = true;
                      });
                    } else {
                      setState(() {
                        isButtonClicked = true;
                      });
                      runMutation({'storeName': storeName});
                    }
                  },
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

  Widget updateNameMutationComponent() {
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
        return continueButton(runMutation);
      },
      update: (Cache cache, QueryResult result) {
        return cache;
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
