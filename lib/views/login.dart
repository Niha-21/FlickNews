

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:news_app/controllers/authentication.dart';
import 'package:news_app/views/forgot_password.dart';
import 'package:news_app/views/signup.dart';

import 'front.dart';
import 'home.dart';
import 'home1.dart';

class Login extends StatefulWidget {

  String value;
  Login({this.value});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
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
      body: SingleChildScrollView(
              child: Column(
          children: [

            Container(
              
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 130,),
                    
                    Row(children: [
                    FlatButton(
                      padding: EdgeInsets.only(left:230),
                      onPressed:(){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ForgotPassword()));
                    } ,
                    child: Text("Forgot Password ?",style: TextStyle(
                      fontFamily:'Merienda',
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: isSwitched? Colors.white: Colors.grey.shade700,
                    )),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: isSwitched? Colors.grey.shade900: Colors.white,
                    ),
                  ],),
                  
                Container(
                  width:300,
                  color: Colors.blueAccent,
                  child: TextFormField(
                  validator: (input){
                    if(input.isEmpty)
                    return "Enter Email";
                  },
                  decoration: InputDecoration(
                    hintText: "Your Email",
                    labelText: "Email",
                    hintStyle: TextStyle(fontFamily:'Merienda',color:isSwitched? Colors.grey.shade900: Colors.white),
                    labelStyle: TextStyle(fontFamily:'Merienda',color:isSwitched? Colors.white: Colors.black),
                    prefixIcon: Icon(Icons.email,color: isSwitched? Colors.white: Colors.black)
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
                    hintText: "Your Password",
                    labelText: "Password",
                    hintStyle: TextStyle(fontFamily:'Merienda',color:isSwitched? Colors.grey.shade900: Colors.white),
                    labelStyle: TextStyle(fontFamily:'Merienda',color:isSwitched? Colors.white: Colors.black),
                    prefixIcon: Icon(Icons.lock,color: isSwitched? Colors.white: Colors.black),
                    // suffixIcon: Icon(Icons.visibility)
                  ),
                  obscureText: true,
                  onChanged: (input){
                    _password = input;
                  }
                  ,),),
                  // Container(height: 5,),

                  

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[

                    Text("Don't have Account?",style: TextStyle(
                      fontFamily:'Merienda',
                      fontSize: 15,
                      color: isSwitched? Colors.white:Colors.blueAccent,
                    )),
                    FlatButton(
                      padding: EdgeInsets.only(left:50),
                      onPressed:(){
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SignUp(value: widget.value.toString(),)));
                    } ,
                    child: Text("SIGNUP",style: TextStyle(
                      fontFamily:'Lemonada',
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: isSwitched? Colors.white: Colors.blueAccent,
                    )),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: isSwitched? Colors.grey.shade900: Colors.white,
                    ),
                  ])
              ],)),
              
            ),

            RaisedButton(
              padding: EdgeInsets.fromLTRB(70,20,70,20),
              onPressed: (){
                if(_email!=null && _password!=null)
                signIn(_email, _password).whenComplete((){
                  User user = FirebaseAuth.instance.currentUser;
              msg==""? valid ? Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home(country: widget.value.toString(),uid: user.uid,))):Navigator.pop(context):
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 180,
                      color: Colors.blueAccent,
                      child: Center(
                        child:Text(msg,style:TextStyle(fontFamily: 'Lemonada',fontSize: 20)),
                        ),
                    );
                  },
                );});
                setState(() {
                  msg="";
                });},
              child: Text("LOGIN",style:TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold,
              color: isSwitched? Colors.blueAccent:Colors.white),),
              color: isSwitched? Colors.white:Colors.grey.shade700,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
              Container(height: 10,),
              
              Container(
                color: isSwitched? Colors.grey.shade900:Colors.grey.shade700,
                padding: EdgeInsets.all(10),
                child: SignInButton(
                Buttons.Google,
                padding: EdgeInsets.all(20),
                text: "SIGN IN WITH GOOGLE",
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
                onPressed:(){
                  googlesignIn().whenComplete((){
                    User user = FirebaseAuth.instance.currentUser;
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home(country: widget.value.toString(),uid: user.uid,)));});},
                ),
              ), 

              FlatButton(onPressed:(){
                Navigator.push(context, MaterialPageRoute(
                builder: (context) => Home1(country: widget.value.toString(),)));
              } ,
              child: Text("Skip Login and Continue",style: TextStyle(
                fontFamily:'Lemonada',
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: isSwitched? Colors.white: Colors.blueAccent,
              )),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: isSwitched? Colors.grey.shade900: Colors.white,
              ),
          ],
        ),
      ),
    );
  }

}

