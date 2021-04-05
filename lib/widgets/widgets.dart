import 'package:flutter/material.dart';

Widget appBar(BuildContext context)
{
  return
      RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 22),
          children: [
            TextSpan(text: 'Varoxez',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black54,),
            ),
            TextSpan(text: 'Quiz',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,),),
          ]
        ),

      );
}
Widget BlueButton({BuildContext context, String label,buttonWidth})
{
  return  Container(
    width: buttonWidth!=null? buttonWidth:MediaQuery.of(context).size.width-48,
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Colors.blue,
    ),
    child: Center(
      child: Text(
        label,
        softWrap: false,
        style: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
