import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:Wordpess_Flutter_Api_marwen/Model/category.dart';

import '../keys.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: FutureBuilder<List<Categoryx>>(
          future: getQuote(),
          builder: (context, snapshot) {
            print(context.toString());
            print(snapshot.toString());
            List<Widget> cats = new List();
            if (snapshot.hasData) {
              print(snapshot.data.toString());
              for( var o in snapshot.data)
              cats.add(Category(
                image_location: o.image,
                image_caption: o.name,
              ));
            } else {
              cats.add(Category(
                image_location:
                apiBaseuri+'/wp-content/uploads/2019/05/hoodies.jpg',
                image_caption: 'shirt',
              ));
            }
            return ListView(
              scrollDirection: Axis.horizontal,
              children: cats,
            );
          }),
    );
    ;
  }

  Future<List<Categoryx>> getQuote() async {
    String url = apiBaseuri+'/wp-json/wc/v3/products/categories';
    List<Categoryx> categories = new List<Categoryx>();

    final response = await http.get(
      url,
      headers: {},
    );
    if (response.statusCode == 200) {
      List<dynamic> s = jsonDecode(response.body);
      for (var i = 0; i < s.length ; i++) {
        categories.add(Categoryx.fromJson(s[i]));
      }
      return categories;
    } else {
      //return categories;
      throw Exception('Failed to load pos');
    }
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
              title: Image.network(
                image_location,
                width: 100.0,
                height: 80.0,
              ),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  image_caption,
                  style: new TextStyle(fontSize: 12.0),
                ),
              )),
        ),
      ),
    );
  }
}
