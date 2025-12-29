import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning/core/service_locator/service_locator.dart';
import 'package:e_learning/core/theme/app_theme.dart';
import 'package:e_learning/presentation/bloc/home/home_bloc.dart';
import 'package:e_learning/presentation/bloc/course/course_bloc.dart';
import 'package:e_learning/presentation/bloc/lesson/lesson_bloc.dart';
import 'package:e_learning/presentation/screens/home_screen.dart';
import 'package:e_learning/presentation/screens/course_screen.dart';
import 'package:e_learning/presentation/screens/lesson_screen.dart';

void main() {
  setupServiceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => sl<HomeBloc>(),
        ),
        BlocProvider<CourseBloc>(
          create: (context) => sl<CourseBloc>(),
        ),
        BlocProvider<LessonBloc>(
          create: (context) => sl<LessonBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'E-Learning',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
        routes: {
          '/course': (context) {
            final courseId = ModalRoute.of(context)!.settings.arguments as String;
            return CourseScreen(courseId: courseId);
          },
          '/lesson': (context) {
            final lessonId = ModalRoute.of(context)!.settings.arguments as String;
            return LessonScreen(lessonId: lessonId);
          },
        },
      ),
    );
  }
}
