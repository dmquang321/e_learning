import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning/domain/entities/course.dart';
import 'package:e_learning/domain/usecases/get_courses_usecase.dart';

// Events
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadCoursesEvent extends HomeEvent {
  const LoadCoursesEvent();
}

class RefreshCoursesEvent extends HomeEvent {
  const RefreshCoursesEvent();
}

// States
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Course> courses;
  final int totalXp;
  final int streak;

  const HomeLoaded({
    required this.courses,
    required this.totalXp,
    required this.streak,
  });

  @override
  List<Object?> get props => [courses, totalXp, streak];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCoursesUseCase getCoursesUseCase;

  HomeBloc({required this.getCoursesUseCase}) : super(const HomeInitial()) {
    on<LoadCoursesEvent>(_onLoadCourses);
    on<RefreshCoursesEvent>(_onRefreshCourses);
  }

  Future<void> _onLoadCourses(
    LoadCoursesEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      final courses = await getCoursesUseCase.call();
      
      // Calculate total XP and streak from courses
      int totalXp = 0;
      for (var course in courses) {
        totalXp += course.xpEarned;
      }
      
      emit(HomeLoaded(
        courses: courses,
        totalXp: totalXp,
        streak: 3, // Mock streak
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onRefreshCourses(
    RefreshCoursesEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _onLoadCourses(const LoadCoursesEvent(), emit);
  }
}
