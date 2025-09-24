import 'package:flutter/material.dart';
import '../models/user.dart';

class AppProvider extends ChangeNotifier {
  User? _currentUser;
  UserRole _userRole = UserRole.athlete;
  bool _isLoading = false;
  String? _error;

  // Getters
  User? get currentUser => _currentUser;
  UserRole get userRole => _userRole;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isLoggedIn => _currentUser != null;

  // Setters
  void setUser(User? user) {
    _currentUser = user;
    if (user != null) {
      _userRole = user.role;
    }
    notifyListeners();
  }

  void setUserRole(UserRole role) {
    _userRole = role;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Logout
  void logout() {
    _currentUser = null;
    _userRole = UserRole.athlete;
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}
