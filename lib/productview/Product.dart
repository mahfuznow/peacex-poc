
class Product{

   String id;
   String name;
   String slug;
   String permalink;
   String type;
   String price;
   String regular_price;
   String description;
   String image;
   String category;

   Product(this.id, this.name, this.slug, this.permalink, this.type, this.price,
       this.regular_price, this.description, this.image, this.category);

   factory Product.fromJson(Map<String ,dynamic> json){
      return Product(
          json['id'],
          json['name'],
          json['slug'],
          json['permalink'],
          json['type'],
          json['price'],
          json['regular_price'],
          json['description'],
          json['image'],
          json['category']
      );
   }


}

