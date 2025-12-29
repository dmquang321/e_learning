import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning/core/constants/app_constants.dart';
import 'package:e_learning/presentation/bloc/course/course_bloc.dart';
import 'package:e_learning/presentation/widgets/lesson_tile.dart';
import 'package:e_learning/presentation/widgets/progress_bar.dart';

class CourseScreen extends StatefulWidget {
  final String courseId;

  const CourseScreen({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final CourseBloc _courseBloc;

  @override
  void initState() {
    super.initState();
    _courseBloc = context.read<CourseBloc>();
    _courseBloc.add(LoadLessonsEvent(widget.courseId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocListener<CourseBloc, CourseState>(
        listener: (context, state) {
          if (state is CourseError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<CourseBloc, CourseState>(
          builder: (context, state) {
            if (state is CourseLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: const Color(AppConstants.primaryColor),
                ),
              );
            }

            if (state is CourseLoaded) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(AppConstants.primaryColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Progress',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${state.completedCount}/${state.lessons.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ProgressBar(
                            progress:
                                state.progressPercentage / 100,
                            backgroundColor:
                                Colors.white.withOpacity(0.3),
                            progressColor: const Color(
                              AppConstants.successColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${state.progressPercentage.toStringAsFixed(0)}% complete',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Lessons Section
                    const Text(
                      'Lessons',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...state.lessons
                        .map((lesson) => LessonTile(
                              lesson: lesson,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  '/lesson',
                                  arguments: lesson.id,
                                );
                              },
                            ))
                        .toList(),
                  ],
                ),
              );
            }

            return Center(
              child: Text(
                'Something went wrong',
                style: TextStyle(color: Colors.grey[600]),
              ),
            );
          },
        ),
      ),
    );
  }
}
