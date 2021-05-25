import 'dart:async';
import 'package:news_app/views/front.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ArticleView extends StatefulWidget {
  final String blogUrl;
  ArticleView({this.blogUrl});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _completer = Completer<WebViewController>();
  
  num position = 1 ;
 
  final key = UniqueKey();
 
  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }
 
  startLoading(String A){
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isSwitched ? Colors.grey.shade900 : Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flick", style: TextStyle(
              color: isSwitched ? Colors.white : Colors.black,fontFamily:'Merienda',fontSize: 30),),
            Text("News", style: TextStyle(
              color: Colors.blue,fontFamily:'Merienda',fontSize: 30) ),
              Container(width: 60,)
          ]
        ),
        elevation: 3,
      ),
      backgroundColor: isSwitched? Colors.grey.shade900: Colors.white,
      body:IndexedStack(
        index: position,
        children: [
          Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: WebView(
            initialUrl: widget.blogUrl,
            onWebViewCreated: ((WebViewController webViewController){
              _completer.complete(webViewController);
            }),
            onPageFinished: doneLoading,
             onPageStarted: startLoading,
          )
        ),

        Container(
        color: isSwitched? Colors.grey.shade900:Colors.white,
        child: Center(
          child: CircularProgressIndicator()),
        ),
        ],
          
      ),
    );
  }
}