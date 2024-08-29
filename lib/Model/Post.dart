class Post{
  String name;
  String link;
  String image;

  Post({this.name, this.link, this.image});
  factory Post.fromJson(Map<String, dynamic> json){
    return new Post(
      name: json["title"]["rendered"],
      link: json["link"],
      image: json['jetpack_featured_media_url']
    );
  }



}