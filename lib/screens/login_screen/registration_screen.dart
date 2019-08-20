import 'package:electronic_emart_vendor/components/form_process_header.dart';
import 'package:electronic_emart_vendor/components/header_and_subheader.dart';
import 'package:electronic_emart_vendor/components/persistent_bottom_bar.dart';
import 'package:electronic_emart_vendor/components/primary_button.dart';
import 'package:electronic_emart_vendor/components/tertiary_button.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/login_screen/login_screen.dart';
import 'package:electronic_emart_vendor/screens/login_screen/registration_approval_screen.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  List<String> uploadedFile = [];
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Column(
        children: <Widget>[
          Container(margin: EdgeInsets.only(top: 44.0)),
          FormProcessHeader(activeIndicators: currentPage, totalIndicators: 3),
          Container(
            height: 0.5,
            margin: EdgeInsets.only(top: 32.0),
            color: PRIMARY_COLOR.withOpacity(0.5),
          ),
          pageView(),
          PersistentBottomBar(
            tertiaryOnPressed: () {
              if (currentPage == 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }
              pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
            primaryOnPressed: uploadedFile.length != 2 && currentPage == 2
                ? null
                : () {
                    if (currentPage == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegistrationApproval()),
                      );
                    }
                    pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
            tertiaryText: 'Back',
            primaryText: 'Next',
          )
        ],
      ),
    );
  }

  Widget pageView() {
    return Expanded(
      child: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          registrationStep(),
          registrationStep(),
          registrationUpload(),
        ],
        scrollDirection: Axis.horizontal,
        onPageChanged: (val) {
          setState(() {
            currentPage = val;
          });
        },
      ),
    );
  }

  Widget registrationStep() {
    final storeDetails = currentPage == 1;

    return Padding(
      padding: EdgeInsets.only(left: 24.0, right: 24.0, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(margin: EdgeInsets.only(top: 40.0)),
          HeaderAndSubHeader(
            headerText:
                storeDetails ? 'Name of the store' : 'Contact Information',
            subHeaderText: storeDetails
                ? 'Your online presence will be registered with this name'
                : 'We will use this information to contact you',
          ),
          Container(margin: EdgeInsets.only(top: 12.0)),
          CustomTextField(hintText: storeDetails ? 'Phone Number' : 'Name'),
          if (!storeDetails)
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: CustomTextField(
                hintText: 'Email Address',
              ),
            ),
          Container(margin: EdgeInsets.only(top: 40.0)),
          Text(
            storeDetails ? 'Address' : 'Choose a password',
            style: TextStyle(
              fontSize: 16,
              color: BLACK_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(margin: EdgeInsets.only(top: 24.0)),
          CustomTextField(
            hintText: storeDetails ? 'Street/Locality' : 'Password',
          ),
          Container(margin: EdgeInsets.only(top: 24.0)),
          CustomTextField(
            hintText: storeDetails ? 'City' : 'Confirm Password',
          ),
        ],
      ),
    );
  }

  Widget registrationUpload() {
    return Padding(
      padding: EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          uploadDocuments(
              'PAN Card Front and Back',
              'Submit scanned images of your PAN Card',
              'Upload PAN Card',
              'PANCARD'),
          Container(margin: EdgeInsets.only(top: 30)),
          uploadDocuments(
            'Photograph of your shop',
            'Submit photo of your shop',
            'Upload Shop Photo',
            'STOREPHOTO',
          ),
        ],
      ),
    );
  }

  Widget uploadDocuments(headerText, subHeaderText, buttonText, uploadFile) {
    final isUploaded = uploadedFile.contains(uploadFile);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            HeaderAndSubHeader(
              headerText: headerText,
              subHeaderText: subHeaderText,
            ),
            if (isUploaded)
              Icon(
                FeatherIcons.checkCircle,
                color: PRIMARY_COLOR,
              )
          ],
        ),
        Container(margin: EdgeInsets.only(top: 10)),
        isUploaded
            ? TertiaryButton(
                text: 'Remove',
                onPressed: () {
                  setState(() {
                    uploadedFile.remove(uploadFile);
                  });
                },
              )
            : PrimaryButtonWidget(
                buttonText: buttonText,
                onPressed: () {
                  setState(() {
                    uploadedFile.add(uploadFile);
                  });
                },
              )
      ],
    );
  }
}
