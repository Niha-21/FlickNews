import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

import 'login.dart';

bool isSwitched = false;

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googlesignin =   GoogleSignIn();

class _FrontPageState extends State<FrontPage> {
    String value = "";

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Stack(
        children:[
          AnimatedBackground(),
       
      Center(
        // 
          child: Column(
          children: [
          AnimatedBackground(),
            Container(height: 100.0,),

            Padding(
              padding: EdgeInsets.all(5.0),
              child:DropdownButton<String>(
                items: [
                  DropdownMenuItem<String>(
                  value:"in",
                  child: Center(child:Text("India",style: TextStyle(fontSize:20,fontFamily:'Merienda',)),
                  )
                  ),

                  DropdownMenuItem<String>(
                  value:"us",
                  child: Center(child: Text("USA",style: TextStyle(fontSize:20,fontFamily:'Merienda',))
                  ),
                  ),

                  DropdownMenuItem<String>(
                  value:"gb",
                  child: Center(child: Text("Britain",style: TextStyle(fontSize:20,fontFamily:'Merienda',))
                  ),
                  ),

                  DropdownMenuItem<String>(
                  value:"ca",
                  child: Center(child: Text("Canada",style: TextStyle(fontSize:20,fontFamily:'Merienda',))
                  ),
                  ),

                  DropdownMenuItem<String>(
                  value:"nz",
                  child: Center(child: Text("New Zealand",style: TextStyle(fontSize:20,fontFamily:'Merienda',))
                  ),
                  ),
                ],
                onChanged:(_value) =>{
                  print(_value.toString()),
                  setState((){
                    value = _value;
                    if(value!=""){
                  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Login(value: value.toString(),)));
                }
                  })
                },
                hint:Text("Select Country",style:TextStyle(fontFamily:'Merienda',color: isSwitched? Colors.grey:Colors.black)),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Text("Flick", style: TextStyle(
              color: isSwitched? Colors.white:Colors.black,
              fontFamily:'Merienda',
              fontSize:50,
              // fontWeight:FontWeight.w900
              )),

              Text("News", style: TextStyle(
              color: Colors.blue[900],
              fontFamily:'Merienda',
              fontSize:50,
              fontWeight:FontWeight.w900)),
              ]),
              AnimatedWave(height: 50,speed: 2,offset: 0.0,),
            Container(height:350),
            // buildTextField('Email',Icons.account_circle),
            // buildTextField('Password',Icons.lock),
            Center(
            child: Switch(
              value: isSwitched,
              onChanged: (value){
                setState(() {
                  isSwitched=value;
                  print(isSwitched);
                });
                isSwitched?showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 100,
                      color: Colors.blueAccent,
                      child: Center(
                        child:Text("Dark Mode Enabled",style:TextStyle(color:Colors.black,fontFamily: 'Lemonada',fontSize: 15)),
                        ),
                    );
                  },
                ):showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 100,
                      color: Colors.blueAccent,
                      child: Center(
                        child:Text("Normal Mode Enabled",style:TextStyle(color:Colors.white,fontFamily: 'Lemonada',fontSize: 15)),
                        ),
                    );
                  },
                );
              },
              activeTrackColor: Colors.grey.shade700,
              activeColor: Colors.white,
              ),
            ),
          //   Container(
          // height: 300,
          // decoration: BoxDecoration(
          //   image:DecorationImage(
          //     image: AssetImage("assets/images/newsdemo.jpg"),
          //       fit: BoxFit.cover)
          //       )),
          ],
        ),
        
      ),
      
      ]),
    );
  }
}


class AnimatedBackground extends StatelessWidget {

  Widget child;
  @override
  AnimatedBackground({this.child});
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: isSwitched? Colors.black:Colors.black12, end: isSwitched? Colors.black:Colors.lightBlue.shade900)),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Colors.blueAccent.shade700, end: isSwitched? Colors.blue.shade900:Colors.blue.shade600))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [animation["color1"], animation["color2"]])),
                  
        );
      },
    );
  }
}

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;
  AnimatedWave({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final white1 = Paint()..color = Colors.white.withAlpha(30);
    final white2 = Paint()..color = Colors.white.withAlpha(50);

    final path = Path();
    final path1 = Path();
    final path2 = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final y11 = sin(value);
    final y21 = sin(value + pi / 2);
    final y31 = sin(value + pi);

    final y12 = sin(value);
    final y22 = sin(value + pi / 2);
    final y32 = sin(value + pi);

    final startPointY = size.height * (0.5 + 1 * y1);
    final controlPointY = size.height * (0.5 + 2 * y2);
    final endPointY = size.height * (0.5 + 0.7 * y3);

    final startPointY1 = size.height * (0.5 + 0.2 * y11);
    final controlPointY1 = size.height * (0.7 + 3 * y21);
    final endPointY1 = size.height * (0.1 + 1 * y31);

    final startPointY2 = size.height * (0.3 + 4 * y12);
    final controlPointY2 = size.height * (0.5 + 2 * y22);
    final endPointY2 = size.height * (0.3 + 0.3 * y32);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(300, 100);
    path.close();

    path1.moveTo(size.width * 0, startPointY1);
    path1.quadraticBezierTo(
        size.width * 0.5, controlPointY1, size.width, endPointY1);
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();

    path2.moveTo(size.width * 0, startPointY2);
    path2.quadraticBezierTo(
        size.width * 0.5, controlPointY2, size.width, endPointY2);
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(path, white);
    canvas.drawPath(path1, white1);
    canvas.drawPath(path2, white2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}