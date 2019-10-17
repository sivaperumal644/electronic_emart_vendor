String getOfferPosterQuery = '''
query GetPosters{
  getPosters{
    id
    inventories{
      id
      name
      originalPrice
      sellingPrice
      description
      category
      inStock
      imageUrl
      averageRating
    }
    posterImage
  }
}
''';