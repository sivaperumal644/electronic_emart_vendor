String addNewInventoryMutation = '''
mutation AddNewInventory(\$name:String, \$description:String, \$originalPrice:Float, \$sellingPrice:Float,\$category:String,\$inStock:Float,\$imageUrl:String ){
  addNewInventory(name:\$name,description:\$description,originalPrice:\$originalPrice,sellingPrice:\$sellingPrice,category:\$category,inStock:\$inStock,
  imageUrl:\$imageUrl){
    error{
      path
      message
    }
    inventory{
      id
    }
  }
}
''';

String updateInventoryMutation = '''
mutation UpdateInventory(\$inventoryId:String,\$name:String,\$description:String,\$originalPrice:Float,\$sellingPrice:Float,\$category:String,\$inStock:Float,\$imageUrl:String ){
  updateInventory(inventoryId:\$inventoryId, name:\$name,description:\$description,originalPrice:\$originalPrice,sellingPrice:\$sellingPrice,category:\$category,inStock:\$inStock,
  imageUrl:\$imageUrl){
    error{
      path
      message
    }
    inventory{
      id
    }
  }
}
''';

String deleteInventoryMutation = '''
mutation DeleteInventory(\$inventoryId:String){
  deleteInventory(inventoryId:\$inventoryId){
    error{
      path
      message
    }
    inventory{
      id
      name
    }
  }
}
''';

String getReviewsQuery = '''
query GetReviews(\$inventoryId: String){
  getReviews(inventoryId:\$inventoryId){
    averageRating
    reviews{
      id
      date
      rating
      text
      customer{
        id
        name
      }  
    }
    error{
      path
      message
    }
  }
}
''';

String getQAQuery = '''
query GetQA(\$inventoryId: String){
  getQA(inventoryId:\$inventoryId){
    id
    date
    questionText
    answerText
    customer{
      id
      name
    }
    inventory{
      id
    }
  }
}
''';

String answerQuestionMutation = '''
mutation AnswerQuestion(\$questionId: String, \$answerText: String){
  answerQuestion(questionId:\$questionId, answerText:\$answerText){
    error{
      path
      message
    }
    jwtToken
  }
}
''';
