import 'package:dio/dio.dart';
import 'package:e_learning/data/models/course_model.dart';
import 'package:e_learning/data/models/lesson_model.dart';
import 'package:e_learning/data/models/question_model.dart';

abstract class RemoteDataSource {
  Future<List<CourseModel>> getCourses();
  Future<List<LessonModel>> getLessonsByCourse(String courseId);
  Future<List<QuestionModel>> getQuestions(String lessonId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final Dio dio;

  RemoteDataSourceImpl(this.dio);

  @override
  Future<List<CourseModel>> getCourses() async {
    try {
      // TODO: Implement actual API call when backend is ready
      // final response = await dio.get('/courses');
      // return (response.data as List)
      //     .map((course) => CourseModel.fromJson(course))
      //     .toList();
      throw UnimplementedError();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<LessonModel>> getLessonsByCourse(String courseId) async {
    try {
      // TODO: Implement actual API call when backend is ready
      throw UnimplementedError();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<QuestionModel>> getQuestions(String lessonId) async {
    try {
      // TODO: Implement actual API call when backend is ready
      throw UnimplementedError();
    } catch (e) {
      rethrow;
    }
  }
}
