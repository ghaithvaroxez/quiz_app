import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/model/question_model.dart';
import 'package:quiz_app/views/play_quiz_widgets.dart';
import 'package:quiz_app/views/result.dart';
import 'package:quiz_app/widgets/widgets.dart';

import 'home.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;
  PlayQuiz({@required this.quizId});
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int _total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  @override
  void initState() {
    // TODO: implement initState
    print("${widget.quizId}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black.withOpacity(0.7)),
      ),
      body: Container(
        //margin: EdgeInsets.symmetric(horizontal: 24),
        child: QuestionList(widget.quizId),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Results(correct: _correct,incorrect: _incorrect,total: _total,),),);
        },
      ),
    );

  }
}

Widget QuestionList(String quizId) {
  CollectionReference quizData = FirebaseFirestore.instance
      .collection('Quiz')
      .doc(quizId)
      .collection('QNA');
  return Container(
    //margin: EdgeInsets.symmetric(horizontal: 24),
    child: StreamBuilder<QuerySnapshot>(
      stream: quizData.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          _total = snapshot.data.docs.length;
          return new ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24,),
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return QuestionTile(
                  index: index,
                  questionModel: new QuestionModel(
                    question:
                        snapshot.data.docs[index].data()['question'].toString(),
                    option1:
                        snapshot.data.docs[index].data()['option1'].toString(),
                    option2:
                        snapshot.data.docs[index].data()['option2'].toString(),
                    option3: snapshot.data.docs[index].data()['option3'],
                    option4: snapshot.data.docs[index].data()['option4'],
                    correctOption:
                        snapshot.data.docs[index].data()['option1'].toString(),
                    answered: false,
                  ),
                  // q: snapshot.data.docs[index]
                  //     .data()['question']
                  //     .toString(),
                  // o1: snapshot.data.docs[index]
                  //     .data()['option1']
                  //     .toString(),
                  // o2: snapshot.data.docs[index]
                  //     .data()['option2']
                  //     .toString(),
                  // o3: snapshot.data.docs[index]
                  //     .data()['option3'],
                  // o4: snapshot.data.docs[index]
                  //     .data()['option4'],
                );
              });
        }
      },
    ),
  );
}

class QuestionTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuestionTile({this.index, this.questionModel});
  @override
  _QeustionTileState createState() => _QeustionTileState();
}

class _QeustionTileState extends State<QuestionTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Q"+
                widget.index.toString()
                +" ",
                style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.w600),
              ),
              Text(
                widget.questionModel.question,
                style: TextStyle(color: Colors.black54, fontSize: 18,fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),

          GestureDetector(
              onTap: () {
                if(!widget.questionModel.answered)
                  {
                    if(widget.questionModel.correctOption==widget.questionModel.option1)
                      {
optionSelected=widget.questionModel.option1;
widget.questionModel.answered =true;
_correct+=1;
_notAttempted-=1;
setState(() {

});
                      } else {
                      optionSelected=widget.questionModel.option1;
                      widget.questionModel.answered =true;
                      _incorrect+=1;
                      _notAttempted-=1;
                      setState(() {

                      });
                    }
                  }
              },
              child: OptionTile(
                option: "A",
                optionSelected: optionSelected,
                correctAnswer: widget.questionModel.correctOption,
                description: widget.questionModel.option1,
              )),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
          onTap: () {
    if(!widget.questionModel.answered)
    {
    if(widget.questionModel.correctOption==widget.questionModel.option2)
    {
    optionSelected=widget.questionModel.option2;
    widget.questionModel.answered =true;
    _correct+=1;
    _notAttempted-=1;
    setState(() {

    });
    } else {
    optionSelected=widget.questionModel.option2;
    widget.questionModel.answered =true;
    _incorrect+=1;
    _notAttempted-=1;
    setState(() {

    });
    }
    }
    },
              child: OptionTile(
                option: "B",
                optionSelected: optionSelected,
                correctAnswer: widget.questionModel.correctOption,
                description: widget.questionModel.option2,
              )),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
              onTap: () {
                if(!widget.questionModel.answered)
                {
                  if(widget.questionModel.correctOption==widget.questionModel.option3)
                  {
                    optionSelected=widget.questionModel.option3;
                    widget.questionModel.answered =true;
                    _correct+=1;
                    _notAttempted-=1;
                    setState(() {

                    });
                  } else {
                    optionSelected=widget.questionModel.option3;
                    widget.questionModel.answered =true;
                    _incorrect+=1;
                    _notAttempted-=1;
                    setState(() {

                    });
                  }
                }
              },
              child: OptionTile(
                option: "C",
                optionSelected: optionSelected,
                correctAnswer: widget.questionModel.correctOption,
                description: widget.questionModel.option3,
              )),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
              onTap: () {
                if(!widget.questionModel.answered)
                {
                  if(widget.questionModel.correctOption==widget.questionModel.option4)
                  {
                    optionSelected=widget.questionModel.option4;
                    widget.questionModel.answered =true;
                    _correct+=1;
                    _notAttempted-=1;
                    setState(() {

                    });
                  } else {
                    optionSelected=widget.questionModel.option4;
                    widget.questionModel.answered =true;
                    _incorrect+=1;
                    _notAttempted-=1;
                    setState(() {

                    });
                  }
                }
              },
              child: OptionTile(
                option: "D",
                optionSelected: optionSelected,
                correctAnswer: widget.questionModel.correctOption,
                description: widget.questionModel.option4,
              )),
          SizedBox(
            height: 20,
          ),
          // Text(widget.o1),
          // Text(widget.o2),
          // Text(widget.o3),
          // Text(widget.o4),
        ],
      ),
    );
  }
}
