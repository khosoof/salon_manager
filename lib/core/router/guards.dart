import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserRole { owner, admin, cashier, stylist, viewer }

class AuthState {
  final bool isAuthenticated;
  final UserRole? role;
  final String? token;
  const AuthState({required this.isAuthenticated, this.role, this.token});

  AuthState copyWith({bool? isAuthenticated, UserRole? role, String? token}) =>
      AuthState(isAuthenticated: isAuthenticated ?? this.isAuthenticated, role: role ?? this.role, token: token ?? this.token);
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(): super(const AuthState(isAuthenticated: false));
  void login({required UserRole role, required String token}) {
    state = AuthState(isAuthenticated: true, role: role, token: token);
  }
  void logout() {
    state = const AuthState(isAuthenticated: false);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
