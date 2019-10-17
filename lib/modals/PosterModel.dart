import 'package:electronic_emart_vendor/modals/InventoryModel.dart';

class PosterModel {
  final String id;
  final List<Inventory> inventory;
  final String posterImage;

  PosterModel({
    this.id,
    this.inventory,
    this.posterImage,
  });

  factory PosterModel.fromJson(Map json) {
    List inventories = json['inventories'];
    return PosterModel(
      id: json['id'],
      inventory: inventories.map((inventory) => Inventory.fromJson(inventory)).toList(),
      posterImage: json['posterImage'],
    );
  }
}
