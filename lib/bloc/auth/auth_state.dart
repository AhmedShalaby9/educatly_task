import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool passwordsMatch;

  const AuthState({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.passwordsMatch,
  });

  factory AuthState.initial() {
    return const AuthState(
      email: '',
      password: '',
      confirmPassword: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      passwordsMatch: true,
    );
  }

  AuthState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? passwordsMatch,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      passwordsMatch: passwordsMatch ?? this.passwordsMatch,
    );
  }

  @override
  List<Object> get props => [
    email,
    password,
    confirmPassword,
    isSubmitting,
    isSuccess,
    isFailure,
    passwordsMatch,
  ];
}
