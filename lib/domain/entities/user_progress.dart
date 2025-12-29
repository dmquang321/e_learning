import 'package:equatable/equatable.dart';

class UserProgress extends Equatable {
  final String userId;
  final int totalXp;
  final int streak;
  final int dailyGoalXp;
  final DateTime lastActiveDate;

  const UserProgress({
    required this.userId,
    required this.totalXp,
    required this.streak,
    required this.dailyGoalXp,
    required this.lastActiveDate,
  });

  @override
  List<Object?> get props =>
      [userId, totalXp, streak, dailyGoalXp, lastActiveDate];

  UserProgress copyWith({
    String? userId,
    int? totalXp,
    int? streak,
    int? dailyGoalXp,
    DateTime? lastActiveDate,
  }) {
    return UserProgress(
      userId: userId ?? this.userId,
      totalXp: totalXp ?? this.totalXp,
      streak: streak ?? this.streak,
      dailyGoalXp: dailyGoalXp ?? this.dailyGoalXp,
      lastActiveDate: lastActiveDate ?? this.lastActiveDate,
    );
  }
}
