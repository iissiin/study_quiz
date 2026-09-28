import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/question.dart';
import '../../../domain/repositories/question_repository.dart';
import 'attempt_event.dart';
import 'attempt_state.dart';

class AttemptBloc extends Bloc<AttemptEvent, AttemptState> {
  final QuestionRepository _repository;

  AttemptBloc(this._repository) : super(const AttemptState()) {
    on<AttemptStarted>(_onStarted);
    on<OptionToggled>(_onToggled);
  }

  Future<void> _onStarted(
    AttemptStarted event,
    Emitter<AttemptState> emit,
  ) async {
    emit(const AttemptState());
    try {
      final questions = await _repository.getQuestions();
      emit(AttemptState(status: AttemptStatus.ready, questions: questions));
    } catch (_) {
      emit(const AttemptState(status: AttemptStatus.failure));
    }
  }

  void _onToggled(OptionToggled event, Emitter<AttemptState> emit) {
    if (state.status != AttemptStatus.ready) return;

    final question = state.questions.firstWhere(
      (q) => q.id == event.questionId,
    );
    final current = state.selectedFor(event.questionId);

    final Set<String> updated;
    if (question.type == QuestionType.single) {
      updated = {event.optionId}; // новый вариант заменяет старый
    } else {
      updated = {...current};
      if (!updated.remove(event.optionId)) updated.add(event.optionId);
    }

    emit(
      state.copyWith(answers: {...state.answers, event.questionId: updated}),
    );
  }
}
