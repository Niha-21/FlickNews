import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/views/category_news.dart';
import 'package:news_app/views/front.dart';
import 'package:news_app/views/home.dart';

var pcollections = FirebaseFirestore.instance.collection('Users');

class Home1 extends StatefulWidget {

  final String country;
  Home1({this.country});
  
  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  String country="";
  bool _loading = true;
  _Home1State({this.country});


  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews()async{
    News newsClass = News();
    await newsClass.getNews(widget.country);
    articles = newsClass.news;
    setState(() {
      _loading = false;
      if(widget.country=="in")
      country = "India";
      else if(widget.country=="us")
      country = "USA";
      else if(widget.country=="ca")
      country = "Canada";
      else if(widget.country=="gb")
      country = "Great Britain";
      else if(widget.country=="nz")
      country = "New Zealand";
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
              Text("News", style: TextStyle(fontFamily:'Merienda',
                color: Colors.blue,fontSize: 30) ),
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
                  padding: EdgeInsets.symmetric(horizontal:16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.location_on,color: Colors.blueAccent,size: 30,),
                    onPressed:(){}),

                  Expanded(child: 
                  Container(
                    child:Text("$country",style: TextStyle(fontFamily:'Merienda',fontSize: 20, color:isSwitched ? Colors.white: Colors.black ),),
                    height: 30.0,
                    width: 100.0,
                  ),),
                  
                  
                ],
              ),
              /// Categories
              
              Container(height: 10,),
              Container(
                height: 80,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return CategoryTile(
                      imgURL: categories[index].imgURL,
                      categoryName: categories[index].categoryName,
                      country: widget.country,);
                  },),
              ),

              /// Blogs
              Container(
                padding: EdgeInsets.only(top: 10),
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
            ],),
          ),
        ),
      
    );
  }
}


class CategoryTile extends StatefulWidget {
  final imgURL, categoryName,country,uid;
  CategoryTile({this.imgURL,this.categoryName,this.country,this.uid});
  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
    final imgURL, categoryName,country,uid;
  _CategoryTileState({this.imgURL,this.categoryName,this.country,this.uid});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            category: widget.categoryName.toLowerCase(),
            country: widget.country,)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: isSwitched ? Colors.black: Colors.blueAccent,width: 4)
              ),
              
              child: CachedNetworkImage(
                imageUrl:widget.imgURL, width: 120, height: 80, fit:BoxFit.cover)),
            Container(
              alignment: Alignment.center,
              width: 126, height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: isSwitched ? Colors.grey[300]:Colors.blueAccent),
                color: Colors.black45),
              child: Text(widget.categoryName, style:TextStyle(
                fontFamily: 'Merienda',
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              )),)
          ],
        ),
      ),
    );
  }
}

