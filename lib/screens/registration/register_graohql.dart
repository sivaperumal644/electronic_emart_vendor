String createVendorMutation = '''
mutation CreateVendor(\$storeName:String, \$phoneNumber:String, \$email:String, \$password:String, \$pancardPhotoUrl:String, \$shopPhotoUrl:String, \$address:AddressType){
	createVendor(storeName:\$storeName, phoneNumber:\$phoneNumber, email:\$email, password:\$password, pancardPhotoUrls:\$pancardPhotoUrl, shopPhotoUrl:\$shopPhotoUrl ,address:\$address){
    error{
      path
      message
    }
    jwtToken
  } 
}
''';