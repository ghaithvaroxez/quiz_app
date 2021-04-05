import 'package:flutter/material.dart';


// ignore: camel_case_types
class OptionTile extends StatefulWidget {
  final String option,description,correctAnswer,optionSelected;

  const OptionTile({Key key, this.option, this.description, this.correctAnswer, this.optionSelected}) : super(key: key);
  @override
  _optionTileState createState() => _optionTileState();
}

class _optionTileState extends State<OptionTile> {
 @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 28,
width: 28,

decoration: BoxDecoration(
border: Border.all(width: 1.5,color: widget.optionSelected==""?Colors.grey:widget.description==widget.correctAnswer?Colors.green.withOpacity(0.7):Colors.red.withOpacity(0.7)),
borderRadius: BorderRadius.circular(30),
    color: widget.optionSelected==""?Colors.grey.withOpacity(0.1):widget.description==widget.correctAnswer?Colors.green.withOpacity(0.7):Colors.red.withOpacity(0.7),
),
            child: Text("${widget.option}",style: TextStyle(
              color:Colors.black54,
//backgroundColor: widget.optionSelected==""?Colors.grey:widget.description==widget.correctAnswer?Colors.green.withOpacity(0.7):Colors.red.withOpacity(0.7)
            ),),
alignment: Alignment.center,
          ),
SizedBox(width: 8,),
          Text(widget.description,style: TextStyle(
            fontSize: 16,color: Colors.black54
          ),),
        ],
      ),
    );
  }
}
