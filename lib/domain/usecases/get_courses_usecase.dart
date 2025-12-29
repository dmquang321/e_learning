import 'package:e_learning/domain/entities/course.dart';
import 'package:e_learning/domain/repositories/course_repository.dart';

class GetCoursesUseCase {
  final CourseRepository repository;

  GetCoursesUseCase(this.repository);

  Future<List<Course>> call() {
    return repository.getCourses();
  }
}
