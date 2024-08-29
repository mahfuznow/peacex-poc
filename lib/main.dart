import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//my own imports
import 'package:Wordpess_Flutter_Api_marwen/componets/horizontal_listview.dart';
import 'package:Wordpess_Flutter_Api_marwen/componets/products.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:Wordpess_Flutter_Api_marwen/Model/category.dart';
import 'package:Wordpess_Flutter_Api_marwen/productview/blogpost.dart';
import 'package:Wordpess_Flutter_Api_marwen/productview/main.dart';

import 'Model/Post.dart';
import 'keys.dart';
import 'package:flutter/services.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
    routes: <String,WidgetBuilder>{

      "/productview": (BuildContext context)=> new ProductpageG(),
      "/blogpost": (BuildContext context)=> new Blogpostview(),
    },

  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _onSelectItem() {
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductpageG()),
    );// close the drawer
  }

  Future<List<Post>> getQuote() async {
    String url = apiBaseuri+'/wp-json/wp/v2/posts?per_page=6';
    List<Post> categories = new List<Post>();

    final response = await http.get(
      url,
      headers: {},
    );
    if (response.statusCode == 200) {
      List<dynamic> s = jsonDecode(response.body);
      for (var i = 0; i < s.length; i++) {
        categories.add(Post.fromJson(s[i]));
      }
      return categories;
    } else {
      //return categories;
      throw Exception('Failed to load pos');
    }
  }
  Carousel carousel;

  @override
  Widget build(BuildContext context) {

    Widget image_carousel = new Container(
        height: 200.0,
        child: FutureBuilder<List<Post>>(
            future: getQuote(),
            builder: (context, snapshot) {
              var imagess = [];
              if (snapshot.hasData) {
                print(snapshot.data.toString());
                for (var o in snapshot.data) imagess.add(NetworkImage(o.image));
              } else {
                imagess.add(NetworkImage(apiBaseuri+'/wp-content/uploads/2019/05/test5.png'));
              }
                carousel=Carousel(
                boxFit: BoxFit.cover,
                images: imagess.toList(),
                autoplay: true,
      animationCurve: Curves.fastOutSlowIn,
//      animationDuration: Duration(milliseconds: 1000),
                dotSize: 4.0,
                indicatorBgPadding: 2.0,
              );
              return new GestureDetector(onTap: (){Navigator.of(context).pushNamed('/blogpost');},
              child: carousel,
              );
            }),
      );

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.black,
        title: Text('One act ecomm app'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          new IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              onPressed: () {})
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
//            header
            new UserAccountsDrawerHeader(
              accountName: Text('Marwen Sarraj'),
              accountEmail: Text('sarraj.marwens@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image(
                    image: AssetImage('images/Marwensarraj.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment(1, 05),
                    // 10% of the width, so there are ten blinds.
                    colors: [
                      Colors.greenAccent,
                      Colors.green[500],
                    ],
                    // whitish to gray
                    tileMode: TileMode
                        .repeated, // repeats the gradient over the canvas
                  )),
            ),

//            body

            InkWell(
              onTap: () {
                _onSelectItem();

              },
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Bio'),
                leading: Icon(Icons.person),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Experience'),
                leading: Icon(Icons.laptop),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Education'),
                leading: Icon(Icons.note),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Languages'),
                leading: Icon(Icons.language),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
      body: new Container(

        child: new ListView(
        scrollDirection: Axis.vertical,

        children: <Widget>[
          //image carousel begins here
          image_carousel,

          //padding widget
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text('Categories'),
          ),

          //Horizontal list view begins here
          HorizontalList(),

          //padding widget
          new Padding(
            padding: const EdgeInsets.all(20.0),
            child: new Text('Recent products'),
          ),

          //grid view
          Container(
            height: MediaQuery.of(context).size.height-300 ,
            child: Products(),
          )
        ],
      ),
    ),);
  }
}

class product {
  String id;
  String name;
  String slug;
  String description;
  String price;
  String regular_price;

  bool getDiscount() {
    return (price == regular_price);
  }
}
