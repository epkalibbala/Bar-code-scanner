// import 'dart:convert';

class ItemFields {
  static const String code = 'Item id';
  static const String id = 'Item Code';
  static const String description = 'Description';
  static const String quantityPC = 'Qty_pc';
  static const String quantityBX = 'Qty_bx';
  static const String expQuantity = 'exp_Qty';
  static const String price = "Retail Sale Price";
  static const String date = "LastUpdate";
  static const String shelfQuantity = "shelf_quantity";

  static List<dynamic> getFields() => [code, id, description, quantityPC, quantityBX, expQuantity, date, shelfQuantity];
}

class Item {
  final dynamic code;
  final dynamic id;
  final String? description;
  final dynamic quantityPC;
  final dynamic quantityBX;
  final dynamic expQuantity;
  final dynamic price;
  final dynamic date;

  const Item ({
  this.code,
  this.id,
  this.description,
  this.quantityPC,
  this.quantityBX,
  this.expQuantity,
  this.price,
  this.date
});

static Item fromJson(Map<dynamic, dynamic> json) => Item(
  code: json[ItemFields.code],
  id: json[ItemFields.id],
  description: json[ItemFields.description],
  quantityPC: json[ItemFields.quantityPC],
  quantityBX: json[ItemFields.quantityBX],
  expQuantity: json[ItemFields.expQuantity],
  price: json[ItemFields.price],
  date: json[ItemFields.date]
);

}

