import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/model/quiz_user.dart';

class AuthService{
FirebaseAuth _auth= FirebaseAuth.instance;
Quiz_User quiz_user;

Quiz_User _userFromfirebaseUser(User user)
{
  print(user.toString());
  return user!=null?Quiz_User(userid: user.uid):null;

}

Future signInEmailAndPass(String email,String password) async{
  try{
   // print("1");
UserCredential userCredential=await _auth.signInWithEmailAndPassword(email: email, password: password);
    //print("2");
User user=userCredential.user;
    //print("3");
return  _userFromfirebaseUser(user);
  }catch(e){
   // print("aaaaaaaaaaaaaaaaa");
    print(e.toString());
  }
}
Future signUpEmailAndPass(String email,String password) async{
  try{
UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);
User user=userCredential.user;
return _userFromfirebaseUser(user);
  }catch(e){
    print(e.toString());
  }
}

Future signOut()async {
  try {
    return await _auth.signOut();
  }
  catch (e) {
    print(e);
    return null;
  }
}


}