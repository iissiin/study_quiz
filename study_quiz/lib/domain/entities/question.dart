import 'package:equatable/equatable.dart';

enum QuestionType { single, multiple }

class QuestionOption extends Equatable {
  final String id;
  final String text;

  const QuestionOption({required this.id, required this.text});

  @override
  List<Object?> get props => [id, text];
}

class Question extends Equatable {
  final String id;
  final QuestionType type;
  final String text;
  final List<QuestionOption> options;
  final Set<String> correctOptionIds;
  final String explanation;

  const Question({
    required this.id,
    required this.type,
    required this.text,
    required this.options,
    required this.correctOptionIds,
    required this.explanation,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    text,
    options,
    correctOptionIds,
    explanation,
  ];
}
