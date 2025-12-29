import 'package:e_learning/domain/entities/lesson.dart';

class LessonModel extends Lesson {
  const LessonModel({
    required super.id,
    required super.courseId,
    required super.title,
    required super.description,
    required super.order,
    required super.isCompleted,
    required super.skills,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'] as String,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      order: json['order'] as int,
      isCompleted: json['isCompleted'] as bool,
      skills: List<String>.from(json['skills'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'order': order,
      'isCompleted': isCompleted,
      'skills': skills,
    };
  }
}
