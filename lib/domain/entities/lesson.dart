import 'package:equatable/equatable.dart';

class Lesson extends Equatable {
  final String id;
  final String courseId;
  final String title;
  final String description;
  final int order;
  final bool isCompleted;
  final List<String> skills;

  const Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    required this.order,
    required this.isCompleted,
    required this.skills,
  });

  @override
  List<Object?> get props =>
      [id, courseId, title, description, order, isCompleted, skills];

  Lesson copyWith({
    String? id,
    String? courseId,
    String? title,
    String? description,
    int? order,
    bool? isCompleted,
    List<String>? skills,
  }) {
    return Lesson(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      title: title ?? this.title,
      description: description ?? this.description,
      order: order ?? this.order,
      isCompleted: isCompleted ?? this.isCompleted,
      skills: skills ?? this.skills,
    );
  }
}
