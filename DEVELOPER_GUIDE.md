# 🚀 Developer Guide - E-Learning App

## 📋 Cách Thêm Khóa Học Mới

### Bước 1: Thêm dữ liệu Mock
Edit [lib/data/data_sources/local_data_source.dart](lib/data/data_sources/local_data_source.dart#L94)

```dart
List<CourseModel> _getMockCourses() {
  return [
    // ... existing courses ...
    CourseModel(
      id: '5',
      title: 'Italian',
      description: 'Learn Italian pronunciation and basics',
      language: 'Italian',
      imageUrl: '🇮🇹',
      totalLessons: 10,
      completedLessons: 0,
      xpEarned: 0,
    ),
  ];
}
```

### Bước 2: Thêm Bài Học
Trong function `_getMockLessons()`:

```dart
'5': [ // Italian
  LessonModel(
    id: 'it1',
    courseId: '5',
    title: 'Ciao',
    description: 'Italian greetings',
    order: 1,
    isCompleted: false,
    skills: ['Speaking', 'Listening'],
  ),
],
```

### Bước 3: Thêm Câu Hỏi
Trong function `_getMockQuestions()`:

```dart
'it1': [ // Italian Ciao
  QuestionModel(
    id: 'q10',
    lessonId: 'it1',
    question: 'How do you say hello in Italian?',
    imageUrl: '👋',
    type: QuestionType.multipleChoice,
    options: ['Ciao', 'Addio', 'Grazie', 'Prego'],
    correctAnswer: 'Ciao',
    explanation: 'Ciao is the Italian word for hello/goodbye',
    xpReward: 10,
  ),
],
```

## 🎨 Thêm Màu Sắc Mới cho Khóa Học

Edit `_getColorForLanguage()` trong [lib/presentation/widgets/course_card.dart](lib/presentation/widgets/course_card.dart#L111):

```dart
int _getColorForLanguage(String language) {
  switch (language.toLowerCase()) {
    case 'english':
      return 0xFF2E7D32; // Green
    case 'italian':
      return 0xFF27AE60; // New green
    // ... more cases ...
    default:
      return 0xFF1F4788;
  }
}
```

## 🔌 Thêm API Integration (Khi Backend Ready)

### Bước 1: Cập nhật RemoteDataSource
Edit [lib/data/data_sources/remote_data_source.dart](lib/data/data_sources/remote_data_source.dart):

```dart
@override
Future<List<CourseModel>> getCourses() async {
  try {
    final response = await dio.get('${baseUrl}/api/courses');
    return (response.data as List)
        .map((course) => CourseModel.fromJson(course))
        .toList();
  } on DioException catch (e) {
    throw Exception('Failed to fetch courses: ${e.message}');
  }
}
```

### Bước 2: Cập nhật Constants
Edit [lib/core/constants/app_constants.dart](lib/core/constants/app_constants.dart):

```dart
class AppConstants {
  static const String baseUrl = 'https://api.yourdomain.com';
  // ...
}
```

### Bước 3: Implement Error Handling
```dart
Future<List<Course>> getCourses() async {
  try {
    final courses = await remoteDataSource.getCourses();
    await localDataSource.saveCourses(courses);
    return courses;
  } catch (e) {
    // Fall back to local data
    return await localDataSource.getCourses();
  }
}
```

## 🔐 Thêm User Authentication

### Bước 1: Tạo Auth Entity
```dart
// lib/domain/entities/user.dart
class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String profileImage;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.profileImage,
  });

  @override
  List<Object?> get props => [id, email, name, profileImage];
}
```

### Bước 2: Tạo Auth Repository
```dart
// lib/domain/repositories/auth_repository.dart
abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register(String email, String password, String name);
  Future<void> logout();
  Future<User?> getCurrentUser();
}
```

### Bước 3: Tạo Auth BLoC
```dart
// lib/presentation/bloc/auth/auth_bloc.dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
  }
  
  // Implement event handlers...
}
```

### Bước 4: Thêm Auth Routes
```dart
// lib/main.dart
routes: {
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/home': (context) => const HomeScreen(),
  // ...
},
```

## 💾 Thêm Local Caching (Hive)

### 1. Thêm Dependencies
```yaml
hive: ^2.2.3
hive_flutter: ^1.1.0
```

### 2. Tạo Hive Models
```dart
// lib/data/models/course_hive_model.dart
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class CourseHiveModel {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String title;
  
  // ... more fields ...
}
```

### 3. Cập nhật LocalDataSource
```dart
Future<List<CourseModel>> getCourses() async {
  try {
    final box = await Hive.openBox('courses');
    final cachedCourses = box.values;
    
    if (cachedCourses.isNotEmpty) {
      return cachedCourses
          .map((e) => CourseModel.fromHive(e))
          .toList();
    }
  } catch (e) {
    // Fall back to mock data
  }
  
  return _getMockCourses();
}
```

## 📊 Thêm Analytics

### Sử dụng Firebase Analytics
```dart
// lib/core/analytics/analytics_service.dart
import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  
  Future<void> logLessonCompleted(String lessonId, int xp) async {
    await _analytics.logEvent(
      name: 'lesson_completed',
      parameters: {
        'lesson_id': lessonId,
        'xp_earned': xp,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
}
```

### Track BLoC Events
```dart
// lib/presentation/bloc/lesson/lesson_bloc.dart
Future<void> _onAnswerQuestion(
  AnswerQuestionEvent event,
  Emitter<LessonState> emit,
) async {
  // ... existing code ...
  
  if (event.isCorrect) {
    await analyticsService.trackCorrectAnswer(event.questionId);
  }
}
```

## 🔔 Thêm Push Notifications

### 1. Cấu hình Firebase Cloud Messaging
```dart
// lib/core/notifications/notification_service.dart
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  
  Future<void> initialize() async {
    await _messaging.requestPermission();
    
    _messaging.onMessage.listen((RemoteMessage message) {
      // Handle notification while app is open
    });
  }
}
```

### 2. Gửi Notification cho Daily Reminder
```dart
// Backend API endpoint
POST /api/users/{userId}/notifications/schedule
{
  "type": "daily_reminder",
  "time": "09:00",
  "message": "Time to practice your lesson!"
}
```

## 🧪 Testing

### Unit Tests
```dart
// test/domain/usecases/get_courses_usecase_test.dart
void main() {
  late GetCoursesUseCase getCoursesUseCase;
  late MockCourseRepository mockCourseRepository;

  setUp(() {
    mockCourseRepository = MockCourseRepository();
    getCoursesUseCase = GetCoursesUseCase(mockCourseRepository);
  });

  test('should return list of courses', () async {
    // Arrange
    final courses = [
      const Course(...),
    ];
    when(mockCourseRepository.getCourses())
        .thenAnswer((_) async => courses);

    // Act
    final result = await getCoursesUseCase();

    // Assert
    expect(result, courses);
  });
}
```

### Widget Tests
```dart
// test/presentation/widgets/course_card_test.dart
void main() {
  testWidgets('CourseCard displays course information', (WidgetTester tester) async {
    const course = Course(...);
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CourseCard(
            course: course,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text(course.title), findsOneWidget);
    expect(find.text('${course.completedLessons}/${course.totalLessons}'), findsOneWidget);
  });
}
```

## 🏆 Performance Tips

1. **Lazy Loading**:
   ```dart
   // Load questions only when needed
   FutureBuilder<List<Question>>(
     future: getQuestionsUseCase(lessonId),
     builder: (context, snapshot) {
       // Build UI
     },
   )
   ```

2. **Image Caching**:
   ```dart
   CachedNetworkImage(
     imageUrl: imageUrl,
     cacheManager: CacheManager.instance,
     placeholder: (context, url) => const SkeletonLoader(),
   )
   ```

3. **BLoC Memory Management**:
   ```dart
   @override
   Future<void> close() {
     // Clean up resources
     return super.close();
   }
   ```

## 📚 Project Structure Checklist

- [ ] Domain Layer (entities, repositories, usecases)
- [ ] Data Layer (models, datasources, repository implementations)
- [ ] Presentation Layer (BLoCs, screens, widgets)
- [ ] Core (constants, theme, utils, service locator)
- [ ] Tests (unit, widget, integration)
- [ ] Assets (images, fonts, icons)
- [ ] Documentation (README, ARCHITECTURE, API docs)

## 🔗 Useful Resources

- [Flutter Official Docs](https://flutter.dev/docs)
- [BLoC Library](https://bloclibrary.dev)
- [Clean Architecture](https://resocoder.com/flutter-clean-architecture)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

---

**Last Updated**: December 2025
