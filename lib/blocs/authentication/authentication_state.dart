part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class AuthSuccess extends AuthenticationState {
  final String userName;
  final String email;

  AuthSuccess({required this.userName, required this.email});

  @override
  List<Object> get props => [userName, email];
}

class AuthFailure extends AuthenticationState {
  final String message;

  AuthFailure(this.message);
  @override
  List<Object?> get props => [message];
}
