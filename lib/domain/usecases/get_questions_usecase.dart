import 'package:e_learning/domain/entities/question.dart';
import 'package:e_learning/domain/repositories/lesson_repository.dart';

class GetQuestionsUseCase {
  final LessonRepository repository;

  GetQuestionsUseCase(this.repository);

  Future<List<Question>> call(String lessonId) {
    return repository.getQuestions(lessonId);
  }
}
