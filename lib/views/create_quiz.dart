import 'package:flutter/material.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

import 'add_question.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();
  String Url, title, desc;
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  String quizId;
  createQuiz() async {
    quizId = randomAlphaNumeric(16);
    //  print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
    Map<String, String> quizData = {
      "quizId": quizId,
      "quizImageUrl": Url,
      "quizTitle": title,
      "quizDescription": desc,
    };
    if (_formkey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      await databaseService.addNewQuiz(quizData, quizId);
      setState(() {
        _isLoading = false;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddQuestion(quizId: quizId)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: _isLoading
          ? Container(
              child: Center(
              child: CircularProgressIndicator(),
            ))
          : Form(
              key: _formkey,
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Quiz image url(optional)",
                        ),
                        onChanged: (value) {
                          Url = value;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Quiz title",
                        ),
                        onChanged: (value) {
                          title = value;
                        },
                        validator: (val) {
                          return val.isEmpty ? "Enter quiz title" : null;
                        },
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Quiz Description",
                        ),
                        onChanged: (value) {
                          desc = value;
                        },
                        validator: (val) {
                          return val.isEmpty ? "Enter description" : null;
                        },
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      GestureDetector(
                        onTap: () {
                          createQuiz();
                        },
                        child:
                            BlueButton(context: context, label: "Create Quiz"),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
