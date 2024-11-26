part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpRequested extends AuthenticationEvent {
  final String email;
  final String userName;
  final String password;

  SignUpRequested(
      {required this.email, required this.userName, required this.password});

  @override
  List<Object?> get props => [email, userName, password];
}

class SignInRequested extends AuthenticationEvent {
  final String email;
  final String password;

  SignInRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignOutRequested extends AuthenticationEvent {}
