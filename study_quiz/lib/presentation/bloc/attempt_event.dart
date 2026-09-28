import 'package:equatable/equatable.dart';

abstract class AttemptEvent extends Equatable {
  const AttemptEvent();

  @override
  List<Object?> get props => [];
}

class AttemptStarted extends AttemptEvent {
  const AttemptStarted();
}

class OptionToggled extends AttemptEvent {
  final String questionId;
  final String optionId;

  const OptionToggled(this.questionId, this.optionId);

  @override
  List<Object?> get props => [questionId, optionId];
}
