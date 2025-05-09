# Calories Tracker App

Ứng dụng theo dõi calories và quản lý chế độ ăn uống được xây dựng bằng Flutter.

## Tính năng chính

1. **Quản lý thông tin cá nhân**
   - Đăng ký và đăng nhập
   - Cập nhật thông tin cá nhân
   - Theo dõi chỉ số BMI

2. **Theo dõi bữa ăn**
   - Thêm bữa ăn mới
   - Quét mã vạch sản phẩm
   - Xem lịch sử bữa ăn
   - Thống kê calories theo ngày

3. **Tính năng bổ sung**
   - Quét mã vạch sản phẩm
   - Thống kê và báo cáo
   - Nhắc nhở uống nước

## Cài đặt

1. **Yêu cầu hệ thống**
   - Flutter SDK (phiên bản mới nhất)
   - Android Studio hoặc VS Code
   - Git

2. **Các bước cài đặt**
   ```bash
   # Clone repository
   git clone [repository-url]

   # Di chuyển vào thư mục dự án
   cd calories-tracker-app

   # Cài đặt dependencies
   flutter pub get

   # Chạy ứng dụng
   flutter run
   ```

## Cấu trúc thư mục

```
lib/
├── models/         # Các model dữ liệu
├── providers/      # State management
├── screens/        # Các màn hình
├── services/       # Các service
├── utils/          # Tiện ích
└── widgets/        # Các widget tái sử dụng
```

## Hướng dẫn sử dụng

### 1. Đăng ký và đăng nhập
- Mở ứng dụng
- Chọn "Đăng ký" nếu chưa có tài khoản
- Điền thông tin cá nhân
- Đăng nhập với email và mật khẩu

### 2. Cập nhật thông tin cá nhân
- Vào màn hình Profile
- Nhấn nút "Chỉnh sửa"
- Cập nhật thông tin
- Lưu thay đổi

### 3. Thêm bữa ăn
- Vào màn hình "Bữa ăn"
- Nhấn nút "+" để thêm bữa ăn mới
- Chọn loại bữa ăn
- Nhập thông tin món ăn
- Lưu bữa ăn

### 4. Quét mã vạch
- Vào màn hình "Quét mã vạch"
- Cho phép quyền truy cập camera
- Quét mã vạch sản phẩm
- Xem thông tin sản phẩm
- Thêm vào bữa ăn

### 5. Xem thống kê
- Vào màn hình "Thống kê"
- Xem biểu đồ calories theo ngày
- Xem tổng quan về chế độ ăn
- Xuất báo cáo

## Xử lý lỗi thường gặp

1. **Lỗi đăng nhập**
   - Kiểm tra kết nối internet
   - Xác nhận email và mật khẩu
   - Thử đặt lại mật khẩu

2. **Lỗi quét mã vạch**
   - Kiểm tra quyền truy cập camera
   - Đảm bảo đủ ánh sáng
   - Giữ ổn định khi quét

3. **Lỗi lưu dữ liệu**
   - Kiểm tra kết nối internet
   - Thử đăng nhập lại
   - Xóa cache ứng dụng

## Đóng góp

Mọi đóng góp đều được hoan nghênh. Vui lòng:
1. Fork repository
2. Tạo branch mới
3. Commit thay đổi
4. Tạo Pull Request

## Liên hệ

Nếu có thắc mắc hoặc góp ý, vui lòng liên hệ qua:
- Email: [email]
- GitHub: [github-profile]

## Giấy phép

Dự án được phát hành dưới giấy phép MIT. Xem file `LICENSE` để biết thêm chi tiết.
"# calo" 
