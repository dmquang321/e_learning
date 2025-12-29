# 📚 E-Learning App - User Guide

## 🎯 Tính năng Chính

### 1️⃣ Home Screen (Màn hình Chính)
Hiển thị dashboard với:
- **Welcome message** với streaktracker 🔥
- **XP Counter** - Tổng điểm kinh nghiệm
- **Danh sách Courses** - Các khóa học có sẵn
- **Pull-to-Refresh** - Tải lại dữ liệu

**Tác vụ**:
- Vuốt từ trên xuống để refresh
- Chạm vào Course Card để xem bài học

### 2️⃣ Course Screen (Màn hình Khóa Học)
Hiển thị:
- **Progress Bar** - Tiến độ hoàn thành khóa học
- **Progress Stats** - X bài hoàn thành / tổng bài
- **Danh sách Bài học** - Các bài với trạng thái

**Tác vụ**:
- Chạm vào bài học chưa hoàn thành để bắt đầu
- Bài hoàn thành sẽ có dấu ✅
- Xem các kỹ năng của từng bài học

### 3️⃣ Lesson Screen (Màn hình Luyện Tập)
Đây là màn hình chính để:
- **Trả lời câu hỏi trắc nghiệm**
- **Nhận XP** cho mỗi câu trả lời đúng
- **Xem giải thích** cho câu hỏi

#### Quy trình Luyện Tập:
1. Đọc câu hỏi cẩn thận
2. Chọn một đáp án từ 4 lựa chọn
3. Hệ thống tự động kiểm tra:
   - ✅ **Đúng** = Đáp án sẽ có border xanh + XP được cộng
   - ❌ **Sai** = Đáp án sai có border đỏ, đáp án đúng hiện ở dưới
4. Đọc **Explanation** để hiểu chi tiết
5. Chạm **"Continue"** để sang câu tiếp theo

#### Kết thúc Bài Học:
- Trang kết thúc hiển thị:
  - Số câu trả lời đúng
  - Tổng XP kiếm được
  - 🎉 Celebration animation
- Chạm **"Back to Course"** để quay lại

## 📊 Dữ liệu & Khóa Học

Hiện tại app có **4 khóa học** mock:

### 🇬🇧 English (10 bài)
- Greetings (Lời chào)
- Introductions (Giới thiệu)
- Common Phrases (Cụm từ thường dùng)
- Numbers (Số)
- ...

### 🇪🇸 Spanish (8 bài)
- Hola (Xin chào)
- Colors (Màu sắc)
- ...

### 🇫🇷 French (12 bài)
- Bonjour (Xin chào)
- ...

### 🇩🇪 German (9 bài)
- Hallo (Xin chào)
- ...

## 🎯 Hệ thống Điểm XP

- **Mỗi câu hỏi** có thể cho từ 10-15 XP
- **Chỉ nhận XP** khi trả lời **đúng**
- **Tổng XP** được hiển thị ở Home Screen
- **Streak** được tính dựa trên luyện tập hàng ngày

## 🎨 Giao Diện & Thiết Kế

- **Màu Primary**: Xanh dương (#1F4788)
- **Màu Accent**: Vàng/Vàng tương (XP rewards)
- **Màu Success**: Xanh lá (#58CC02)
- **Màu Error**: Đỏ (#FF4B4B)

Thiết kế theo chuẩn **Material Design 3** với hỗ trợ **Dark Mode** (future).

## 💡 Tips & Tricks

1. **Học đều đặn** - Giữ streak sống
2. **Chú ý Explanations** - Chúng giúp hiểu sâu hơn
3. **Đặt mục tiêu XP hàng ngày** - 50 XP là mục tiêu mặc định
4. **Ôn tập các bài cũ** - Có thể học lại bài hoàn thành

## 🔄 Workflow Khuyến Nghị

```
Home Screen 
    ↓
Chọn Course 
    ↓
Chọn Lesson 
    ↓
Trả lời Questions 
    ↓
Hoàn thành Lesson 
    ↓
Nhận XP & Streaks 
    ↓
Quay lại Course để chọn bài tiếp theo
```

## ⚙️ Settings (Future)

Sắp có:
- [ ] Chế độ Dark/Light
- [ ] Âm thanh & Vibration settings
- [ ] Ngôn ngữ giao diện
- [ ] Tốc độ phát âm
- [ ] Thống kê chi tiết

## 🐛 Troubleshooting

### Lỗi: "Something went wrong"
- Hãy pull-to-refresh trên Home Screen
- Kiểm tra kết nối mạng (hiện tại dùng mock data nên không cần)

### Câu hỏi không tải
- Quay lại và chọn lại bài học
- Restart app nếu vẫn không được

## 📞 Support & Feedback

- 📧 Email: support@elearning.app
- 💬 Discord: [Join our community]
- 🐦 Twitter: @elearningapp

---

**Phiên bản**: 1.0.0  
**Ngày cập nhật**: December 2025
