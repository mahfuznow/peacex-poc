class Product {
  String name;
  String picture;
  String id;
  String old_price;
  String price;
  String description;

  Product({this.name, this.picture, this.id, this.old_price, this.price,this.description});

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
      name: json["name"].toString(),
      picture: json["images"][0]["src"].toString(),
      id: json["id"].toString(),
      old_price: json["regular_price"].toString(),
      price: json["price"].toString(),
      description: json["description"].toString(),
    );
  }
}
