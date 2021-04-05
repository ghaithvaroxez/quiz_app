import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/helper/functions.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/sinup.dart';
import 'package:quiz_app/widgets/widgets.dart';

class SingIn extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SingIn> {
  final _formkey = GlobalKey<FormState>();
  String email, password;
  bool isLoading=false;
  AuthService authService=new AuthService();

signIn()async
{
  if(_formkey.currentState.validate())
    {
    setState(() {
      isLoading=true;
    });
await authService.signInEmailAndPass(email, password).then((value) {


  setState(() {
        isLoading=false;
      });
if(value!=null)
  Helper.setUserLoggedInDetails(true);
else Helper.setUserLoggedInDetails(false);
    value!=null?Navigator.pushReplacement(context, MaterialPageRoute
      (builder: (context)=>Home())
    ):isLoading=false;

}
);
    }
}
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Firebase.initializeApp();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        brightness: Brightness.light,
      ),
      drawer: Drawer(child: Container(color:Colors.red),),
      body: isLoading==true ? Container(child: Center(child: CircularProgressIndicator(),),):Form(
        key: _formkey,
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Spacer(),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (val) {
                    return val.isEmpty ? "Enter Email" : null;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (val) {
                    return val.isEmpty ? "Enter password" : null;
                  },
                ),
                SizedBox(
                  height: 24,
                ),
            GestureDetector(
              onTap: ()
              {
                signIn();
              },
            child: BlueButton(context:context, label:"Sign in"),
            ),

                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 15.5,
                      ),
                    ),
                    GestureDetector(
                        child: Text(
                      "Sign up",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15.5,
                      ),
                    ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SingUp()));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
