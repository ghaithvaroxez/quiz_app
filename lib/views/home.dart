import 'package:flutter/material.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/views/play_quiz.dart';
import 'package:quiz_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'create_quiz.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Widget quizList() {
    CollectionReference quizData =
        FirebaseFirestore.instance.collection('Quiz');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
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
          }

          return new ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                return QuizTile(
                    imageUrl: snapshot.data.docs[index]
                        .data()['quizImageUrl']
                        .toString(),
                    title: snapshot.data.docs[index]
                        .data()['quizTitle']
                        .toString(),
                    description: snapshot.data.docs[index]
                        .data()['quizDescription']
                        .toString(),
                  quizId: snapshot.data.docs[index]
                      .data()['quizId'],
                );
              }
              //children: snapshot.data.docs.map((DocumentSnapshot document) {

              //   new ListTile(
              //   title: new Text(document.data()['quizTitle'].toString()),
              //   //subtitle: new Text(document.data()['company']),
              // );
              //
              // }).toList(),
              );
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

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
      ),
      body: quizList(),
// body: Container(
//   color: Colors.transparent,
// ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatefulWidget {
  final String imageUrl, title, description,quizId;
  QuizTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.description,
      @required this.quizId});

  @override
  _QuizTileState createState() => _QuizTileState();
}

class _QuizTileState extends State<QuizTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayQuiz(
          quizId: widget.quizId,
        )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  widget.imageUrl,
                  width: MediaQuery.of(context).size.width - 48,
                  fit: BoxFit.cover,
                )),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.3),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
