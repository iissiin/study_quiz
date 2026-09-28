import '../entities/question.dart';

int scoreQuestion(Question question, Set<String> selected) {
  final correct = question.correctOptionIds;
  final isExact =
      selected.length == correct.length && selected.containsAll(correct);
  return isExact ? 1 : 0;
}

int calculateScore(List<Question> questions, Map<String, Set<String>> answers) {
  return questions.fold(
    0,
    (sum, q) => sum + scoreQuestion(q, answers[q.id] ?? const <String>{}),
  );
}
