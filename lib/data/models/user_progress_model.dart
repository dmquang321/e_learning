import 'package:e_learning/domain/entities/user_progress.dart';

class UserProgressModel extends UserProgress {
  const UserProgressModel({
    required super.userId,
    required super.totalXp,
    required super.streak,
    required super.dailyGoalXp,
    required super.lastActiveDate,
  });

  factory UserProgressModel.fromJson(Map<String, dynamic> json) {
    return UserProgressModel(
      userId: json['userId'] as String,
      totalXp: json['totalXp'] as int,
      streak: json['streak'] as int,
      dailyGoalXp: json['dailyGoalXp'] as int,
      lastActiveDate: DateTime.parse(json['lastActiveDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'totalXp': totalXp,
      'streak': streak,
      'dailyGoalXp': dailyGoalXp,
      'lastActiveDate': lastActiveDate.toIso8601String(),
    };
  }
}
