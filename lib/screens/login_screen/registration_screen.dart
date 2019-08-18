import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/form_process_header.dart';
import 'package:electronic_emart_vendor/components/header_and_subheader.dart';
import 'package:electronic_emart_vendor/components/persistent_bottom_bar.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/login_screen/registration_approval_screen.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String registerHeading = '';
  bool isBackPressable = true;
  bool isRegisterScreen1 = true;
  bool secondIndicator = false;
  bool thirdIndicator = false;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    if (appState.getRegisterScreen == 1) {
      setState(() {
        isBackPressable = false;
        registerHeading = 'Account credentials';
        isRegisterScreen1 = true;
        secondIndicator = false;
        thirdIndicator = false;
      });
    } else if (appState.getRegisterScreen == 2) {
      setState(() {
        registerHeading = 'Store Details';
        isBackPressable = true;
        isRegisterScreen1 = false;
        secondIndicator = true;
        thirdIndicator = false;
      });
    } else {
      setState(() {
        isBackPressable = true;
        registerHeading = 'Upload documents';
        isRegisterScreen1 = false;
        secondIndicator = true;
        thirdIndicator = true;
      });
    }

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 42.0),
                child: FormProcessHeader(
                  title: registerHeading,
                  currentScreen: appState.getRegisterScreen,
                  secondIndicator: secondIndicator,
                  thirdIndicator: thirdIndicator,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  height: 1,
                  color: PRIMARY_COLOR.withOpacity(0.3),
                ),
              ),
              if (appState.getRegisterScreen == 1 ||
                  appState.getRegisterScreen == 2)
                registrationStep(),
              if (appState.getRegisterScreen == 3) uploadRegistration(),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PersistentBottomBar(
              tertiaryOnPressed: isBackPressable
                  ? () {
                      appState.setRegisterScreen(-1);
                    }
                  : () {
                      Navigator.pop(context);
                    },
              primaryOnPressed: () {
                if (appState.getRegisterScreen < 3)
                  appState.setRegisterScreen(1);
                else
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationApproval(),
                    ),
                  );
              },
              isPrimaryClickable: appState.getRegisterScreen == 3
                  ? appState.getIsPanSubmitted && appState.getIsPhotoSubmitted
                  : true,
            ),
          ),
        ],
      ),
    );
  }

  Widget registrationStep() {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 150.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: HeaderAndSubHeader(
              headerText: isRegisterScreen1
                  ? 'Contact Information'
                  : 'Name of the store',
              subHeaderText: isRegisterScreen1
                  ? 'We will use this information to contact you'
                  : 'Your online presence will be registered with this name',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: CustomTextField(
              hintText: isRegisterScreen1 ? 'Phone Number' : 'Name',
            ),
          ),
          isRegisterScreen1
              ? Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: CustomTextField(
                    hintText: 'Email Address',
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text(
              isRegisterScreen1 ? 'Choose a password' : 'Address',
              style: TextStyle(
                fontSize: 16,
                color: BLACK_COLOR,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: CustomTextField(
              hintText: isRegisterScreen1 ? 'Password' : 'Street/Locality',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: CustomTextField(
              hintText: isRegisterScreen1 ? 'Confirm Password' : 'City',
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadRegistration() {
    final appState = Provider.of<AppState>(context);
    return Column(
      children: <Widget>[
        uploadDocuments(
          'PAN Card Front and Back',
          'Submit scanned images of your PAN Card',
          'Upload PAN Card',
          () {
            setState(() {
              appState.setIsPanSubmitted(true);
            });
          },
          appState.getIsPanSubmitted,
          () {
            appState.setIsPanSubmitted(false);
          },
        ),
        uploadDocuments(
          'Photograph of your shop',
          'Submit photo of your shop',
          'Upload Shop Photo',
          () {
            setState(() {
              appState.setIsPhotoSubmitted(true);
            });
          },
          appState.getIsPhotoSubmitted,
          () {
            setState(() {
              appState.setIsPhotoSubmitted(false);
            });
          },
        )
      ],
    );
  }

  Widget uploadDocuments(headerText, subHeaderText, buttonText, onPressed,
      isDocumentSubmitted, onPressedTertiary) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              HeaderAndSubHeader(
                headerText: headerText,
                subHeaderText: subHeaderText,
              ),
              isDocumentSubmitted
                  ? Icon(
                      FeatherIcons.checkCircle,
                      color: PRIMARY_COLOR,
                    )
                  : Container(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                isDocumentSubmitted
                    ? TertiaryButton(
                        text: 'Remove',
                        onPressed: onPressedTertiary,
                      )
                    : PrimaryButtonWidget(
                        buttonText: buttonText,
                        onPressed: onPressed,
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
