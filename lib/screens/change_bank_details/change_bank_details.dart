import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/profile/profile_graphql.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../../app_state.dart';

class ChangeBankDetails extends StatefulWidget {
  @override
  _ChangeBankDetailsState createState() => _ChangeBankDetailsState();
}

class _ChangeBankDetailsState extends State<ChangeBankDetails> {
  String bankAccountName = "";
  String bankAccountNumber = "";
  String bankAccountIFSC = "";
  String numberGST = "";
  Map inputFields = {
    'bankAccountName': '',
    'bankAccountNumber': '',
    'bankAccountIFSC': '',
    'vendorGSTNumber': ''
  };
  bool isButtonClicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          backButton(),
          headerTexts(),
          bankDetailsWidgets(),
          Container(height: 24),
          isButtonClicked
              ? CupertinoActivityIndicator()
              : changeBankDetailsMutation()
        ],
      ),
    );
  }

  Widget backButton() {
    return Container(
      margin: EdgeInsets.only(left: 24, top: 16),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(FeatherIcons.arrowLeft, color: PRIMARY_COLOR),
          ),
        ],
      ),
    );
  }

  Widget headerTexts() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: <Widget>[
          Container(height: 32),
          Text(
            'Edit your Bank Details',
            style: TextStyle(color: PRIMARY_COLOR, fontSize: 30),
          ),
          Container(height: 12),
          Text(
            'Enter your bank details and GST number carefully',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }

  Widget bankDetailsWidgets() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: <Widget>[
          Container(height: 18),
          CustomTextField(
            hintText: 'Bank Account Name',
            obscureText: false,
            onChanged: (val) {
              setState(() {
                inputFields['bankAccountName'] = val;
              });
            },
          ),
          Container(height: 18),
          CustomTextField(
            hintText: 'Bank Account number',
            obscureText: false,
            onChanged: (val) {
              setState(() {
                inputFields['bankAccountNumber'] = val;
              });
            },
          ),
          Container(height: 18),
          CustomTextField(
            hintText: 'Bank Account IFSC',
            obscureText: false,
            onChanged: (val) {
              setState(() {
                inputFields['bankAccountIFSC'] = val;
              });
            },
          ),
          Container(height: 18),
          CustomTextField(
            hintText: 'GST Number',
            obscureText: false,
            onChanged: (val) {
              inputFields['vendorGSTNumber'] = val;
            },
          ),
        ],
      ),
    );
  }

  Widget saveChangesButton(RunMutation runMutation) {
    final snackbar = SnackBar(
      content: Text('Enter all the above fields'),
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Builder(
        builder: (context) => PrimaryButtonWidget(
          buttonText: "Save Changes",
          onPressed: () {
            if (inputFields['bankAccountName'] == "" ||
                inputFields['bankAccountNumber'] == "" ||
                inputFields['bankAccountIFSC'] == "" ||
                inputFields['vendorGSTNumber'] == "") {
              Scaffold.of(context).showSnackBar(snackbar);
            } else {
              setState(() {
                isButtonClicked = true;
              });
              print(inputFields);
              runMutation({
                'bankAccountName': inputFields['bankAccountName'],
                'bankAccountNumber': inputFields['bankAccountNumber'],
                'bankAccountIFSC': inputFields['bankAccountIFSC'],
                'vendorGSTNumber': inputFields['vendorGSTNumber']
              });
            }
          },
        ),
      ),
    );
  }

  Widget changeBankDetailsMutation() {
    final appState = Provider.of<AppState>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Mutation(
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
        update: (Cache cache, QueryResult result) {
          return cache;
        },
        onCompleted: (dynamic resultData) {
          print(resultData);
          if (resultData != null &&
              resultData['updateVendorAccount']['error'] == null) {
            setState(() {
              isButtonClicked = false;
            });
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
