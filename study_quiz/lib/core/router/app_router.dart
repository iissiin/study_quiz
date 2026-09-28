import 'package:go_router/go_router.dart';
import 'package:study_quiz/presentation/pages/result_page.dart';
import 'package:study_quiz/presentation/pages/review_page.dart';
import '../../presentation/pages/question_page.dart';

final appRouter = GoRouter(
  initialLocation: '/question/0',
  routes: [
    GoRoute(
      path: '/question/:index',
      builder: (context, state) =>
          QuestionPage(index: int.parse(state.pathParameters['index']!)),
    ),

    GoRoute(path: '/review', builder: (context, state) => const ReviewPage()),

    GoRoute(path: '/result', builder: (context, state) => const ResultPage()),
  ],
);
