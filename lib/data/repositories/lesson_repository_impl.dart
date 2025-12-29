import 'package:e_learning/data/data_sources/local_data_source.dart';
import 'package:e_learning/data/data_sources/remote_data_source.dart';
import 'package:e_learning/domain/entities/lesson.dart';
import 'package:e_learning/domain/entities/question.dart';
import 'package:e_learning/domain/repositories/lesson_repository.dart';

class LessonRepositoryImpl implements LessonRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  LessonRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<Lesson>> getLessonsByCourse(String courseId) async {
    try {
      // Try remote first
      final lessons = await remoteDataSource.getLessonsByCourse(courseId);
      return lessons;
    } catch (e) {
      // Fall back to local
      return await localDataSource.getLessonsByCourse(courseId);
    }
  }

  @override
  Future<Lesson> getLessonById(String lessonId) async {
    // This would need refactoring based on actual API response
    throw UnimplementedError();
  }

  @override
  Future<List<Question>> getQuestions(String lessonId) async {
    try {
      // Try remote first
      final questions = await remoteDataSource.getQuestions(lessonId);
      return questions;
    } catch (e) {
      // Fall back to local
      return await localDataSource.getQuestions(lessonId);
    }
  }
}
