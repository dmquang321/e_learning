import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning/domain/entities/lesson.dart';
import 'package:e_learning/domain/usecases/get_lessons_usecase.dart';

// Events
abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class LoadLessonsEvent extends CourseEvent {
  final String courseId;

  const LoadLessonsEvent(this.courseId);

  @override
  List<Object?> get props => [courseId];
}

class CompleteLessonEvent extends CourseEvent {
  final String lessonId;

  const CompleteLessonEvent(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}

// States
abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class CourseInitial extends CourseState {
  const CourseInitial();
}

class CourseLoading extends CourseState {
  const CourseLoading();
}

class CourseLoaded extends CourseState {
  final List<Lesson> lessons;
  final int completedCount;
  final double progressPercentage;

  const CourseLoaded({
    required this.lessons,
    required this.completedCount,
    required this.progressPercentage,
  });

  @override
  List<Object?> get props => [lessons, completedCount, progressPercentage];
}

class CourseError extends CourseState {
  final String message;

  const CourseError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetLessonsUseCase getLessonsUseCase;

  CourseBloc({required this.getLessonsUseCase}) : super(const CourseInitial()) {
    on<LoadLessonsEvent>(_onLoadLessons);
    on<CompleteLessonEvent>(_onCompleteLesson);
  }

  Future<void> _onLoadLessons(
    LoadLessonsEvent event,
    Emitter<CourseState> emit,
  ) async {
    emit(const CourseLoading());
    try {
      final lessons = await getLessonsUseCase.call(event.courseId);
      
      final completedCount = lessons.where((l) => l.isCompleted).length;
      final progressPercentage =
          lessons.isEmpty ? 0.0 : (completedCount / lessons.length) * 100;

      emit(CourseLoaded(
        lessons: lessons,
        completedCount: completedCount,
        progressPercentage: progressPercentage,
      ));
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  Future<void> _onCompleteLesson(
    CompleteLessonEvent event,
    Emitter<CourseState> emit,
  ) async {
    if (state is CourseLoaded) {
      final currentState = state as CourseLoaded;
      final updatedLessons = currentState.lessons.map((lesson) {
        if (lesson.id == event.lessonId) {
          return lesson.copyWith(isCompleted: true);
        }
        return lesson;
      }).toList();

      final completedCount =
          updatedLessons.where((l) => l.isCompleted).length;
      final progressPercentage =
          updatedLessons.isEmpty ? 0.0 : (completedCount / updatedLessons.length) * 100;

      emit(CourseLoaded(
        lessons: updatedLessons,
        completedCount: completedCount,
        progressPercentage: progressPercentage,
      ));
    }
  }
}
