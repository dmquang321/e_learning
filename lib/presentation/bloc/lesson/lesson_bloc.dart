import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning/domain/entities/question.dart';
import 'package:e_learning/domain/usecases/get_questions_usecase.dart';

// Events
abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object?> get props => [];
}

class LoadQuestionsEvent extends LessonEvent {
  final String lessonId;

  const LoadQuestionsEvent(this.lessonId);

  @override
  List<Object?> get props => [lessonId];
}

class AnswerQuestionEvent extends LessonEvent {
  final String questionId;
  final String selectedAnswer;
  final bool isCorrect;

  const AnswerQuestionEvent({
    required this.questionId,
    required this.selectedAnswer,
    required this.isCorrect,
  });

  @override
  List<Object?> get props => [questionId, selectedAnswer, isCorrect];
}

class NextQuestionEvent extends LessonEvent {
  const NextQuestionEvent();
}

// States
abstract class LessonState extends Equatable {
  const LessonState();

  @override
  List<Object?> get props => [];
}

class LessonInitial extends LessonState {
  const LessonInitial();
}

class LessonLoading extends LessonState {
  const LessonLoading();
}

class LessonLoaded extends LessonState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final int correctAnswers;
  final int totalXpEarned;
  final String? lastAnswer;
  final bool? lastAnswerCorrect;

  const LessonLoaded({
    required this.questions,
    required this.currentQuestionIndex,
    required this.correctAnswers,
    required this.totalXpEarned,
    this.lastAnswer,
    this.lastAnswerCorrect,
  });

  Question? get currentQuestion =>
      currentQuestionIndex < questions.length
          ? questions[currentQuestionIndex]
          : null;

  bool get isLessonComplete => currentQuestionIndex >= questions.length;

  @override
  List<Object?> get props => [
        questions,
        currentQuestionIndex,
        correctAnswers,
        totalXpEarned,
        lastAnswer,
        lastAnswerCorrect,
      ];
}

class LessonError extends LessonState {
  final String message;

  const LessonError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final GetQuestionsUseCase getQuestionsUseCase;

  LessonBloc({required this.getQuestionsUseCase})
      : super(const LessonInitial()) {
    on<LoadQuestionsEvent>(_onLoadQuestions);
    on<AnswerQuestionEvent>(_onAnswerQuestion);
    on<NextQuestionEvent>(_onNextQuestion);
  }

  Future<void> _onLoadQuestions(
    LoadQuestionsEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(const LessonLoading());
    try {
      final questions = await getQuestionsUseCase.call(event.lessonId);

      emit(LessonLoaded(
        questions: questions,
        currentQuestionIndex: 0,
        correctAnswers: 0,
        totalXpEarned: 0,
      ));
    } catch (e) {
      emit(LessonError(e.toString()));
    }
  }

  Future<void> _onAnswerQuestion(
    AnswerQuestionEvent event,
    Emitter<LessonState> emit,
  ) async {
    if (state is LessonLoaded) {
      final currentState = state as LessonLoaded;

      int newCorrectAnswers = currentState.correctAnswers;
      int newTotalXp = currentState.totalXpEarned;

      if (event.isCorrect) {
        newCorrectAnswers++;
        final currentQuestion = currentState.currentQuestion;
        if (currentQuestion != null) {
          newTotalXp += currentQuestion.xpReward;
        }
      }

      emit(LessonLoaded(
        questions: currentState.questions,
        currentQuestionIndex: currentState.currentQuestionIndex,
        correctAnswers: newCorrectAnswers,
        totalXpEarned: newTotalXp,
        lastAnswer: event.selectedAnswer,
        lastAnswerCorrect: event.isCorrect,
      ));
    }
  }

  Future<void> _onNextQuestion(
    NextQuestionEvent event,
    Emitter<LessonState> emit,
  ) async {
    if (state is LessonLoaded) {
      final currentState = state as LessonLoaded;
      final nextIndex = currentState.currentQuestionIndex + 1;

      emit(LessonLoaded(
        questions: currentState.questions,
        currentQuestionIndex: nextIndex,
        correctAnswers: currentState.correctAnswers,
        totalXpEarned: currentState.totalXpEarned,
      ));
    }
  }
}
