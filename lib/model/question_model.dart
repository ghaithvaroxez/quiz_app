class QuestionModel {

  final String question;
   String option1;
   String option2;
   String option3;
    String option4;
  final String correctOption;
   bool answered;

  QuestionModel({this.question, this.option1, this.option2, this.option3, this.option4, this.correctOption, this.answered}){
    List<String> options=[
      option1,option2,option3,option4
    ];
    options.shuffle();
    option1=options[0];
    option2=options[1];
    option3=options[2];
    option4=options[3];
  }

}