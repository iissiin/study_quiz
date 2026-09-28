import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_quiz/domain/usecases/calculate_score.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_strings.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/question.dart';
import '../bloc/attempt_bloc.dart';
import '../bloc/attempt_event.dart';
import '../bloc/attempt_state.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttemptBloc, AttemptState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              AppStrings.resultTitle,
              style: AppTextStyles.heading3,
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Center(
                          child: Text(
                            AppStrings.score(
                              state.score,
                              state.questions.length,
                            ),
                            style: AppTextStyles.heading1.copyWith(
                              fontSize: 40,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        for (final q in state.questions)
                          _QuestionResult(
                            question: q,
                            selected: state.selectedFor(q.id),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        context.read<AttemptBloc>().add(const AttemptStarted());
                        context.go('/question/0');
                      },
                      child: const Text(AppStrings.newAttempt),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _QuestionResult extends StatelessWidget {
  final Question question;
  final Set<String> selected;
  const _QuestionResult({required this.question, required this.selected});

  String _texts(Set<String> ids) {
    final texts = [
      for (final o in question.options)
        if (ids.contains(o.id)) o.text,
    ];
    return texts.isEmpty ? AppStrings.nothingSelected : texts.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final points = scoreQuestion(question, selected);
    final color = points == 1 ? AppColors.success : AppColors.error;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question.text, style: AppTextStyles.heading3),
          const SizedBox(height: 8),
          Text(
            '${AppStrings.yourAnswer} ${_texts(selected)}',
            style: AppTextStyles.body,
          ),
          Text(
            '${AppStrings.correctAnswer} ${_texts(question.correctOptionIds)}',
            style: AppTextStyles.body,
          ),
          const SizedBox(height: 4),
          Text(
            AppStrings.questionScore(points),
            style: AppTextStyles.bodyMedium.copyWith(color: color),
          ),
          const SizedBox(height: 8),
          Text(
            '${AppStrings.explanation} ${question.explanation}',
            style: AppTextStyles.caption,
          ),
        ],
      ),
    );
  }
}
