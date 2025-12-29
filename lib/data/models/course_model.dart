import 'package:e_learning/domain/entities/course.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.title,
    required super.description,
    required super.language,
    required super.imageUrl,
    required super.totalLessons,
    required super.completedLessons,
    required super.xpEarned,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      language: json['language'] as String,
      imageUrl: json['imageUrl'] as String,
      totalLessons: json['totalLessons'] as int,
      completedLessons: json['completedLessons'] as int,
      xpEarned: json['xpEarned'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'language': language,
      'imageUrl': imageUrl,
      'totalLessons': totalLessons,
      'completedLessons': completedLessons,
      'xpEarned': xpEarned,
    };
  }
}
