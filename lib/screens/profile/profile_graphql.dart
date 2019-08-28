String updateVendorAccountMutation = '''
mutation UpdateVendorAccount(\$storeName:String, \$phoneNumber:String, \$email:String, \$pancardPhotoUrls:String, \$shopPhotoUrl:String, \$vendorId:String){
  updateVendorAccount(storeName:\$storeName, phoneNumber:\$phoneNumber, email:\$email, pancardPhotoUrls:\$pancardPhotoUrls, shopPhotoUrl:\$shopPhotoUrl, vendorId:\$vendorId){
    error{
      path
      message
    }
		user{
      id
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
      address
      email
      storeName
      blocked
      panCardPhotoUrls
      shopPhotoUrl
      admin
    }
    error{
      path
      message
    }
  }
}
''';