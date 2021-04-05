import 'package:flutter/material.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  @override
  _AddQuestionState createState() => _AddQuestionState();
  final String quizId;
  AddQuestion({this.quizId});

}

class _AddQuestionState extends State<AddQuestion> {
  final _formkey = GlobalKey<FormState>();
  String question, ans1, ans2, ans3, ans4;
bool _isLoading=false;
DatabaseService databaseService=new DatabaseService();
createQuestion()async{

  Map<String, String> questionData = {
    "question": question,
    "option1": ans1,
    "option2": ans2,
    "option3": ans3,
    "option4": ans4,
  };

  if (_formkey.currentState.validate()) {
    setState(() {
      _isLoading = true;
    });
    await databaseService.addNewQuestion(questionData, widget.quizId);
    setState(() {
      _isLoading = false;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AddQuestion(quizId: widget.quizId,)));
  }
}
Submit()async {
  Map<String, String> questionData = {
    "question": question,
    "option1": ans1,
    "option2": ans2,
    "option3": ans3,
    "option4": ans4,
  };

  if (_formkey.currentState.validate()) {
    setState(() {
      _isLoading = true;
    });
    await databaseService.addNewQuestion(questionData, widget.quizId);
    setState(() {
      _isLoading = false;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }
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
      body: SafeArea(
        child: _isLoading?Container(child: Center(child: CircularProgressIndicator(),),):Form(
          key: _formkey,
          child: Container(
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Question",
                  ),
                  onChanged: (value) {
                    question = value;
                  },
                  validator: (val) {
                    return val.isEmpty ? "Enter question" : null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Option 1 (True)",
                  ),
                  onChanged: (value) {
                    ans1 = value;
                  },
                  validator: (val) {
                    return val.isEmpty ? "Enter Option 1" : null;
                  },
                ),
                SizedBox(
                  height: 6,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Option 2",
                  ),
                  onChanged: (value) {
                    ans2 = value;
                  },
                  validator: (val) {
                    return val.isEmpty ? "Enter Option 2" : null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Option  3",
                  ),
                  onChanged: (value) {
                    ans3 = value;
                  },
                  validator: (val) {
                    return val.isEmpty ? "Enter Option 3" : null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Option 4",
                  ),
                  onChanged: (value) {
                    ans4 = value;
                  },
                  validator: (val) {
                    return val.isEmpty ? "Enter Option 4" : null;
                  },
                ),
                Spacer(),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {    Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => Home()));},
                      child: BlueButton(
                          context: context,
                          label: "Submit",
                          buttonWidth:
                              MediaQuery.of(context).size.width / 2 - 36),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    GestureDetector(
                      onTap: () {createQuestion();},
                      child: BlueButton(
                          context: context,
                          label: "Add question",
                          buttonWidth:
                              MediaQuery.of(context).size.width / 2 - 36),
                    ),
                  ],
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
