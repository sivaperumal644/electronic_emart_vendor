String changeOrderStatusMutation = '''
mutation ChangeOrderStatus(\$status:String, \$orderId:String){
  changeOrderStatus(status:\$status, orderId:\$orderId){
    error{
      path
      message
    }
  }
}
''';