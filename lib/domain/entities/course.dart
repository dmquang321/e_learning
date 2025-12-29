import 'package:equatable/equatable.dart';

class Course extends Equatable {
  final String id;
  final String title;
  final String description;
  final String language;
  final String imageUrl;
  final int totalLessons;
  final int completedLessons;
  final int xpEarned;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.language,
    required this.imageUrl,
    required this.totalLessons,
    required this.completedLessons,
    required this.xpEarned,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        language,
        imageUrl,
        totalLessons,
        completedLessons,
        xpEarned,
      ];

  Course copyWith({
    String? id,
    String? title,
    String? description,
    String? language,
    String? imageUrl,
    int? totalLessons,
    int? completedLessons,
    int? xpEarned,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      language: language ?? this.language,
      imageUrl: imageUrl ?? this.imageUrl,
      totalLessons: totalLessons ?? this.totalLessons,
      completedLessons: completedLessons ?? this.completedLessons,
      xpEarned: xpEarned ?? this.xpEarned,
    );
  }
}
