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

  AuthSuccess({required this.userName});

  @override
  List<Object?> get props => [userName];
}

class AuthFailure extends AuthenticationState {
  final String message;

  AuthFailure(this.message);
  @override
  List<Object?> get props => [message];
}
