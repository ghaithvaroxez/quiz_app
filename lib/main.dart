import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/views/add_question.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/views/login.dart';
import 'package:quiz_app/views/signin.dart';

import 'helper/functions.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  bool _isLoggedIn=false;
  void initState() {
    // TODO: implement initState
    super.initState();
checKUserLoggedInStatus();
  }

  checKUserLoggedInStatus()async
  {
   _isLoggedIn= await Helper.getUserLoggedInDetails();
  }
  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  @override

  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Container(color: Colors.black,);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return  MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(

              primarySwatch: Colors.blue,
            ),
            // home: LoginThreePage(),
            home:(_isLoggedIn??false)?Home():SingIn(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(color: Colors.black,);
      },
    );
  }
}