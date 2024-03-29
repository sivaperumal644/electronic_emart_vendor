String addNewInventoryMutation = '''
mutation AddNewInventory(\$name:String, \$description:String, \$originalPrice: Float, \$sellingPrice:Float, \$category:String, \$inStock:Float, \$imageUrl:String, \$length:Float, \$breadth:Float, \$height:Float){
  addNewInventory(name:\$name, description:\$description, originalPrice:\$originalPrice, sellingPrice:\$sellingPrice, category:\$category, inStock:\$inStock, imageUrl: \$imageUrl, length: \$length, breadth: \$breadth, height:\$height){
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
mutation UpdateInventory(\$inventoryId:String, \$name:String, \$originalPrice:Float, \$sellingPrice:Float, \$description:String, \$category:String, \$inStock:Float, \$imageUrl:String, \$length:Float, \$breadth:Float, \$height:Float){
  updateInventory(inventoryId:\$inventoryId, name:\$name, originalPrice:\$originalPrice, sellingPrice:\$sellingPrice, description:\$description, category:\$category, inStock:\$inStock, imageUrl:\$imageUrl, length:\$length, breadth:\$breadth, height:\$height){
    error{
      path
      message
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
      images  
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

String deleteQuestionMutation = '''
mutation DeleteQuestion(\$questionId:String){
  deleteQuestion(questionId:\$questionId){
    error{
      path
      message
    }
    qa{
      id
    }
  }
}
''';
