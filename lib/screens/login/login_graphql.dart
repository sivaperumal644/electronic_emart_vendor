String vendorLoginMutation = '''
  mutation VendorLogin(\$phoneNumber: String, \$password: String){
  vendorLogin(phoneNumber:\$phoneNumber, password: \$password){
    user{
      id
    }
    jwtToken
    error{
      path
      message
    }
  }
}
''';
