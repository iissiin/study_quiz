import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_strings.dart';
import '../../core/theme/app_text_styles.dart';
import '../bloc/attempt_bloc.dart';
import '../bloc/attempt_state.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  Future<void> _finish(BuildContext context, int skipped) async {
    if (skipped > 0) {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(AppStrings.finishWithSkipsTitle),
          content: Text(
            '${AppStrings.unanswered(skipped)}. '
            '${AppStrings.finishWithSkipsText}',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text(AppStrings.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text(AppStrings.finish),
            ),
          ],
        ),
      );
      if (confirmed != true || !context.mounted) return;
    }
    context.go('/result');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttemptBloc, AttemptState>(
      builder: (context, state) {
        final total = state.questions.length;
        final skipped = state.unansweredIndexes.length;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              AppStrings.reviewTitle,
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
                        Text(
                          skipped == 0
                              ? AppStrings.allAnswered
                              : AppStrings.unanswered(skipped),
                          style: AppTextStyles.heading2.copyWith(
                            color: skipped == 0
                                ? AppColors.success
                                : AppColors.error,
                          ),
                        ),
                        const SizedBox(height: 16),
                        for (var i = 0; i < total; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              leading: state.isAnswered(state.questions[i].id)
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: AppColors.textSecondary,
                                    )
                                  : const Icon(
                                      Icons.error_outline,
                                      color: AppColors.error,
                                    ),
                              title: Text(
                                '${i + 1}. ${state.questions[i].text}',
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              tileColor: AppColors.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                  color: AppColors.border,
                                  width: 2,
                                ),
                              ),
                              onTap: () => context.go('/question/$i'),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => context.go('/question/${total - 1}'),
                        child: const Text(AppStrings.back),
                      ),
                      FilledButton(
                        onPressed: () => _finish(context, skipped),
                        child: const Text(AppStrings.finish),
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
