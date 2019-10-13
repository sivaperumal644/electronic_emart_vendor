class QuestionAnswer {
  final String id;
  final String questionText;
  final String answerText;

  QuestionAnswer({
    this.id,
    this.questionText,
    this.answerText,
  });

  factory QuestionAnswer.fromJson(Map json){
    return QuestionAnswer(
      id: json['id'],
      questionText: json['questionText'],
      answerText: json['answerText']
    );
  }
}
