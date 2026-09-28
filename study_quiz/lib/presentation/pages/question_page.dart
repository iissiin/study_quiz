import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_strings.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/question.dart';
import '../bloc/attempt_bloc.dart';
import '../bloc/attempt_event.dart';
import '../bloc/attempt_state.dart';

class QuestionPage extends StatelessWidget {
  final int index;
  const QuestionPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttemptBloc, AttemptState>(
      builder: (context, state) {
        if (state.status != AttemptStatus.ready) {
          return Scaffold(
            body: Center(
              child: state.status == AttemptStatus.loading
                  ? const CircularProgressIndicator()
                  : const Text(AppStrings.loadError),
            ),
          );
        }

        final total = state.questions.length;
        final question = state.questions[index];
        final selected = state.selectedFor(question.id);
        final answered = total - state.unansweredIndexes.length;
        final isLast = index == total - 1;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.questionOf(index + 1, total),
              style: AppTextStyles.heading3,
            ),
            // Индикатор отвеченных вопросов
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(6),
              child: LinearProgressIndicator(
                value: answered / total,
                minHeight: 6,
                color: AppColors.success,
                backgroundColor: AppColors.border,
              ),
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
                        Text(question.text, style: AppTextStyles.heading2),
                        if (question.type == QuestionType.multiple) ...[
                          const SizedBox(height: 4),
                          const Text(
                            AppStrings.multipleHint,
                            style: AppTextStyles.caption,
                          ),
                        ],
                        const SizedBox(height: 16),
                        _Options(question: question, selected: selected),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: index == 0
                            ? null
                            : () => context.go('/question/${index - 1}'),
                        child: const Text(AppStrings.back),
                      ),
                      FilledButton(
                        onPressed: () => context.go(
                          isLast ? '/review' : '/question/${index + 1}',
                        ),
                        child: Text(
                          isLast ? AppStrings.check : AppStrings.next,
                        ),
                      ),
                    ],
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

class _Options extends StatelessWidget {
  final Question question;
  final Set<String> selected;
  const _Options({required this.question, required this.selected});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AttemptBloc>();
    void toggle(String optionId) =>
        bloc.add(OptionToggled(question.id, optionId));
    final isSingle = question.type == QuestionType.single;

    final tiles = [
      for (final o in question.options)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: isSingle
              ? RadioListTile<String>(
                  value: o.id,
                  title: Text(o.text),
                  selected: selected.contains(o.id),
                  tileColor: AppColors.surface,
                  selectedTileColor: AppColors.primaryLight,
                  shape: _tileShape(selected.contains(o.id)),
                )
              : CheckboxListTile(
                  value: selected.contains(o.id),
                  onChanged: (_) => toggle(o.id),
                  title: Text(o.text),
                  controlAffinity: ListTileControlAffinity.leading,
                  selected: selected.contains(o.id),
                  tileColor: AppColors.surface,
                  selectedTileColor: AppColors.primaryLight,
                  shape: _tileShape(selected.contains(o.id)),
                ),
        ),
    ];

    if (!isSingle) return Column(children: tiles);

    return RadioGroup<String>(
      groupValue: selected.firstOrNull,
      onChanged: (id) {
        if (id != null) toggle(id);
      },
      child: Column(children: tiles),
    );
  }
}

ShapeBorder _tileShape(bool selected) => RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(12),
  side: BorderSide(
    color: selected ? AppColors.primary : AppColors.border,
    width: 2,
  ),
);
