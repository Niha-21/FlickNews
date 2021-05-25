import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/category_news.dart';
import 'package:news_app/views/preference_view.dart';
import 'package:news_app/views/front.dart';
import 'package:news_app/controllers/authentication.dart';
import 'package:share/share.dart';

var pcollections = FirebaseFirestore.instance.collection('Users');

class Home extends StatefulWidget {

  final String country;
  final String uid;
  Home({this.country,this.uid});
  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  String country="";
  bool _loading = true;
  String uid;


  _HomeState({this.country,this.uid});


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
    return WillPopScope(
      onWillPop: () async => false,
        child: Scaffold(
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
                  
                  RaisedButton(
                    onPressed:()=> signOut().whenComplete(() => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) => FrontPage()),(Route <dynamic> route)=>false)),
                    child: Text("SIGNOUT",style:TextStyle(
                    fontFamily: 'Merienda',
                    fontSize:15,
                    color: Colors.white),),
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
                 
                ],
              ),
              /// Categories
               
               
               
               Row(
                 children: [
                   IconButton(
                    icon: Icon(Icons.view_list,color: Colors.blueAccent,size: 30,),
                    onPressed:(){
                      Navigator.push(context, MaterialPageRoute(
                            builder: (context) => MyPreference(uid:widget.uid.toString())));
                    }),
                   Container(
                     height: 50,
                     color: Colors.blueAccent,
                     child: FlatButton(
                       color: Colors.blueAccent,
                       padding: EdgeInsets.only(left:20,right:139),
                          child:Text("My Preferences",style: TextStyle(fontFamily:'Merienda',fontSize: 20, color:isSwitched ? Colors.white: Colors.black ),),
                          onPressed:(){
                            Navigator.push(context, MaterialPageRoute(
                            builder: (context) => MyPreference(uid:widget.uid.toString())));
                        }, ),
                   ),
                 ],
               ),
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
                      country: widget.country,
                      uid: widget.uid,);
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
      onLongPress: (){
        
        showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.blueAccent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('Add to My Preferences ?',style: TextStyle(fontFamily:'Lemonada')),
                      FlatButton(
                        child: isSwitched? Text('ADD',style: TextStyle(fontFamily:'Lemonada',color: Colors.white)):
                                Text('ADD',style: TextStyle(fontFamily:'Lemonada',color: Colors.black)),
                        color: isSwitched ? Colors.grey.shade900:Colors.white,
                        onPressed: (){
                          setState(() {
                          //   ExtraModel xModel;

                          //   xModel = new ExtraModel();
                          //   xModel.country = widget.country;
                          //   xModel.category = widget.categoryName.toLowerCase();
                          //   data.add(xModel);
                          //   print(data[1].category);
                          // 
                          pcollections.doc(widget.uid).collection('preferences').add({
                            'category': widget.categoryName,
                            'country' : widget.country});
                            print(widget.uid);
                          });
                          
                        }
                      )
                    ],
                  ),
                ),
              );
            },
          );
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


class BlogTile extends StatelessWidget {
  final String imgUrl, title, description,url;
  BlogTile({this.imgUrl,this.title,this.description,@required this.url});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap:(){
            Navigator.push(context, MaterialPageRoute(
              builder: (context)=> ArticleView(
                blogUrl: url,
              )));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: isSwitched ? Colors.grey.shade800 : Colors.black, width: isSwitched ? 5: 3)
            ),
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imgUrl),
                  ),
                SizedBox(height: 8,),
                Text(title, style: TextStyle(
                  fontFamily: 'Lemonada',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isSwitched ? Colors.grey.shade400: Colors.black87 ,
                ),),
                // SizedBox(height: 8,),
                Text(description, style: TextStyle(fontFamily: 'Lemonada',
                  color: isSwitched ? Colors.grey.shade600: Colors.black54,))
              ],)
          ),
        ),

        IconButton(padding: EdgeInsets.only(left: 10.0,top:30.0),icon: Icon(Icons.share, color: Colors.blueAccent,size: 35,), onPressed: ()=>Share.share(url,subject: "Shared Via FlickNews"))
        ],
    );
  }
}