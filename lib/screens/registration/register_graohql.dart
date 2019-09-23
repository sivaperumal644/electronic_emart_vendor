String createVendorMutation = '''
mutation CreateVendor(\$storeName:String, \$phoneNumber:String, \$email:String, \$password:String, \$pancardPhotoUrls:String, \$shopPhotoUrl:String, \$address:AddressType, \$bankAccountName:String, \$bankAccountIFSC:String, \$bankAccountNumber:String){
	createVendor(storeName:\$storeName, phoneNumber:\$phoneNumber, email:\$email, password:\$password, pancardPhotoUrls:\$pancardPhotoUrls, shopPhotoUrl:\$shopPhotoUrl ,address:\$address, bankAccountName:\$bankAccountName, bankAccountIFSC:\$bankAccountIFSC, bankAccountNumber:\$bankAccountNumber){
    error{
      path
      message
    }
    jwtToken
  } 
}
''';