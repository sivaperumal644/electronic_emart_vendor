import 'InventoryModel.dart';

class CartItemInput {
  final String id;
  final Inventory inventory;
  final String itemStatus;

  CartItemInput({
    this.id,
    this.inventory,
    this.itemStatus,
  });

  factory CartItemInput.fromJson(Map json) {
    return CartItemInput(
      id: json['id'],
      inventory: Inventory.fromJson(json['inventory']),
      itemStatus: json['itemStatus'],
    );
  }
}
