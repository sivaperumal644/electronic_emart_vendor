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

class EditAddress extends StatefulWidget {
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  String addressText = "";
  String cityText = "";
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
      ],
    );
  }

  Widget backButton() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 24, top: 24, bottom: 16),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
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
      padding: EdgeInsets.fromLTRB(24, 0, 24, 10),
      child: Column(
        children: <Widget>[
          text("Edit your Address", 30, PRIMARY_COLOR, false),
          Container(padding: EdgeInsets.only(top: 16)),
          text(
            "Please enter your details carefully.",
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
      child: Column(
        children: <Widget>[
          CustomTextField(
            hintText: "Address",
            obscureText: false,
            onChanged: (val) {
              addressText = val;
            },
          ),
          SizedBox(height: 20),
          CustomTextField(
            hintText: "City",
            obscureText: false,
            onChanged: (val) {
              cityText = val;
            },
          ),
          SizedBox(height: 20),
          isButtonClicked
              ? CupertinoActivityIndicator()
              : changeAddressMutationComponent(),
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
            if (addressText == "" || cityText == "") {
              Scaffold.of(context).showSnackBar(snackbar);
            } else {
              setState(() {
                isButtonClicked = true;
              });
              runMutation({
                'address': {'addressLine': addressText, 'city': cityText}
              });
            }
          },
        ),
      ),
    );
  }

  Widget text(String title, double size, Color color, bool isBold) {
    return Text(
      "$title",
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: isBold ? FontWeight.bold : null,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget changeAddressMutationComponent() {
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
      update: (Cache cache, QueryResult result) {
        return cache;
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
