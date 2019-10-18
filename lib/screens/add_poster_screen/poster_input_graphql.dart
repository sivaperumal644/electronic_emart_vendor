String addPosterMutation = '''
mutation AddPoster(\$inventoryIds:[String], \$posterImage: String, \$posterId:String){
  addPoster(inventoryIds:\$inventoryIds, posterImage:\$posterImage, posterId:\$posterId){
    error{
      path
      message
    }
    poster{
      id
    }
  }
}
''';

String deletePosterMutation = '''
mutation DeletePoster(\$posterId:String){
  deletePoster(posterId:\$posterId){
    error{
      path
      message
    }
    poster{
      id
    }
  }
}
''';
