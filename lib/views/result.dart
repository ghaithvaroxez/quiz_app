import 'package:flutter/material.dart';

class Results extends StatefulWidget {
  final int correct,incorrect,total;

   Results({ this.correct, this.incorrect, this.total}) ;

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
child: Column(
  children: [
    Text("${widget.correct}/${widget.total}"),
    SizedBox(height: 8,),
    Text("You answerd ${widget.correct} answers correctly and ${widget.incorrect} answers incorrectly"),
  ],
),
        ),
      ),
    );
  }
}
