import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier {
  String? _name;
  String? _email;
  String? _avatarUrl;

  // Getter
  String get name => _name ?? 'Người dùng';
  String? get email => _email;
  String? get avatarUrl => _avatarUrl;

  // Setter
  void setUser({required String name, String? email, String? avatarUrl}) {
    _name = name;
    _email = email;
    _avatarUrl = avatarUrl;
    notifyListeners();
  }

  void clearUser() {
    _name = null;
    _email = null;
    _avatarUrl = null;
    notifyListeners();
  }

  Future<void> updateUserName(String userId, String newName) async {
    // Lưu vào Firestore
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': newName,
    }, SetOptions(merge: true));
    // Cập nhật local
    setUser(name: newName, email: email, avatarUrl: avatarUrl);
  }
}
