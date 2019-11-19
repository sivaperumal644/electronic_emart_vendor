import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/dialog_style.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/profile/profile_graphql.dart';
import 'package:electronic_emart_vendor/screens/registration/validate_vendor_graphql.dart';
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
  String landmarkText = "";
  String pincodeText = "";
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
          padding: EdgeInsets.only(left: 12, top: 24, bottom: 16),
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
            hintText: "Landmark",
            obscureText: false,
            onChanged: (val) {
              landmarkText = val;
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
          CustomTextField(
            hintText: "Pincode",
            obscureText: false,
            onChanged: (val) {
              pincodeText = val;
            },
          ),
          SizedBox(height: 50),
          isButtonClicked
              ? CupertinoActivityIndicator()
              : canPickUpMutationComponent(),
        ],
      ),
    );
  }

  Widget saveChangesButton(RunMutation runMutation) {
    final snackbar = SnackBar(content: Text('Enter all the above fields'));
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Builder(
        builder: (context) => PrimaryButtonWidget(
          buttonText: "Save Changes",
          onPressed: () {
            if (addressText == "" ||
                cityText == "" ||
                landmarkText == "" ||
                pincodeText == "") {
              Scaffold.of(context).showSnackBar(snackbar);
            } else {
              setState(() {
                isButtonClicked = true;
              });
              runMutation({'pincode': pincodeText});
              // runMutation({
              //   'address': {
              //     'addressLine': addressText,
              //     'city': cityText,
              //     'landmark': landmarkText,
              //     'pinCode': pincodeText,
              //   }
              // });
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

  Widget canPickUpMutationComponent() {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(document: canPickUpMutation),
      builder: (runMutation, result) {
        return saveChangesButton(runMutation);
      },
      onCompleted: (dynamic resultData) async {
        if (resultData['canPickUp'] == true) {
          final result = await appState.changeAddressMutation(
              addressText, landmarkText, cityText, pincodeText);
          if (result.data['updateVendorAccount']['error'] == null) {
            Navigator.pop(context);
          }
        } else {
          setState(() {
            isButtonClicked = false;
          });
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return DialogStyle(
                titleMessage: "Out of service",
                contentMessage:
                    "We are not available to pick up in the address you have mentioned, if you have some other branch please create account with that address. You cannot create your account with this address.",
                isRegister: false,
              );
            },
          );
        }
      },
    );
  }
}
