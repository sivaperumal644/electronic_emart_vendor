String downloadData = '''
mutation DownloadData(\$startDate:String, \$endDate:String){
  downloadData(startDate:\$startDate, endDate:\$endDate)
}
''';
