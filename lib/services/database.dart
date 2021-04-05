import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  Future<void> addNewQuiz(Map quizData, String id) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(id)
        .set(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addNewQuestion(Map questionData, String id) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(id).
    collection("QNA")
        .add(questionData)
        .catchError((e) {
    
      print(e.toString());
    });

  }

  getQuizData()async
  {
    return  await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }
}
