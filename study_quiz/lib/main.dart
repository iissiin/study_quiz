import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_strings.dart';
import 'data/repositories/local_question_repository.dart';
import 'presentation/bloc/attempt_bloc.dart';
import 'presentation/bloc/attempt_event.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) =>
          AttemptBloc(LocalQuestionRepository())..add(const AttemptStarted()),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.appName,
      routerConfig: appRouter,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        scaffoldBackgroundColor: AppColors.background,
      ),
    );
  }
}
