import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/dialog_style.dart';
import 'package:electronic_emart_vendor/components/form_process_header.dart';
import 'package:electronic_emart_vendor/components/header_and_subheader.dart';
import 'package:electronic_emart_vendor/components/imageSelectionWidget.dart';
import 'package:electronic_emart_vendor/components/persistent_bottom_bar.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/constants/strings.dart';
import 'package:electronic_emart_vendor/screens/otp/otp.dart';
import 'package:electronic_emart_vendor/screens/registration/register_graohql.dart';
import 'package:electronic_emart_vendor/screens/registration_sent/registration_sent.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  List<String> uploadedFile = [];
  List<String> panCardUrls = [];
  int currentPage = 0;
  bool isRequiredFieldsFilled = true;
  bool isConfirmedPasswordWrong = false;
  bool isRegisterButtonClicked = false;
  String panImagesUrl;
  String errorMessage = "";

  Map inputFields = {
    "phoneNumber": "",
    "email": "",
    "password": "",
    "confirmPassword": "",
    "storeName": "",
    "address": "",
    "city": "",
  };

  TextEditingController phoneNumberController,
      emailController,
      passwordController,
      confirmPasswordController,
      storeNameController,
      addressController,
      cityController;

  @override
  void initState() {
    super.initState();
    phoneNumberController =
        TextEditingController(text: inputFields['phoneNumber']);
    emailController = TextEditingController(text: inputFields['email']);
    passwordController = TextEditingController(text: inputFields['password']);
    confirmPasswordController =
        TextEditingController(text: inputFields['confirmPassword']);
    storeNameController = TextEditingController(text: inputFields['storeName']);
    addressController = TextEditingController(text: inputFields['address']);
    cityController = TextEditingController(text: inputFields['city']);
  }

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
          createVendorMutationComponent(),
        ],
      ),
    );
  }

  Widget bottomBarButtons(RunMutation runMutation) {
    final appState = Provider.of<AppState>(context);
    return isRegisterButtonClicked
        ? Container(
            height: 60,
            child: CupertinoActivityIndicator(),
          )
        : PersistentBottomBar(
            tertiaryOnPressed: () {
              if (currentPage == 0) {
                Navigator.pop(context);
              }
              pageController.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            },
            primaryOnPressed: uploadedFile.length < 3 && currentPage == 2
                ? null
                : () {
                    if (currentPage == 2) {
                      setState(() {
                        isRegisterButtonClicked = true;
                        panCardUrls.add(appState.getPanFrontUrl);
                        panCardUrls.add(appState.getPanBackUrl);
                        panImagesUrl =
                            '["${appState.getPanFrontUrl}","${appState.getPanBackUrl}"]';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OTPScreen(
                            phoneNumber: inputFields['phoneNumber'],
                            onOTPSuccess: () {
                              runMutation({
                                'phoneNumber': inputFields['phoneNumber'],
                                'email': inputFields['email'],
                                'password': inputFields['password'],
                                'storeName': inputFields['storeName'],
                                'pancardPhotoUrls': panImagesUrl,
                                'shopPhotoUrl': appState.getShopPhotoUrl,
                                'address': {
                                  'addressLine': inputFields['address'],
                                  'city': inputFields['city'],
                                }
                              });
                            },
                          ),
                        ),
                      );
                    } else if (currentPage == 0) {
                      if (inputFields['phoneNumber'] == "" ||
                          inputFields['email'] == "" ||
                          inputFields['password'] == "" ||
                          inputFields['confirmPassword'] == "") {
                        setState(() {
                          isRequiredFieldsFilled = false;
                        });
                      } else if (inputFields['password'] ==
                          inputFields['confirmPassword']) {
                        setState(() {
                          isRequiredFieldsFilled = true;
                          isConfirmedPasswordWrong = false;
                        });
                        pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      } else {
                        setState(() {
                          isConfirmedPasswordWrong = true;
                        });
                      }
                    } else if (currentPage == 1) {
                      if (inputFields['storeName'] == "" ||
                          inputFields['address'] == "" ||
                          inputFields['city'] == "") {
                        setState(() {
                          isRequiredFieldsFilled = false;
                        });
                      } else {
                        setState(() {
                          isRequiredFieldsFilled = true;
                        });
                        pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    }
                  },
            tertiaryText: 'Back',
            primaryText: 'Next',
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
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(margin: EdgeInsets.only(top: 10.0)),
          HeaderAndSubHeader(
            headerText:
                storeDetails ? 'Name of the store' : 'Contact Information',
            subHeaderText: storeDetails
                ? 'Your online presence will be registered with this name'
                : 'We will use this information to contact you',
          ),
          Container(margin: EdgeInsets.only(top: 12.0)),
          storeDetails
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'An OTP will be sent to this number. Please keep it ready.'),
                ),
          CustomTextField(
            keyboardType:
                storeDetails ? TextInputType.text : TextInputType.number,
            hintText: storeDetails ? 'Name' : 'Phone Number',
            obscureText: false,
            controller:
                storeDetails ? storeNameController : phoneNumberController,
            onChanged: (val) {
              setState(() {
                inputFields[storeDetails ? 'storeName' : 'phoneNumber'] = val;
              });
            },
          ),
          if (!storeDetails)
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: CustomTextField(
                hintText: 'Email Address',
                controller: emailController,
                obscureText: false,
                onChanged: (val) {
                  setState(() {
                    inputFields['email'] = val;
                  });
                },
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
            controller: storeDetails ? addressController : passwordController,
            obscureText: storeDetails ? false : true,
            onChanged: (val) {
              setState(() {
                inputFields[storeDetails ? 'address' : 'password'] = val;
              });
            },
          ),
          Container(margin: EdgeInsets.only(top: 24.0)),
          CustomTextField(
            hintText: storeDetails ? 'City' : 'Confirm Password',
            errorText: storeDetails
                ? null
                : isConfirmedPasswordWrong
                    ? 'Confirm password mismatch password'
                    : null,
            controller:
                storeDetails ? cityController : confirmPasswordController,
            obscureText: storeDetails ? false : true,
            onChanged: (val) {
              setState(() {
                inputFields[storeDetails ? 'city' : 'confirmPassword'] = val;
              });
            },
          ),
          Container(margin: EdgeInsets.only(top: 8.0)),
          isRequiredFieldsFilled
              ? Container()
              : Text(
                  'Enter all above fields',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: PALE_RED_COLOR,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
          Container(margin: EdgeInsets.only(bottom: 40))
        ],
      ),
    );
  }

  Widget registrationUpload() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          uploadDocuments(
            'PAN Card Front and Back',
            'Submit scanned images of your PAN Card',
            'PANCARD_FRONT',
            'PANCARD_BACK',
            true,
          ),
          Container(margin: EdgeInsets.only(top: 30)),
          uploadDocuments(
            'Photograph of your shop',
            'Submit photo of your shop',
            'STOREPHOTO',
            null,
            false,
          ),
          Container(height: 16),
        ],
      ),
    );
  }

  Widget uploadDocuments(
      headerText, subHeaderText, uploadFile1, uploadFile2, isTwo) {
    final isUploaded = isTwo
        ? uploadedFile.contains(uploadFile1) &&
            uploadedFile.contains(uploadFile2)
        : uploadedFile.contains(uploadFile1);
    final appState = Provider.of<AppState>(context);
    return Column(
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
        Container(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(),
            ImageSelectionWidget(
              existingUrl:
                  isTwo ? appState.getPanFrontUrl : appState.getShopPhotoUrl,
              onUserImageSet: (url) {
                setState(() {
                  isTwo
                      ? appState.setPanFrontUrl(url)
                      : appState.setShopPhotoUrl(url);
                  uploadedFile.add(uploadFile1);
                });
              },
            ),
            isTwo
                ? ImageSelectionWidget(
                    existingUrl: appState.getPanBackUrl,
                    onUserImageSet: (url) {
                      setState(() {
                        appState.setPanBackUrl(url);
                        uploadedFile.add(uploadFile2);
                      });
                    },
                  )
                : Container(),
          ],
        )
      ],
    );
  }

  Widget createVendorMutationComponent() {
    return Mutation(
      options: MutationOptions(document: createVendorMutation),
      builder: (runMutation, result) {
        return bottomBarButtons(runMutation);
      },
      onCompleted: (dynamic resultdata) {
        if (resultdata != null && resultdata['createVendor']['error'] != null) {
          setState(() {
            errorMessage =
                resultdata['createVendor']['error']['message'].toString();
            isRegisterButtonClicked = false;
          });
          if (errorMessage == ErrorStatus.PHONE_NUMBER_EXISTS) {
            return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return DialogStyle(
                    titleMessage: 'Phone Number already exists.',
                    contentMessage:
                        'The phone number you entered already exists. Please use a different number to register.',
                    isRegister: false,
                  );
                });
          }
          if (errorMessage == ErrorStatus.EMAIL_EXISTS) {
            return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return DialogStyle(
                    titleMessage: 'Email Id already exists.',
                    contentMessage:
                        'The Email Id you entered already exists. Please use a different Email Id to register.',
                    isRegister: false,
                  );
                });
          }
          // Toast.show(errorMessage, context,
          //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
        if (resultdata != null && resultdata['createVendor']['error'] == null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationSent()),
          );
        }
      },
    );
  }
}
