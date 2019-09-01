class CartItemInput {
  final String itemId;
  final double price;
  final double quantity;
  final String name;

  CartItemInput({this.itemId, this.price, this.quantity, this.name});

  factory CartItemInput.fromJson(Map json) {
    return CartItemInput(
        itemId: json['itemId'],
        price: json['price'],
        quantity: json['quantity'],
        name: json['name']);
  }
}
