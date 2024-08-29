class Categoryx {
  final String name;
  final String slug;
  final String image;
  final String id;

  Categoryx({this.name, this.slug, this.image, this.id});

  factory Categoryx.fromJson(Map<String, dynamic> json) {

    return new Categoryx(
      name: json['name'] ,
      slug: json['slug'] ,
      image: json['image']['src'] ,
      id: json['id'].toString(),
    );
  }

}