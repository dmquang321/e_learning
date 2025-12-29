import 'package:e_learning/data/data_sources/local_data_source.dart';
import 'package:e_learning/data/data_sources/remote_data_source.dart';
import 'package:e_learning/domain/entities/course.dart';
import 'package:e_learning/domain/repositories/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  CourseRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<Course>> getCourses() async {
    try {
      // Try remote first
      final courses = await remoteDataSource.getCourses();
      await localDataSource.saveCourses(courses);
      return courses;
    } catch (e) {
      // Fall back to local
      return await localDataSource.getCourses();
    }
  }

  @override
  Future<Course> getCourseById(String courseId) async {
    try {
      final courses = await getCourses();
      return courses.firstWhere((course) => course.id == courseId);
    } catch (e) {
      rethrow;
    }
  }
}
