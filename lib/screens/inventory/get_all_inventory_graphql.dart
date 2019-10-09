String getVendorInventoryQuery = '''
query GetVendorInventory{
  getVendorInventory{
    error{
      path
      message
    }
    inventory{
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
  }
}
''';

