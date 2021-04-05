import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/helper/functions.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:quiz_app/widgets/widgets.dart';

import 'home.dart';

class SingUp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SingUp> {
  final _formkey1 = GlobalKey<FormState>();
  String name, email, password;
  bool isLoading = false;
  AuthService authService = new AuthService();
  signUp() async {
    if (_formkey1.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await authService.signUpEmailAndPass(email, password).then((value) {
        if(value!=null)
          Helper.setUserLoggedInDetails(true);
        else Helper.setUserLoggedInDetails(false);
        setState(() {
          isLoading = false;
        });
        value != null
            ? Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Home()))
            : value = null;
      });
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
      drawer: Drawer(
        child: Container(color: Colors.blue),
      ),
      endDrawer: Drawer(
        child: Container(
          color: Colors.black,
        ),
      ),
      body: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formkey1,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Spacer(),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Name",
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (val) {
                          return val.isEmpty ? "Enter Name" : null;
                        },
                      ),
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
                        onTap: () {
                          signUp();
                        },
                        child: BlueButton(
                          context: context,
                          label: "Sing up",
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              fontSize: 15.5,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 15.5,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>SingUp()));
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
