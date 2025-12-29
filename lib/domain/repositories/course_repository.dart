import 'package:e_learning/domain/entities/course.dart';

abstract class CourseRepository {
  Future<List<Course>> getCourses();
  Future<Course> getCourseById(String courseId);
}
