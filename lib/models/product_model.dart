class ProductModel {
  String? image;
  String? title;
  String? description;
  String? category;
  List<String>? type;
  List<String>? size;
  List<String>? drink;

  ProductModel();

  ProductModel.fromMap(Map<String, dynamic> map) {
    image = map['image'];
    title = map['title'];
    description = map['description'];
    type = map['type'];
    size = map['size'];
    drink = map['drink'];
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'description': description,
      'type': type,
      'size': size,
      'drink': drink,
    };
  }
}
