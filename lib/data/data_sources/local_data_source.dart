import 'package:e_learning/data/models/course_model.dart';
import 'package:e_learning/data/models/lesson_model.dart';
import 'package:e_learning/data/models/question_model.dart';
import 'package:e_learning/domain/entities/question.dart';

abstract class LocalDataSource {
  Future<List<CourseModel>> getCourses();
  Future<List<LessonModel>> getLessonsByCourse(String courseId);
  Future<List<QuestionModel>> getQuestions(String lessonId);
  Future<void> saveCourses(List<CourseModel> courses);
}

class LocalDataSourceImpl implements LocalDataSource {
  // Mock data storage
  final Map<String, List<CourseModel>> _courseCache = {};
  final Map<String, List<LessonModel>> _lessonCache = {};
  final Map<String, List<QuestionModel>> _questionCache = {};

  @override
  Future<List<CourseModel>> getCourses() async {
    // Return mock data
    if (_courseCache.isEmpty) {
      return _getMockCourses();
    }
    return _courseCache['courses'] ?? [];
  }

  @override
  Future<List<LessonModel>> getLessonsByCourse(String courseId) async {
    if (_lessonCache.containsKey(courseId)) {
      return _lessonCache[courseId]!;
    }
    return _getMockLessons(courseId);
  }

  @override
  Future<List<QuestionModel>> getQuestions(String lessonId) async {
    if (_questionCache.containsKey(lessonId)) {
      return _questionCache[lessonId]!;
    }
    return _getMockQuestions(lessonId);
  }

  @override
  Future<void> saveCourses(List<CourseModel> courses) async {
    _courseCache['courses'] = courses;
  }

  // Mock data generators
  List<CourseModel> _getMockCourses() {
    return [
      CourseModel(
        id: '1',
        title: 'English',
        description: 'Learn English from beginner to advanced',
        language: 'English',
        imageUrl: '🇬🇧',
        totalLessons: 10,
        completedLessons: 3,
        xpEarned: 150,
      ),
      CourseModel(
        id: '2',
        title: 'Spanish',
        description: 'Master Spanish conversation skills',
        language: 'Spanish',
        imageUrl: '🇪🇸',
        totalLessons: 8,
        completedLessons: 1,
        xpEarned: 50,
      ),
      CourseModel(
        id: '3',
        title: 'French',
        description: 'Learn French basics and culture',
        language: 'French',
        imageUrl: '🇫🇷',
        totalLessons: 12,
        completedLessons: 0,
        xpEarned: 0,
      ),
      CourseModel(
        id: '4',
        title: 'German',
        description: 'German language and grammar',
        language: 'German',
        imageUrl: '🇩🇪',
        totalLessons: 9,
        completedLessons: 2,
        xpEarned: 100,
      ),
    ];
  }

  List<LessonModel> _getMockLessons(String courseId) {
    final lessonsByLanguage = {
      '1': [ // English
        LessonModel(
          id: 'l1',
          courseId: courseId,
          title: 'Greetings',
          description: 'Learn how to say hello',
          order: 1,
          isCompleted: true,
          skills: ['Listening', 'Speaking'],
        ),
        LessonModel(
          id: 'l2',
          courseId: courseId,
          title: 'Introductions',
          description: 'Introduce yourself in English',
          order: 2,
          isCompleted: true,
          skills: ['Speaking', 'Writing'],
        ),
        LessonModel(
          id: 'l3',
          courseId: courseId,
          title: 'Common Phrases',
          description: 'Learn useful daily phrases',
          order: 3,
          isCompleted: true,
          skills: ['Listening', 'Reading'],
        ),
        LessonModel(
          id: 'l4',
          courseId: courseId,
          title: 'Numbers',
          description: 'Master numbers 1-100',
          order: 4,
          isCompleted: false,
          skills: ['Speaking'],
        ),
      ],
      '2': [ // Spanish
        LessonModel(
          id: 's1',
          courseId: courseId,
          title: 'Hola',
          description: 'Spanish greetings',
          order: 1,
          isCompleted: true,
          skills: ['Speaking'],
        ),
        LessonModel(
          id: 's2',
          courseId: courseId,
          title: 'Colors',
          description: 'Learn Spanish colors',
          order: 2,
          isCompleted: false,
          skills: ['Reading', 'Writing'],
        ),
      ],
      '3': [ // French
        LessonModel(
          id: 'f1',
          courseId: courseId,
          title: 'Bonjour',
          description: 'French greetings',
          order: 1,
          isCompleted: false,
          skills: ['Speaking'],
        ),
      ],
      '4': [ // German
        LessonModel(
          id: 'g1',
          courseId: courseId,
          title: 'Hallo',
          description: 'German greetings',
          order: 1,
          isCompleted: true,
          skills: ['Speaking'],
        ),
      ],
    };

    return lessonsByLanguage[courseId] ?? [];
  }

  List<QuestionModel> _getMockQuestions(String lessonId) {
    final questionsByLesson = {
      'l1': [ // Greetings
        QuestionModel(
          id: 'q1',
          lessonId: lessonId,
          question: 'How do you say hello in English?',
          imageUrl: '👋',
          type: QuestionType.multipleChoice,
          options: ['Hello', 'Goodbye', 'Thank you', 'Sorry'],
          correctAnswer: 'Hello',
          explanation: 'Hello is the most common greeting in English',
          xpReward: 10,
        ),
        QuestionModel(
          id: 'q2',
          lessonId: lessonId,
          question: 'What is the response to "How are you?"',
          imageUrl: '😊',
          type: QuestionType.multipleChoice,
          options: ['I am fine', 'Good morning', 'Thank you', 'Goodbye'],
          correctAnswer: 'I am fine',
          explanation: 'Common response to How are you? is "I am fine"',
          xpReward: 10,
        ),
      ],
      'l2': [ // Introductions
        QuestionModel(
          id: 'q3',
          lessonId: lessonId,
          question: 'Complete: "My name is ___"',
          imageUrl: '📝',
          type: QuestionType.fillInTheBlanks,
          options: ['John', 'name', 'is', 'my'],
          correctAnswer: 'John',
          explanation: 'You fill in your own name here',
          xpReward: 15,
        ),
      ],
      'l3': [ // Common Phrases
        QuestionModel(
          id: 'q4',
          lessonId: lessonId,
          question: 'Choose the polite phrase:',
          imageUrl: '🙏',
          type: QuestionType.multipleChoice,
          options: ['Please', 'Stop', 'Run', 'Jump'],
          correctAnswer: 'Please',
          explanation: 'Please is a polite word used in requests',
          xpReward: 10,
        ),
      ],
      'l4': [ // Numbers
        QuestionModel(
          id: 'q5',
          lessonId: lessonId,
          question: 'What is 5 + 3 in English?',
          imageUrl: '🔢',
          type: QuestionType.multipleChoice,
          options: ['Eight', 'Seven', 'Nine', 'Six'],
          correctAnswer: 'Eight',
          explanation: '5 + 3 = 8, eight',
          xpReward: 10,
        ),
      ],
      's1': [ // Spanish Hola
        QuestionModel(
          id: 'q6',
          lessonId: lessonId,
          question: 'How do you say hello in Spanish?',
          imageUrl: '👋',
          type: QuestionType.multipleChoice,
          options: ['Hola', 'Adiós', 'Gracias', 'Por favor'],
          correctAnswer: 'Hola',
          explanation: 'Hola means hello in Spanish',
          xpReward: 10,
        ),
      ],
      's2': [ // Spanish Colors
        QuestionModel(
          id: 'q7',
          lessonId: lessonId,
          question: 'Red in Spanish is:',
          imageUrl: '🔴',
          type: QuestionType.multipleChoice,
          options: ['Rojo', 'Azul', 'Verde', 'Amarillo'],
          correctAnswer: 'Rojo',
          explanation: 'Rojo is the Spanish word for red',
          xpReward: 10,
        ),
      ],
      'f1': [ // French Bonjour
        QuestionModel(
          id: 'q8',
          lessonId: lessonId,
          question: 'How do you say hello in French?',
          imageUrl: '👋',
          type: QuestionType.multipleChoice,
          options: ['Bonjour', 'Au revoir', 'Merci', 'S\'il vous plaît'],
          correctAnswer: 'Bonjour',
          explanation: 'Bonjour means hello in French',
          xpReward: 10,
        ),
      ],
      'g1': [ // German Hallo
        QuestionModel(
          id: 'q9',
          lessonId: lessonId,
          question: 'How do you say hello in German?',
          imageUrl: '👋',
          type: QuestionType.multipleChoice,
          options: ['Hallo', 'Auf Wiedersehen', 'Danke', 'Bitte'],
          correctAnswer: 'Hallo',
          explanation: 'Hallo is the German word for hello',
          xpReward: 10,
        ),
      ],
    };

    return questionsByLesson[lessonId] ?? [];
  }
}
