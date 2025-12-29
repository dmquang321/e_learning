import 'package:equatable/equatable.dart';

enum QuestionType { multipleChoice, fillInTheBlanks, matching }

class Question extends Equatable {
  final String id;
  final String lessonId;
  final String question;
  final String imageUrl;
  final QuestionType type;
  final List<String> options;
  final String correctAnswer;
  final String explanation;
  final int xpReward;

  const Question({
    required this.id,
    required this.lessonId,
    required this.question,
    required this.imageUrl,
    required this.type,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.xpReward,
  });

  @override
  List<Object?> get props => [
        id,
        lessonId,
        question,
        imageUrl,
        type,
        options,
        correctAnswer,
        explanation,
        xpReward,
      ];
}
