String createVendorMutation = '''
mutation CreateVendor(\$storeName:String, \$phoneNumber:String, \$email:String, \$password:String, \$pancardPhotoUrls:String, \$shopPhotoUrl:String, \$address:AddressType, \$bankAccountName:String, \$bankAccountIFSC:String, \$bankAccountNumber:String, \$vendorGSTNumber:String, \$paytmName: String, \$paytmNumber: String, \$alternativePhone1: String, \$alternativePhone2: String ){
	createVendor(storeName:\$storeName, phoneNumber:\$phoneNumber, email:\$email, password:\$password, pancardPhotoUrls:\$pancardPhotoUrls, shopPhotoUrl:\$shopPhotoUrl ,address:\$address, bankAccountName:\$bankAccountName, bankAccountIFSC:\$bankAccountIFSC, bankAccountNumber:\$bankAccountNumber, vendorGSTNumber:\$vendorGSTNumber, paytmName:\$paytmName, paytmNumber:\$paytmNumber, alternativePhone1:\$alternativePhone1, alternativePhone2:\$alternativePhone2){
    error{
      path
      message
    }
    jwtToken
  } 
}
''';