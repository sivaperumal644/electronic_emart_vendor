import 'package:electronic_emart_vendor/app_state.dart';
import 'package:electronic_emart_vendor/components/dialog_style.dart';
import 'package:electronic_emart_vendor/components/form_process_header.dart';
import 'package:electronic_emart_vendor/components/header_and_subheader.dart';
import 'package:electronic_emart_vendor/components/imageSelectionWidget.dart';
import 'package:electronic_emart_vendor/components/persistent_bottom_bar.dart';
import 'package:electronic_emart_vendor/components/text_field.dart';
import 'package:electronic_emart_vendor/constants/colors.dart';
import 'package:electronic_emart_vendor/screens/otp/otp.dart';
import 'package:electronic_emart_vendor/screens/registration/register_graphql.dart';
import 'package:electronic_emart_vendor/screens/registration/validate_vendor_graphql.dart';
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
  bool isConfirmedPasswordWrong = false;
  bool isRegisterButtonClicked = false;
  bool phoneError = false;
  bool invalidPasswordLength = false;
  bool isNumberPresent;
  bool isEmailPresent;
  bool isAccountIFSCPresent;
  bool isAccountNumberPresent;
  String panImagesUrl;
  String errorMessage = "";
  String phoneNumberMessage,
      emailMessage,
      accountNumberMessage,
      accoutIFSCMessage;

  Map inputFields = {
    "phoneNumber": "",
    "email": "",
    "password": "",
    "confirmPassword": "",
    "storeName": "",
    "address": "",
    "city": "",
    "bankAccountName": "",
    "bankAccountIFSC": "",
    "bankAccountNumber": "",
    "vendorGSTNumber": "",
    'landMark': "",
    "pinCode": "",
    "paytmName":"",
    "paytmNumber":""
  };

  TextEditingController phoneNumberController,
      emailController,
      passwordController,
      confirmPasswordController,
      storeNameController,
      addressController,
      cityController,
      bankAccountNameController,
      bankAccountIFSCController,
      bankAccountNumberController,
      vendorGSTNumberController,
      landMarkController,
      pinCodeController,
      paytmNameController,
      paytmNumberController;

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
    bankAccountNameController =
        TextEditingController(text: inputFields['bankAccountName']);
    bankAccountIFSCController =
        TextEditingController(text: inputFields['bankAccountIFSC']);
    bankAccountNumberController =
        TextEditingController(text: inputFields['bankAccountNumber']);
    vendorGSTNumberController =
        TextEditingController(text: inputFields['vendorGSTNumber']);
    landMarkController = TextEditingController(text: inputFields['landMark']);
    pinCodeController = TextEditingController(text: inputFields['pinCode']);
    paytmNameController = TextEditingController(text: inputFields['paytmName']);
    paytmNumberController = TextEditingController(text: inputFields['paytmNumber']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Column(
        children: <Widget>[
          Container(margin: EdgeInsets.only(top: 44.0)),
          FormProcessHeader(activeIndicators: currentPage, totalIndicators: 4),
          Container(
            height: 0.5,
            margin: EdgeInsets.only(top: 32.0),
            color: PRIMARY_COLOR.withOpacity(0.5),
          ),
          pageView(),
          validateVendorArgumentsMutation(),
        ],
      ),
    );
  }

  Widget bottomBarButtons(
      RunMutation runMutationCreate, RunMutation runMutationValidate) {
    final snackbar = SnackBar(
      content: Text(phoneError
          ? 'Enter a valid number with 10 digits'
          : 'Enter all the above fields'),
    );
    final appState = Provider.of<AppState>(context);
    return isRegisterButtonClicked
        ? Container(
            height: 60,
            child: CupertinoActivityIndicator(),
          )
        : Builder(
            builder: (context) => PersistentBottomBar(
              tertiaryOnPressed: () {
                if (currentPage == 0) {
                  Navigator.pop(context);
                }
                pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.fastLinearToSlowEaseIn,
                );
              },
              primaryOnPressed: uploadedFile.length < 3 && currentPage == 3
                  ? null
                  : () {
                      if (currentPage == 3) {
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
                                runMutationCreate({
                                  'phoneNumber': inputFields['phoneNumber'],
                                  'email': inputFields['email'],
                                  'password': inputFields['password'],
                                  'storeName': inputFields['storeName'],
                                  'pancardPhotoUrls': panImagesUrl,
                                  'shopPhotoUrl': appState.getShopPhotoUrl,
                                  'address': {
                                    'addressLine': inputFields['address'],
                                    'city': inputFields['city'],
                                    'landmark': inputFields['landMark'],
                                    'pinCode': inputFields['pinCode'],
                                  },
                                  'bankAccountName':
                                      inputFields['bankAccountName'],
                                  'bankAccountIFSC':
                                      inputFields['bankAccountIFSC'],
                                  'bankAccountNumber':
                                      inputFields['bankAccountNumber'],
                                  'vendorGSTNumber':
                                      inputFields['vendorGSTNumber'],
                                      'paytmName':inputFields['paytmName'],
                                      'paytmNumber':inputFields['paytmNumber'],
                                });
                              },
                            ),
                          ),
                        );
                      } else if (currentPage == 0) {
                        setState(() {
                          isRegisterButtonClicked = true;
                          isConfirmedPasswordWrong = false;
                          phoneError = false;
                          invalidPasswordLength = false;
                        });

                        if (inputFields['phoneNumber'] == "" ||
                            inputFields['email'] == "" ||
                            inputFields['password'] == "" ||
                            inputFields['confirmPassword'] == "") {
                          setState(() {
                            isRegisterButtonClicked = false;
                          });
                          Scaffold.of(context).showSnackBar(snackbar);
                        } else if (inputFields['password'] !=
                            inputFields['confirmPassword']) {
                          setState(() {
                            isRegisterButtonClicked = false;
                            isConfirmedPasswordWrong = true;
                          });
                        } else if (inputFields['phoneNumber'].length < 10) {
                          setState(() {
                            isRegisterButtonClicked = false;
                            phoneError = true;
                          });
                          Scaffold.of(context).showSnackBar(snackbar);
                        } else if (inputFields['confirmPassword'].length < 6) {
                          setState(() {
                            isRegisterButtonClicked = false;
                            invalidPasswordLength = true;
                          });
                        } else {
                          setState(() {
                            isConfirmedPasswordWrong = false;
                          });
                          runMutationValidate({
                            "phoneNumber": inputFields['phoneNumber'],
                            "email": inputFields['email']
                          });
                        }
                      } else if (currentPage == 1) {
                        if (inputFields['storeName'] == "" ||
                            inputFields['address'] == "" ||
                            inputFields['city'] == "" ||
                            inputFields['landMark'] == "" ||
                            inputFields['pinCode'] == "") {
                          Scaffold.of(context).showSnackBar(snackbar);
                        } else {
                          pageController.nextPage(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      } else if (currentPage == 2) {
                        setState(() {
                          isRegisterButtonClicked = true;
                        });
                        if (inputFields['bankAccountName'] == "" ||
                            inputFields['bankAccountIFSC'] == "" ||
                            inputFields['bankAccountNumber'] == "" || inputFields['paytmName'] == "" || inputFields['paytmNumber'] == "") {
                          setState(() {
                            isRegisterButtonClicked = false;
                          });
                          Scaffold.of(context).showSnackBar(snackbar);
                        } else {
                          runMutationValidate({
                            "bankAccountIFSC": inputFields['bankAccountIFSC'],
                            "bankAccountNumber":
                                inputFields['bankAccountNumber']
                          });
                        }
                      }
                    },
              tertiaryText: 'Back',
              primaryText: 'Next',
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
          registrationBankDetails(),
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
                    '',
                  ),
                ),
          CustomTextField(
            keyboardType:
                storeDetails ? TextInputType.text : TextInputType.number,
            hintText: storeDetails ? 'Name' : 'Phone Number',
            counterText: storeDetails ? null : 'An OTP will be sent to this number. Please keep it ready.  ' ,
            maxLength: storeDetails ? null : 10,
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
            errorText: storeDetails
                ? null
                : invalidPasswordLength
                    ? 'Password should contain atleast 6 characters'
                    : null,
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
          storeDetails
              ? Column(
                  children: <Widget>[
                    Container(height: 24),
                    CustomTextField(
                      hintText: 'landmark',
                      controller: landMarkController,
                      obscureText: false,
                      onChanged: (val) {
                        setState(() {
                          inputFields['landMark'] = val;
                        });
                      },
                    ),
                    Container(height: 24),
                    CustomTextField(
                      hintText: 'pincode',
                      controller: pinCodeController,
                      obscureText: false,
                      onChanged: (val) {
                        setState(() {
                          inputFields['pinCode'] = val;
                        });
                      },
                    ),
                    Container(height: 32),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'GST Number',
                        style: TextStyle(
                          fontSize: 16,
                          color: BLACK_COLOR,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(height: 16),
                    CustomTextField(
                      controller: vendorGSTNumberController,
                      hintText: 'GST Number',
                      obscureText: false,
                      onChanged: (val) {
                        inputFields['vendorGSTNumber'] = val;
                      },
                    )
                  ],
                )
              : Container(),
          Container(margin: EdgeInsets.only(top: 8.0)),
          Container(margin: EdgeInsets.only(bottom: 40))
        ],
      ),
    );
  }

  Widget registrationBankDetails() {
    return Container(
      margin: EdgeInsets.only(left: 24.0, right: 24.0),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          HeaderAndSubHeader(
            headerText: 'Bank Account Number',
            subHeaderText:
                "Please enter the bank A/C No. you'd like to use for transactions",
          ),
          Container(height: 16.0),
          CustomTextField(
            controller: bankAccountNumberController,
            hintText: 'Account Number',
            maxLines: 1,
            keyboardType: TextInputType.number,
            obscureText: false,
            onChanged: (val) {
              inputFields['bankAccountNumber'] = val;
            },
          ),
          Container(height: 24),
          Text(
            'Account Holder Name',
            style: TextStyle(
              fontSize: 16,
              color: BLACK_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 16),
          CustomTextField(
            controller: bankAccountNameController,
            hintText: 'A/C Holder Name',
            maxLines: 1,
            obscureText: false,
            onChanged: (val) {
              inputFields['bankAccountName'] = val;
            },
          ),
          Container(height: 24),
          Text(
            'IFSC Code',
            style: TextStyle(
              fontSize: 16,
              color: BLACK_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 16),
          CustomTextField(
            controller: bankAccountIFSCController,
            hintText: 'IFSC Code',
            maxLines: 1,
            obscureText: false,
            onChanged: (val) {
              inputFields['bankAccountIFSC'] = val;
            },
          ),
          Container(height: 32),
          Text(
            'Paytm Name',
            style: TextStyle(
              fontSize: 16,
              color: BLACK_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 16),
          CustomTextField(
            controller: paytmNameController,
            hintText: 'Paytm Name',
            maxLines: 1,
            obscureText: false,
            onChanged: (val) {
              inputFields['paytmName'] = val;
            },
          ),
          Container(height: 16),
          Text(
            'Paytm Number',
            style: TextStyle(
              fontSize: 16,
              color: BLACK_COLOR,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 16),
          CustomTextField(
            controller: paytmNumberController,
            hintText: 'paytmNumber',
            keyboardType: TextInputType.number,
            maxLines: 1,
            obscureText: false,
            onChanged: (val) {
              inputFields['paytmNumber'] = val;
            },
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

  Widget createVendorMutationComponent(RunMutation runMutationValidate) {
    final appState = Provider.of<AppState>(context);
    return Mutation(
      options: MutationOptions(document: createVendorMutation),
      builder: (runMutation, result) {
        return bottomBarButtons(runMutation, runMutationValidate);
      },
      onCompleted: (dynamic resultdata) {
        if (resultdata != null && resultdata['createVendor']['error'] != null) {
          setState(() {
            errorMessage =
                resultdata['createVendor']['error']['message'].toString();
            isRegisterButtonClicked = false;
          });
        }
        if (resultdata != null && resultdata['createVendor']['error'] == null) {
          appState.setPanFrontUrl(null);
          appState.setPanBackUrl(null);
          appState.setShopPhotoUrl(null);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegistrationSent()),
          );
        }
      },
    );
  }

  Widget validateVendorArgumentsMutation() {
    return Mutation(
      options: MutationOptions(document: validateVendorArguments),
      builder: (runMutation, result) {
        return createVendorMutationComponent(runMutation);
      },
      onCompleted: (dynamic resultData) {
        setState(() {
          isRegisterButtonClicked = false;
        });
        if (resultData['validateVendorArguments']['errors'] == null) {
          if (resultData['validateVendorArguments']['phoneNumber'] != null &&
              resultData['validateVendorArguments']['email'] != null) {
            if (resultData['validateVendorArguments']['phoneNumber']) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return DialogStyle(
                      titleMessage: 'The phone number already exist',
                      contentMessage:
                          'The phone number you have entered already exist. Please use another phone number for registration.',
                      isRegister: false,
                    );
                  });
            } else if (resultData['validateVendorArguments']['email']) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return DialogStyle(
                      titleMessage: 'The email already exist',
                      contentMessage:
                          'The Email you have entered already exist. Please use another email for registration.',
                      isRegister: false,
                    );
                  });
            } else {
              pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            }
          } else {
            if (resultData['validateVendorArguments']['bankAccountIFSC']) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return DialogStyle(
                      titleMessage: 'The IFSC entered exists',
                      contentMessage:
                          'The Account IFSC you have entered already exist. Please use different account details for registration.',
                      isRegister: false,
                    );
                  });
            } else if (resultData['validateVendorArguments']
                ['bankAccountNumber']) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return DialogStyle(
                      titleMessage: 'The Account number entered exists',
                      contentMessage:
                          'The Account number you have entered already exist. Please use different account details for registration.',
                      isRegister: false,
                    );
                  });
            } else {
              pageController.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.fastLinearToSlowEaseIn,
              );
            }
          }
        }
      },
    );
  }
}
