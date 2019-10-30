String updateVendorAccountMutation = '''
mutation UpdateVendorAccount(\$storeName:String, \$phoneNumber:String, \$email:String, \$pancardPhotoUrls:String, \$shopPhotoUrl:String, \$vendorId:String, \$address: AddressType, \$bankAccountName:String, \$bankAccountNumber:String, \$bankAccountIFSC: String, \$vendorGSTNumber: String){
  updateVendorAccount(storeName:\$storeName, phoneNumber:\$phoneNumber, email:\$email, pancardPhotoUrls:\$pancardPhotoUrls, shopPhotoUrl:\$shopPhotoUrl, vendorId:\$vendorId, address:\$address, bankAccountName:\$bankAccountName, bankAccountNumber:\$bankAccountNumber, bankAccountIFSC: \$bankAccountIFSC, vendorGSTNumber:\$vendorGSTNumber){
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
