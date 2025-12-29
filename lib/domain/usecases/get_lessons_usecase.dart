import 'package:e_learning/domain/entities/lesson.dart';
import 'package:e_learning/domain/repositories/lesson_repository.dart';

class GetLessonsUseCase {
  final LessonRepository repository;

  GetLessonsUseCase(this.repository);

  Future<List<Lesson>> call(String courseId) {
    return repository.getLessonsByCourse(courseId);
  }
}
