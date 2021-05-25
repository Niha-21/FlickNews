import 'package:flutter/material.dart';
import 'package:news_app/controllers/authentication.dart';
import 'package:news_app/views/front.dart';
class ForgotPassword extends StatefulWidget {
  static String id = 'forgot-password';

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  String email;
  final _formKey = GlobalKey<FormState>();
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
      backgroundColor: isSwitched ? Colors.grey.shade900 : Colors.white,
      body: Form(
        key:_formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 10,),
             Container(
                width:300,
                color: Colors.blueAccent,
                child: TextFormField(
                  decoration: InputDecoration(
                  hintText: "Enter email to reset password",
                  labelText: "Email",
                  hintStyle: TextStyle(fontFamily:'Merienda',color:isSwitched? Colors.grey.shade900: Colors.white),
                    labelStyle: TextStyle(fontFamily:'Merienda',color:isSwitched? Colors.white: Colors.black),
                  prefixIcon: Icon(Icons.email,color: isSwitched? Colors.white:Colors.black,)
                ),
                onChanged: (input){
                  email = input;
                }
                ,),),
            SizedBox(height: 20),
                RaisedButton(
              padding: EdgeInsets.fromLTRB(70,20,70,20),
              onPressed: (){
                // setState(() {
                //   msg="";
                // });
                passwordReset(email);
                valid? showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 180,
                      color: Colors.blueAccent,
                      child: Center(
                        child:Text("Reset Link Mailed",style:TextStyle(fontFamily: 'Lemonada',fontSize: 20)),
                        ),
                    );
                  },
                ):
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 180,
                      color: Colors.blueAccent,
                      child: Center(
                        child:Text(msg,style:TextStyle(fontFamily: 'Lemonada',fontSize: 15)),
                        ),
                    );
                  },
                );
                
              },
              child: Text("RESET",style:TextStyle(
              fontSize:20,
              fontWeight: FontWeight.bold,
              color: isSwitched? Colors.blueAccent:Colors.white),),
              color: isSwitched? Colors.white:Colors.grey.shade700,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),),
            
          ],
        ),
      ),
    );
  }
}