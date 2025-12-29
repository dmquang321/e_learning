import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:e_learning/data/data_sources/local_data_source.dart';
import 'package:e_learning/data/data_sources/remote_data_source.dart';
import 'package:e_learning/data/repositories/course_repository_impl.dart';
import 'package:e_learning/data/repositories/lesson_repository_impl.dart';
import 'package:e_learning/domain/repositories/course_repository.dart';
import 'package:e_learning/domain/repositories/lesson_repository.dart';
import 'package:e_learning/domain/usecases/get_courses_usecase.dart';
import 'package:e_learning/domain/usecases/get_lessons_usecase.dart';
import 'package:e_learning/domain/usecases/get_questions_usecase.dart';
import 'package:e_learning/presentation/bloc/course/course_bloc.dart';
import 'package:e_learning/presentation/bloc/lesson/lesson_bloc.dart';
import 'package:e_learning/presentation/bloc/home/home_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // External
  sl.registerSingleton<Dio>(Dio());

  // Data Sources
  sl.registerSingleton<LocalDataSource>(LocalDataSourceImpl());
  sl.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl(sl<Dio>()));

  // Repositories
  sl.registerSingleton<CourseRepository>(
    CourseRepositoryImpl(
      localDataSource: sl<LocalDataSource>(),
      remoteDataSource: sl<RemoteDataSource>(),
    ),
  );
  sl.registerSingleton<LessonRepository>(
    LessonRepositoryImpl(
      localDataSource: sl<LocalDataSource>(),
      remoteDataSource: sl<RemoteDataSource>(),
    ),
  );

  // Use Cases
  sl.registerSingleton<GetCoursesUseCase>(
    GetCoursesUseCase(sl<CourseRepository>()),
  );
  sl.registerSingleton<GetLessonsUseCase>(
    GetLessonsUseCase(sl<LessonRepository>()),
  );
  sl.registerSingleton<GetQuestionsUseCase>(
    GetQuestionsUseCase(sl<LessonRepository>()),
  );

  // BLoCs
  sl.registerSingleton<HomeBloc>(
    HomeBloc(getCoursesUseCase: sl<GetCoursesUseCase>()),
  );
  sl.registerSingleton<CourseBloc>(
    CourseBloc(getLessonsUseCase: sl<GetLessonsUseCase>()),
  );
  sl.registerSingleton<LessonBloc>(
    LessonBloc(getQuestionsUseCase: sl<GetQuestionsUseCase>()),
  );
}
