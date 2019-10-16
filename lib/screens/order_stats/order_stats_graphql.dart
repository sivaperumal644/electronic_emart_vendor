String orderStatsQuery = '''
query GetOrderStats(\$startDate: String, \$endDate: String){
  getOrderStats(startDate:\$startDate, endDate:\$endDate){
    date
    itemCount
    totalAmount
  }
}
''';
