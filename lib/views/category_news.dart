import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/views/home.dart';
import 'package:news_app/views/front.dart';

class CategoryNews extends StatefulWidget {

  final String category, country;
  CategoryNews({this.category, this.country});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading =true;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews()async{
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getCategoryNews(widget.country,widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
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
      body: _loading ? Center(
                child: Container(
            child: CircularProgressIndicator(),
            ),
        ) : SingleChildScrollView(
                  child: Container(
            child: Column(
              children: [
                /// Blogs
                Container(
                  padding: EdgeInsets.all(10),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context,index){
                      return BlogTile(
                        imgUrl: articles[index].urltoImage,
                        title: articles[index].title,
                        description: articles[index].description, 
                        url: articles[index].url,
                        );
                    },
                  )
                ),
              ],
            ),),
        ),
      );
  }
}