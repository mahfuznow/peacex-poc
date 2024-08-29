import 'package:flutter/material.dart';
import 'package:Wordpess_Flutter_Api_marwen/productview/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../keys.dart';
import 'data.dart';

class Blogpostview extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
      return Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black12, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  tileMode: TileMode.clamp)),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: screenAwareSize(20.0, context),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text("PieceX "+ descname,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenAwareSize(18.0, context),
                        fontFamily: "Montserrat-Bold")),
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      size: screenAwareSize(20.0, context),
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              body: WebView(

                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: blogposturi)

      ));
  }
}


