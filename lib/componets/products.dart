import 'package:flutter/material.dart';
import 'package:Wordpess_Flutter_Api_marwen/Model/Product.dart';
import 'package:http/http.dart' as http;
import 'package:Wordpess_Flutter_Api_marwen/Model/category.dart';
import 'package:Wordpess_Flutter_Api_marwen/productview/data.dart';
import 'dart:convert';

import 'package:Wordpess_Flutter_Api_marwen/productview/main.dart';

import '../keys.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var product_list = [];
  List<Product> productx = new List<Product>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
        future: getQuote(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: productx.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return new GestureDetector(
                    onTap: () {
                      print('sss' );

                    },
                    child: Single_prod(
                      prod_name: productx[index].name,
                      prod_pricture: productx[index].picture,
                      prod_old_price: productx[index].old_price,
                      prod_price: productx[index].price,
                      id: productx[index].id,
                      p:productx[index],
                    ),
                  );
                });
          } else {
            return GridView.builder(
                itemCount: 0,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Single_prod();
                });
          }
        });
  }

  Future<List<Product>> getQuote() async {
    String url = apiBaseuri+'/wp-json/wc/v3/products?per_page=20';

    final response = await http.get(
      url,
      headers: {},
    );
    if (response.statusCode == 200) {
      List<dynamic> s = jsonDecode(response.body);
      for (var i = 0; i < s.length; i++) {
        productx.add(Product.fromJson(s[i]));
      }
      return productx;
    } else {
      //return categories;
      throw Exception('Failed to load pos');
    }
  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_old_price;
  final prod_price;
  final id;
  final Product p;

  Single_prod({
    this.prod_name,
    this.prod_pricture,
    this.prod_old_price,
    this.prod_price,
    this.id,
    this.p,
  });

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Hero(
          tag: prod_name+''+id,
          child: Material(

            child: InkWell(

              onTap: () {print ( p.description.replaceAll(new RegExp("<[^>]*>"), ''));
              desc=p.description.replaceAll(new RegExp("<[^>]*>"), '');
              descpics=p.picture;
              descprice=p.price;
              descname=p.name;

              Navigator.of(context).pushNamed("/productview");
              },
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "\$$prod_price",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        "\$$prod_old_price",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ),
                  child: Image.network(
                    prod_pricture,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }
}
