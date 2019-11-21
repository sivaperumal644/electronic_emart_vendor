String updateVendorAccountMutation = '''
mutation UpdateVendorAccount(\$storeName:String, \$phoneNumber:String, \$password:String, \$email:String, \$pancardPhotoUrls:String, \$shopPhotoUrl:String, \$vendorId:String, \$address: AddressType, \$bankAccountName:String, \$bankAccountNumber:String, \$bankAccountIFSC: String, \$vendorGSTNumber: String, \$paytmName: String, \$paytmNumber: String, \$otpToken: String, \$alternativePhone1: String, \$alternativePhone2: String){
  updateVendorAccount(storeName:\$storeName, phoneNumber:\$phoneNumber, password: \$password, email:\$email, pancardPhotoUrls:\$pancardPhotoUrls, shopPhotoUrl:\$shopPhotoUrl, vendorId:\$vendorId, address:\$address, bankAccountName:\$bankAccountName, bankAccountNumber:\$bankAccountNumber, bankAccountIFSC: \$bankAccountIFSC, vendorGSTNumber:\$vendorGSTNumber, paytmName:\$paytmName, paytmNumber:\$paytmNumber, otpToken:\$otpToken, alternativePhone1:\$alternativePhone1, alternativePhone2:\$alternativePhone2){
    error{
      path
      message
    }
		user{
      id
      bankAccountName
      bankAccountNumber
      bankAccountIFSC
      vendorGSTNumber
      address,
      alternativePhone1,
      alternativePhone2,
    }
  }
}
''';

String getVendorInfoQuery = '''
query GetVendorInfo{
  getVendorInfo{
    user{
      id
      name
      phoneNumber
      alternativePhone1
      alternativePhone2
      address
      email
      storeName
      blocked
      pancardPhotoUrls
      shopPhotoUrl
      admin
      amountToPay
    }
    error{
      path
      message
    }
  }
}
''';

const String fcmIntegerateToken =
    """ mutation IntegrateFCMToken(\$fcmToken:String) {
       integrateFCMToken(fcmToken: \$fcmToken) {
         id
         name
   fcmToken
       }
}
""";
