import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
FirebaseAuth _auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();
String msg="";
bool valid = true;

Future<bool>googlesignIn()async{
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  if(googleSignInAccount != null )
  {
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  UserCredential result = await _auth.signInWithCredential(credential);

  User user = _auth.currentUser;
  print("HELLO"+user.uid);
  }
  return Future.value(true);
}


Future<bool> signIn(String email, String password)async{
  try{
  UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
  User user = result.user;
  valid=true;
  return Future.value(true);
  }
  catch(e){
    switch(e.code){
      case 'invalid-email':print("invalid-email");
                            valid=false;
                            msg="Please Check Email";
                            break;
      case 'user-not-found':print("User Not Found");
                            valid = false;
                            msg="No Such User Exists";
                            break;
      case 'wrong-password':print("Wrong Password");
                            valid = false;
                            msg="Password Is Invalid For Given Email";
                            break;
    }
  }
}


Future<bool> signUp(String email, String password)async{
  try{
  UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
  User user = result.user;
  valid=true;
  return Future.value(true);
  }
  catch(e){
    switch(e.code){
      case 'email-already-in-use':print("email-already-in-use");
                                  valid =false;
                                  msg="This Email Is Already In Use";
                                  break;
      case 'invalid-email':print("invalid-email");
                                  valid =false;
                                  msg="Email Entered is Invalid";
                                  break;
      case 'weak-password':print("weak-Password");
                                  valid =false;
                                  msg="Please Enter Strong Password";
                                  break;
    }
  }
}

Future<bool> signOut()async{
  User user = _auth.currentUser;
  if(user.providerData[1].providerId == "google.com")
  {
    await googleSignIn.disconnect();
  }  
  await _auth.signOut();

  return Future.value(true);
}

Future<void> passwordReset(String email)async{
  try{
    await _auth.sendPasswordResetEmail(email: email);
    valid = true;
  }
  catch(e){
    print(e);
    msg="Error Occurred! Please enter correct email";
    valid = false;
  }
}