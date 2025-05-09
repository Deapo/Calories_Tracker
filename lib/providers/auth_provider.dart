import 'package:calories_tracker/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    // Lắng nghe thay đổi trạng thái đăng nhập
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    _user = firebaseUser;
    print("Auth State Changed: User is ${user?.email}");
    notifyListeners(); // Thông báo thay đổi
  }

  // Hàm đăng nhập
  Future<String?> signIn(String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Lấy tên từ email
      String username = email.split('@')[0];
      Provider.of<UserProvider>(context, listen: false).setUser(name: username, email: email);
      return null; // Thành công
    } on FirebaseAuthException catch (e) {
      print("Sign In Error: ${e.message}");
      return e.message; // Trả về thông báo lỗi
    }
  }

  // Hàm đăng ký
  Future<String?> signUp(String email, String password, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String username = email.split('@')[0];
      Provider.of<UserProvider>(context, listen: false).setUser(name: username, email: email);
      return null; // Thành công
    } on FirebaseAuthException catch (e) {
      print("Sign Up Error: ${e.message}");
      return e.message; // Trả về thông báo lỗi
    }
  }

  // Hàm đăng xuất
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
