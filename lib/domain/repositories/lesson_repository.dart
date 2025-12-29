import 'package:e_learning/domain/entities/lesson.dart';
import 'package:e_learning/domain/entities/question.dart';

abstract class LessonRepository {
  Future<List<Lesson>> getLessonsByCourse(String courseId);
  Future<Lesson> getLessonById(String lessonId);
  Future<List<Question>> getQuestions(String lessonId);
}
