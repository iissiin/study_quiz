import '../../domain/entities/question.dart';
import '../../domain/repositories/question_repository.dart';

class LocalQuestionRepository implements QuestionRepository {
  @override
  Future<List<Question>> getQuestions() async => _questions;

  static const _questions = [
    Question(
      id: 'q1',
      type: QuestionType.single,
      text: 'Что хранит JSON?',
      options: [
        QuestionOption(id: 'a', text: 'Структурированные данные'),
        QuestionOption(id: 'b', text: 'Только картинки'),
      ],
      correctOptionIds: {'a'},
      explanation:
          'JSON хранит структурированные данные в текстовом виде, а не только картинки.',
    ),
    Question(
      id: 'q2',
      type: QuestionType.single,
      text: 'Что означает HTTP 404?',
      options: [
        QuestionOption(id: 'a', text: 'Ресурс не найден'),
        QuestionOption(id: 'b', text: 'Успешное сохранение'),
      ],
      correctOptionIds: {'a'},
      explanation: 'Код 404 означает, что сервер не нашёл запрошенный ресурс.',
    ),
    Question(
      id: 'q3',
      type: QuestionType.multiple,
      text: 'Какие данные нельзя публиковать в учебном репозитории?',
      options: [
        QuestionOption(id: 'a', text: 'Пароль'),
        QuestionOption(id: 'b', text: 'Ключ API'),
        QuestionOption(id: 'c', text: 'README'),
      ],
      correctOptionIds: {'a', 'b'},
      explanation:
          'Пароли и ключи API публиковать нельзя, а README — обычное описание проекта.',
    ),
    Question(
      id: 'q4',
      type: QuestionType.multiple,
      text: 'Какие состояния стоит показать при загрузке?',
      options: [
        QuestionOption(id: 'a', text: 'Ожидание'),
        QuestionOption(id: 'b', text: 'Ошибка'),
        QuestionOption(id: 'c', text: 'Случайный цвет фона'),
      ],
      correctOptionIds: {'a', 'b'},
      explanation:
          'Пользователю нужно показать ожидание и ошибку, а случайный цвет фона ничего не сообщает.',
    ),
  ];
}
