String validateVendorArguments = '''
mutation ValidateVendorArguments(\$phoneNumber:String, \$email:String, \$bankAccountIFSC:String, \$bankAccountNumber:String){
  validateVendorArguments(phoneNumber:\$phoneNumber, email:\$email, bankAccountIFSC: \$bankAccountIFSC, bankAccountNumber: \$bankAccountNumber){
    phoneNumber
    email
    bankAccountIFSC
    bankAccountNumber
  }
}
''';

String canPickUpMutation = '''
mutation CanPickUp(\$pincode:String){
  canPickUp(pinCode:\$pincode)
}
''';
