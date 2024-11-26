import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/Data/repository/user_repo.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationInitial()) {
    on<SignUpRequested>(_signUpRequested);
    on<SignInRequested>(_signInRequested);
    on<SignOutRequested>(_signOutRequested);
  }

  FutureOr<void> _signUpRequested(
      SignUpRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoading());
    try {
      final user = await userRepository.signUp(
          event.email, event.password, event.userName);
      emit(AuthSuccess(userName: user.userName));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  FutureOr<void> _signInRequested(
      SignInRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoading());
    try {
      final user = await userRepository.signIn(event.email, event.password);
      emit(AuthSuccess(userName: user.userName));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  FutureOr<void> _signOutRequested(
      SignOutRequested event, Emitter<AuthenticationState> emit) async {
    emit(AuthLoading());
    try {
      await userRepository.signOut();
      emit(AuthenticationInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
