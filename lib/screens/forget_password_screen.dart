import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Giả lập quá trình gửi yêu cầu đặt lại mật khẩu
    await Future.delayed(const Duration(seconds: 3));

    final email = _emailController.text.trim();
    if (email.isNotEmpty && email.contains('@')) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Một email đặt lại mật khẩu đã được gửi đến $email.';
        // Sau khi thành công (giả lập), bạn có thể chuyển hướng về màn hình đăng nhập sau một khoảng thời gian
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context); // Quay lại màn hình đăng nhập
        });
      });
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Vui lòng nhập một địa chỉ email hợp lệ.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quên mật khẩu'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Nhập địa chỉ email đã đăng ký để đặt lại mật khẩu của bạn.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _resetPassword,
                child: const Text('Gửi yêu cầu đặt lại'),
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: _errorMessage!.startsWith('Vui lòng')
                          ? Colors.red
                          : Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}