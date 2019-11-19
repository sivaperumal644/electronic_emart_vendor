import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/profile/profile_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';

class ChangePaytmDetails extends StatefulWidget {
  @override
  _ChangePaytmDetailsState createState() => _ChangePaytmDetailsState();
}

class _ChangePaytmDetailsState extends State<ChangePaytmDetails> {
  String paytmNumber = "";
  String paytmName = "";
  bool isButtonClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        children: <Widget>[
          backButton(),
          Text(
            'Edit your Paytm Details',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: PRIMARY_COLOR,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 30),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: CustomTextField(
              hintText: 'Paytm Number',
              keyboardType: TextInputType.number,
              obscureText: false,
              onChanged: (val) {
                paytmNumber = val;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: CustomTextField(
              hintText: 'Paytm Name',
              obscureText: false,
              onChanged: (val) {
                paytmName = val;
              },
            ),
          ),
          SizedBox(height: 50),
          changePaytmDetailsMutation()
        ],
      ),
    );
  }

  Widget saveChangesButton(RunMutation runMutation) {
    final snackbar = SnackBar(content: Text('Enter all the above fields'));
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: PrimaryButtonWidget(
        buttonText: 'Save Changes',
        onPressed: () {
          if (paytmNumber == "" || paytmName == "") {
            Scaffold.of(context).showSnackBar(snackbar);
          } else {
            setState(() {
              isButtonClicked = true;
            });
            runMutation({
              'paytmName': paytmName,
              'paytmNumber': paytmNumber,
            });
          }
        },
      ),
    );
  }

  Widget backButton() {
    return Container(
      margin: EdgeInsets.only(left: 12, top: 16),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FeatherIcons.arrowLeft,
              color: PRIMARY_COLOR,
            ),
          ),
        ],
      ),
    );
  }

  Widget changePaytmDetailsMutation() {
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
        return saveChangesButton(runMutation);
      },
      onCompleted: (dynamic resultData) {
        if (resultData != null &&
            resultData['updateVendorAccount']['error'] == null) {
          setState(() {
            isButtonClicked = false;
          });
          Navigator.pop(context);
        }
      },
    );
  }
}
