import 'package:flutter/material.dart';
import 'package:news_app/controllers/authentication.dart';
import 'package:news_app/views/login.dart';

import 'front.dart';


class SignUp extends StatefulWidget {
  String value="";
  SignUp({this.value});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email, _password;
  
  @override
  void initState(){
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
            Text("Flick", style: TextStyle(fontFamily:'Merienda',fontSize: 30,
              color: isSwitched ? Colors.white : Colors.black),),
            Text("News", style: TextStyle(fontFamily:'Merienda',
              color: Colors.blue,fontSize: 30) ),
              Container(width: 60,)
          ]
        ),
        elevation: 3,
      ),
      backgroundColor: isSwitched? Colors.grey.shade900: Colors.white,
      body: SingleChildScrollView(
              child: Column(
          children: [

            Container(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(height: 150,),
                  Container(
                  width:300,
                  color: Colors.blueAccent,                  
                  child: TextFormField(
                  validator: (input){
                    if(input.isEmpty)
                    return "Enter Email";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Email",
                    hintStyle: TextStyle(fontFamily:'Merienda',color:isSwitched? Colors.grey.shade900: Colors.white),
                    labelStyle: TextStyle(fontFamily:'Merienda',color:isSwitched? Colors.white: Colors.black),
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email,color: isSwitched? Colors.white: Colors.black),
                  ),
                  onChanged: (input){
                    _email = input;
                  }
                  ,),),

                  Container(height: 10,),

                  Container(
                  width:300,
                  color: Colors.blueAccent,
                  child: TextFormField(
                  validator: (input){
                    if(input.length<6)
                    return "Enter Password of Minimum 6 Characters";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Strong Password",
                    labelText: "Password",
                    hintStyle: TextStyle(fontFamily:'Merienda',color:isSwitched? Colors.grey.shade900: Colors.white),
                    labelStyle: TextStyle(fontFamily:'Merienda',color:isSwitched? Colors.white: Colors.black),
                    prefixIcon: Icon(Icons.lock,color: isSwitched? Colors.white: Colors.black)
                  ),
                  obscureText: true,
                  onChanged: (input){
                    _password = input;
                  }
                  ,),),
                  Container(height: 10,),
              ],)),
              
            ),

            RaisedButton(
              padding: EdgeInsets.fromLTRB(70,20,70,20),
              onPressed:(){ 
                if(_email!=null && _password!=null)
                signUp(_email, _password).whenComplete(() => msg==""? valid? Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Login(value: widget.value.toString(),))):Navigator.pop(context):
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 180,
                      color: Colors.blueAccent,
                      child: Center(
                        child:Text(msg,style:TextStyle(fontFamily:'Lemonada',fontSize: 20)),
                      ),
                    );
                  },
                ));
                setState(() {
                  msg="";
                });},
            child: Text("SIGN UP",style:TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold,
              color: isSwitched? Colors.blueAccent:Colors.white),),
              color: isSwitched? Colors.white:Colors.grey.shade700,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),)
          ],
        ),
      ),
    );
  }
}