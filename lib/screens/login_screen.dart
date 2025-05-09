import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart'; // Import AuthProvider
import 'forget_password_screen.dart';
import 'signup_screen.dart';// Import màn hình đăng ký để điều hướng

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controller để lấy dữ liệu từ TextFields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State để quản lý trạng thái loading
  bool _isLoading = false;

  // Biến để ẩn/hiện mật khẩu
  bool _isPasswordVisible = false;

  // Key cho Form để validation (tùy chọn)
  final _formKey = GlobalKey<FormState>();

  // Hàm xử lý đăng nhập
  Future<void> _signIn() async {
    // 1. Validate form (nếu sử dụng Form)
    // if (!_formKey.currentState!.validate()) {
    //   return; // Không làm gì nếu form không hợp lệ
    // }

    // Lấy giá trị từ controllers
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Kiểm tra đơn giản nếu không dùng Form validation
    if (email.isEmpty || password.isEmpty) {
      if (mounted) {
        // Kiểm tra widget còn tồn tại không
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vui lòng nhập đầy đủ email và mật khẩu.')),
        );
      }
      return;
    }

    // Ẩn bàn phím
    FocusScope.of(context).unfocus();

    // Bắt đầu loading
    setState(() {
      _isLoading = true;
    });

    try {
      // Gọi hàm signIn từ AuthProvider
      // `listen: false` vì chúng ta chỉ gọi hàm, không cần rebuild khi state thay đổi ở đây
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      String? error = await authProvider.signIn(email, password, context);

      // Nếu đăng nhập thành công (error == null), Wrapper sẽ tự động
      // điều hướng đến HomeScreen do lắng nghe authStateChanges.
      // Nếu có lỗi, hiển thị SnackBar
      if (error != null && mounted) {
        // Kiểm tra mounted trước khi dùng context trong hàm async
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đăng nhập thất bại: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Xử lý các lỗi không mong muốn khác (hiếm khi xảy ra với try-catch trong provider)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã xảy ra lỗi: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      // Dừng loading dù thành công hay thất bại (nếu widget còn tồn tại)
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Đừng quên dispose controllers khi widget bị hủy
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background Image
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: 0.9, // Điều chỉnh độ trong suốt của ảnh (0.0 - 1.0)
              duration: Duration(seconds: 0),
              child: Image.asset(
                'assets/images/Calo.png', // Thay thế bằng đường dẫn ảnh của bạn
                fit: BoxFit.cover, // Cách ảnh lấp đầy không gian
              ),
            ),
          ),

          // Lớp phủ màu (tùy chọn) để làm nổi bật nội dung
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          // Nội dung chính (ở trên cùng của Stack)
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Phần trên (Logo và Tiêu đề)
                    Column(
                      children: <Widget>[
                        SizedBox(height: 20), // Thêm khoảng trắng phía trên logo
                        Text(
                          'The Calo',
                          style: TextStyle(
                            fontSize: 40,
                            fontFamily: 'RaleWay',
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          'Tracking your calories',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        SizedBox(height: 40),
                      ],
                    ),

                    Text(
                      'Đăng nhập',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Column( // Sử dụng Column để xếp TextFormField và TextButton xuống dòng
                      crossAxisAlignment: CrossAxisAlignment.end, // Căn phải cho "Quên mật khẩu?"
                      children: <Widget>[
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 8), // Thêm khoảng trắng giữa TextFormField và TextButton
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                            );
                          },
                          child: const Text('Quên mật khẩu?'),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0F172A),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(child: Divider(color: Colors.grey[300])),
                        Expanded(child: Divider(color: Colors.grey[300])),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Chưa có tài khoản? ", style: TextStyle(color: Colors.grey[600])),
                        TextButton(
                          onPressed: () {
                            // Điều hướng đến màn hình đăng ký
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text(
                            'Đăng ký',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}