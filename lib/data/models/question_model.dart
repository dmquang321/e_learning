import 'package:e_learning/domain/entities/question.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.lessonId,
    required super.question,
    required super.imageUrl,
    required super.type,
    required super.options,
    required super.correctAnswer,
    required super.explanation,
    required super.xpReward,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      question: json['question'] as String,
      imageUrl: json['imageUrl'] as String,
      type: QuestionType.values.firstWhere(
        (e) => e.toString() == 'QuestionType.${json['type']}',
      ),
      options: List<String>.from(json['options'] as List),
      correctAnswer: json['correctAnswer'] as String,
      explanation: json['explanation'] as String,
      xpReward: json['xpReward'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonId': lessonId,
      'question': question,
      'imageUrl': imageUrl,
      'type': type.toString().split('.').last,
      'options': options,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'xpReward': xpReward,
    };
  }
}
