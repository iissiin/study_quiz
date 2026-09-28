class AppStrings {
  AppStrings._();

  static const String appName = 'Цифровые навыки';

  static const String back = 'Назад';
  static const String next = 'Далее';
  static const String check = 'Проверить';
  static const String finish = 'Завершить';
  static const String cancel = 'Отмена';
  static const String newAttempt = 'Новая попытка';

  static const String multipleHint = 'Можно выбрать несколько';
  static String questionOf(int n, int total) => 'Вопрос $n из $total';

  static const String reviewTitle = 'Проверка перед завершением';
  static String unanswered(int n) => 'Без ответа: $n';
  static const String allAnswered = 'Все вопросы отвечены';
  static const String finishWithSkipsTitle = 'Завершить с пропусками?';
  static const String finishWithSkipsText =
      'Пропущенные вопросы получат 0 баллов.';

  static const String resultTitle = 'Результат';
  static String score(int s, int total) => '$s из $total';
  static const String yourAnswer = 'Ваш ответ:';
  static const String correctAnswer = 'Правильный ответ:';
  static const String nothingSelected = 'Не выбрано';
  static const String explanation = 'Пояснение:';
  static const String loadError = 'Не удалось загрузить вопросы';
  static String questionScore(int s) => 'Балл: $s';
}
