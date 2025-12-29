# E-Learning Flutter App (Duolingo-like)

Một ứng dụng học tập dạng Duolingo được xây dựng bằng Flutter với **Clean Architecture** và **BLoC Pattern**.

## 🏗️ Project Structure

```
lib/
├── core/                          # Core utilities & constants
│   ├── constants/
│   │   └── app_constants.dart     # App-wide constants
│   ├── theme/
│   │   └── app_theme.dart         # Material theme configuration
│   ├── utils/
│   │   └── extensions.dart        # Dart extensions (String, Duration, DateTime)
│   └── service_locator/
│       └── service_locator.dart   # GetIt dependency injection setup
│
├── domain/                         # Business logic layer
│   ├── entities/                  # Core business objects
│   │   ├── course.dart
│   │   ├── lesson.dart
│   │   ├── question.dart
│   │   └── user_progress.dart
│   ├── repositories/              # Repository interfaces
│   │   ├── course_repository.dart
│   │   └── lesson_repository.dart
│   └── usecases/                  # Use cases (business operations)
│       ├── get_courses_usecase.dart
│       ├── get_lessons_usecase.dart
│       └── get_questions_usecase.dart
│
├── data/                           # Data access layer
│   ├── data_sources/              # Data sources (local & remote)
│   │   ├── local_data_source.dart # Local (mock) data
│   │   └── remote_data_source.dart # API calls (Dio)
│   ├── models/                    # Data models
│   │   ├── course_model.dart
│   │   ├── lesson_model.dart
│   │   ├── question_model.dart
│   │   └── user_progress_model.dart
│   └── repositories/              # Repository implementations
│       ├── course_repository_impl.dart
│       └── lesson_repository_impl.dart
│
└── presentation/                   # UI layer
    ├── bloc/                      # BLoC for state management
    │   ├── home/
    │   │   └── home_bloc.dart
    │   ├── course/
    │   │   └── course_bloc.dart
    │   └── lesson/
    │       └── lesson_bloc.dart
    ├── screens/                   # App screens
    │   ├── home_screen.dart       # Main courses list
    │   ├── course_screen.dart     # Lessons for a course
    │   └── lesson_screen.dart     # Quiz/practice screen
    └── widgets/                   # Reusable UI components
        ├── app_button.dart
        ├── course_card.dart
        ├── lesson_tile.dart
        ├── progress_bar.dart
        └── xp_badge.dart
```

## 🎯 Main Features

### 1. **Home Screen**
- Hiển thị danh sách các khóa học
- Hiển thị XP tổng cộng và streak hiện tại
- Pull-to-refresh để tải dữ liệu mới
- Các Course Card hiển thị tiến độ

### 2. **Course Screen**
- Hiển thị tất cả bài học trong khóa học
- Progress bar theo dõi tiến độ hoàn thành
- Danh sách bài học với trạng thái (hoàn thành/chưa)
- Hiển thị các kỹ năng của mỗi bài học

### 3. **Lesson Screen (Quiz)**
- Hiển thị các câu hỏi trắc nghiệm
- Multiple choice questions với visual feedback
- XP rewards cho câu trả lời đúng
- Giải thích chi tiết cho mỗi câu hỏi
- Trang kết thúc bài học với tổng XP kiếm được

## 🔧 Tech Stack

- **Flutter**: UI framework
- **BLoC**: State management
- **Clean Architecture**: Project structure
- **GetIt**: Service locator/Dependency injection
- **Equatable**: Value equality
- **Dio**: HTTP client (prepared for API integration)

## 📦 Dependencies

```yaml
flutter_bloc: ^8.1.3
bloc: ^8.1.1
dio: ^5.3.1
equatable: ^2.0.5
get_it: ^7.5.0
```

## 🚀 Getting Started

1. **Cài đặt dependencies**:
   ```bash
   flutter pub get
   ```

2. **Chạy app**:
   ```bash
   flutter run
   ```

3. **Phân tích code**:
   ```bash
   flutter analyze
   ```

## 🎮 How to Use

1. **Home Screen**: Xem danh sách các khóa học
2. **Tap on Course**: Xem các bài học trong khóa học
3. **Tap on Lesson**: Bắt đầu luyện tập (quiz)
4. **Answer Questions**: Chọn đáp án và nhận XP
5. **View Results**: Hoàn thành bài học và xem tổng XP

## 📊 Mock Data

App hiện tại sử dụng mock data với các khóa học:
- **English** (10 bài học)
- **Spanish** (8 bài học)
- **French** (12 bài học)
- **German** (9 bài học)

Mock data được lưu trữ trong `LocalDataSourceImpl` - có thể dễ dàng thay thế bằng API calls thực tế.

## 🔗 API Integration (Future)

Khi API backend sẵn sàng, cập nhật `RemoteDataSourceImpl` để call API:

```dart
@override
Future<List<CourseModel>> getCourses() async {
  final response = await dio.get('/api/courses');
  return (response.data as List)
      .map((course) => CourseModel.fromJson(course))
      .toList();
}
```

## 🎨 Color Scheme

- **Primary**: `#1F4788` (Blue)
- **Accent**: `#FFB300` (Yellow/Gold) - XP color
- **Success**: `#58CC02` (Green)
- **Error**: `#FF4B4B` (Red)

## 📝 State Management Flow

```
User Action → BLoC Event → BLoC Logic → State Emission → UI Update
```

### Example: Load Courses
```
LoadCoursesEvent 
  → HomeBloc calls GetCoursesUseCase
  → GetCoursesUseCase calls CourseRepository
  → CourseRepository tries Remote, falls back to Local
  → LocalDataSource returns mock courses
  → HomeLoaded state emitted
  → UI rebuilds with courses
```

## ✨ Key Design Patterns

1. **Repository Pattern**: Abstraction over data sources
2. **Dependency Injection**: Loose coupling via GetIt
3. **BLoC Pattern**: Separation of business logic from UI
4. **Entity Pattern**: Domain entities independent of data models
5. **Use Case Pattern**: Encapsulation of business operations

## 🔄 Next Steps (When Backend Ready)

- [ ] Replace mock data with real API calls
- [ ] Add user authentication (login/signup)
- [ ] Implement local caching with Hive/SQLite
- [ ] Add offline support
- [ ] Add more advanced features (leaderboard, achievements)
- [ ] Add analytics tracking
- [ ] Push notifications for daily reminders

## 📄 License

MIT License

---

**Created**: December 2025
**Framework**: Flutter 3.8.0+
