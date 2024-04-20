// import 'dart:convert';

class SecondaryFields {
  static const String id = 'item_id';
  static const String barcode = 'item_code';
  static const String category = 'category';

  static List<dynamic> getFields() => [id, barcode, category];
}

class Secondary {
  final dynamic id;
  final String? barcode;
  final String? category;

  const Secondary ({
  this.id,
  this.barcode,
  this.category,
});

static Secondary fromJson(Map<dynamic, dynamic> json) => Secondary(
  id: json[SecondaryFields.id],
  barcode: json[SecondaryFields.barcode],
  category: json[SecondaryFields.category],
);

}

