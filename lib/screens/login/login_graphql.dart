String vendorLoginMutation = '''
  mutation VendorLogin(\$phoneNumber: String, \$password: String){
  vendorLogin(phoneNumber:\$phoneNumber, password: \$password){
    user{
      id
      address
    }
    jwtToken
    error{
      path
      message
    }
  }
}
''';
