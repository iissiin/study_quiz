import 'package:equatable/equatable.dart';
import 'package:study_quiz/domain/usecases/calculate_score.dart';
import '../../../domain/entities/question.dart';

enum AttemptStatus { loading, ready, failure }

class AttemptState extends Equatable {
  final AttemptStatus status;
  final List<Question> questions;

  final Map<String, Set<String>> answers;

  const AttemptState({
    this.status = AttemptStatus.loading,
    this.questions = const [],
    this.answers = const {},
  });

  Set<String> selectedFor(String questionId) =>
      answers[questionId] ?? const <String>{};

  bool isAnswered(String questionId) => selectedFor(questionId).isNotEmpty;

  List<int> get unansweredIndexes => [
    for (var i = 0; i < questions.length; i++)
      if (!isAnswered(questions[i].id)) i,
  ];

  int get score => calculateScore(questions, answers);

  AttemptState copyWith({Map<String, Set<String>>? answers}) => AttemptState(
    status: status,
    questions: questions,
    answers: answers ?? this.answers,
  );

  @override
  List<Object?> get props => [status, questions, answers];
}
