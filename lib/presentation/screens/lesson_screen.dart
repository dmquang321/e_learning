import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning/core/constants/app_constants.dart';
import 'package:e_learning/presentation/bloc/lesson/lesson_bloc.dart';
import 'package:e_learning/presentation/widgets/app_button.dart';
import 'package:e_learning/presentation/widgets/xp_badge.dart';

class LessonScreen extends StatefulWidget {
  final String lessonId;

  const LessonScreen({
    super.key,
    required this.lessonId,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late final LessonBloc _lessonBloc;

  @override
  void initState() {
    super.initState();
    _lessonBloc = context.read<LessonBloc>();
    _lessonBloc.add(LoadQuestionsEvent(widget.lessonId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocListener<LessonBloc, LessonState>(
        listener: (context, state) {
          if (state is LessonError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<LessonBloc, LessonState>(
          builder: (context, state) {
            if (state is LessonLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: const Color(AppConstants.primaryColor),
                ),
              );
            }

            if (state is LessonLoaded) {
              if (state.isLessonComplete) {
                return _buildLessonComplete(context, state);
              }

              final question = state.currentQuestion;
              if (question == null) {
                return const Center(child: Text('No questions'));
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Question ${state.currentQuestionIndex + 1}/${state.questions.length}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(AppConstants.primaryColor),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${state.correctAnswers} correct',
                            style: TextStyle(
                              color: Colors.green[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: (state.currentQuestionIndex + 1) /
                          state.questions.length,
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(AppConstants.primaryColor),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Question Image
                    if (question.imageUrl.isNotEmpty)
                      Center(
                        child: Text(
                          question.imageUrl,
                          style: const TextStyle(fontSize: 64),
                        ),
                      ),
                    const SizedBox(height: 24),

                    // Question Text
                    Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Options
                    ...question.options
                        .asMap()
                        .entries
                        .map((entry) {
                          final option = entry.value;
                          final isSelected =
                              state.lastAnswer == option;
                          final isCorrect =
                              option == question.correctAnswer;
                          final showResult =
                              state.lastAnswer != null;

                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: 12),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: state.lastAnswer == null
                                    ? () {
                                        _lessonBloc.add(
                                          AnswerQuestionEvent(
                                            questionId:
                                                question.id,
                                            selectedAnswer:
                                                option,
                                            isCorrect:
                                                option ==
                                                    question
                                                        .correctAnswer,
                                          ),
                                        );
                                      }
                                    : null,
                                borderRadius:
                                    BorderRadius.circular(12),
                                child: Container(
                                  padding:
                                      const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                    border: Border.all(
                                      color: showResult
                                          ? (isSelected
                                              ? (isCorrect
                                                  ? Colors
                                                      .green
                                                  : Colors
                                                      .red)
                                              : (isCorrect
                                                  ? Colors
                                                      .green
                                                  : Colors
                                                      .transparent))
                                          : Colors.grey[300]!,
                                      width: 2,
                                    ),
                                    color: showResult
                                        ? (isSelected
                                            ? (isCorrect
                                                ? Colors
                                                    .green[50]
                                                : Colors
                                                    .red[50])
                                            : (isCorrect
                                                ? Colors
                                                    .green[50]
                                                : Colors
                                                    .transparent))
                                        : Colors.white,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          option,
                                          style:
                                              TextStyle(
                                            fontSize: 16,
                                            fontWeight:
                                                FontWeight
                                                    .w500,
                                            color: showResult
                                                ? (isSelected ||
                                                        isCorrect
                                                    ? (isCorrect
                                                        ? Colors
                                                            .green[900]
                                                        : Colors
                                                            .red[900])
                                                    : Colors
                                                        .black87)
                                                : Colors
                                                    .black87,
                                          ),
                                        ),
                                      ),
                                      if (showResult)
                                        Icon(
                                          isCorrect
                                              ? Icons.check_circle
                                              : Icons
                                                  .cancel,
                                          color: isCorrect
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        })
                        .toList(),
                    const SizedBox(height: 32),

                    // Explanation
                    if (state.lastAnswer != null)
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.blue[200]!,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Explanation',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              question.explanation,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 24),

                    // Continue Button
                    if (state.lastAnswer != null)
                      AppButton(
                        text: state.currentQuestionIndex ==
                                state.questions.length - 1
                            ? 'Finish'
                            : 'Continue',
                        onPressed: () {
                          _lessonBloc.add(const NextQuestionEvent());
                        },
                      ),
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

  Widget _buildLessonComplete(BuildContext context, LessonLoaded state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '🎉',
              style: TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 24),
            const Text(
              'Lesson Complete!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'You answered ${state.correctAnswers} out of ${state.questions.length} questions correctly',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                XpBadge(xp: state.totalXpEarned),
                const SizedBox(width: 16),
                Text(
                  '+${state.totalXpEarned} XP',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(AppConstants.accentColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            AppButton(
              text: 'Back to Course',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
