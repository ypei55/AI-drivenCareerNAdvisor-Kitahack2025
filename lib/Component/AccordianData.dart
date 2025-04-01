class AccordionItemData {
  final String title;
  final String score;
  final String typeOfInterview;
  final String levelOfInterview;
  final int numberOfQuestions;
  final List<QuestionAnswerScore> questionAnswerScores;

  AccordionItemData({
    required this.title,
    required this.score,
    this.typeOfInterview = '',
    this.levelOfInterview = '',
    this.numberOfQuestions = 0,
    this.questionAnswerScores = const [],
  });
}

class QuestionAnswerScore {
  final String question;
  final String answer;
  final int score;

  QuestionAnswerScore({
    required this.question,
    required this.answer,
    required this.score,
  });
}