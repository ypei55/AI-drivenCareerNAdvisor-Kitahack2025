class AccordionItemData {
  final String title;
  final String score;
  final List<QuestionAnswerScore> questionAnswerScores;

  AccordionItemData({
    required this.title,
    required this.score,
    this.questionAnswerScores = const [],
  });
}

class QuestionAnswerScore {
  final String question;
  final String answer;
  final String feedback;
  final int score;

  QuestionAnswerScore({
    required this.question,
    required this.answer,
    required this.feedback,
    required this.score,
  });
}