import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'category_news.dart';
import 'package:news_app/views/front.dart';
 
var pcollections = FirebaseFirestore.instance.collection('Users');

class MyPreference extends StatefulWidget {

  final String uid;
  MyPreference({this.uid});
  @override
  _MyPreferenceState createState() => _MyPreferenceState();
}

class _MyPreferenceState extends State<MyPreference> {
  String uid;
  User user = FirebaseAuth.instance.currentUser;
  _MyPreferenceState({this.uid});
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isSwitched ? Colors.grey.shade900 : Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flick", style: TextStyle(fontFamily:'Merienda',
              color: isSwitched ? Colors.white : Colors.black,fontSize: 30),),
            Text("News", style: TextStyle(fontFamily:'Merienda',
              color: Colors.blue,fontSize: 30) ),
              Container(width: 60,)
          ]
        ),
        elevation: 3,
      ),
      backgroundColor: isSwitched? Colors.grey.shade900: Colors.white,
      body:StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').doc(widget.uid).collection('preferences').snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                DocumentSnapshot ds = snapshot.data.docs[index];
                String id = ds.id;
                return ReferCard(country:ds['country'],category:ds['category'],uid: widget.uid,did:id);
          });
          }
          else
          return Text("No data Found");
        },
              
      ),
      
    );
  }
}

class ReferCard extends StatefulWidget {
  var  country,category;
  String uid,did;
  ReferCard({this.country,this.category,this.uid,this.did});
  @override
  _ReferCardState createState() => _ReferCardState();
}

class _ReferCardState extends State<ReferCard> {
  String country="";
  String getData(){
    setState(() {
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
    return country;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          IconButton(
                    icon: Icon(Icons.location_on,color: Colors.blueAccent,size: 30,),
                    onPressed:(){
                      
                    }),
          Text(getData(),style: TextStyle(fontFamily:'Merienda',fontSize:20,color:isSwitched ? Colors.grey.shade400: Colors.black ),),
          Text(" - "+widget.category.toUpperCase(), style: TextStyle(fontFamily:'Merienda',fontSize:17,color:isSwitched ? Colors.grey.shade400: Colors.black )),
        ],
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            category: widget.category.toLowerCase(),
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
                      const Text('Delete Your Preference',style: TextStyle(fontFamily:'Lemonada')),
                      FlatButton(
                        child: isSwitched? Text('DELETE',style: TextStyle(fontFamily:'Lemonada',color: Colors.white)):
                                Text('DELETE',style: TextStyle(fontFamily:'Lemonada',color: Colors.black)),
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
                          pcollections.doc(widget.uid).collection('preferences').doc(widget.did).delete();
                          
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
    );
  }
}