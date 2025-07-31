// signup_bloc_bloc.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'signup_bloc_event.dart';
part 'signup_bloc_state.dart';



class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSubmittedEvent>(_onSignUpSubmitted);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmittedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());

    if (event.password != event.confirmPassword) {
      emit(SignUpFailure("Passwords do not match"));
      return;
    }

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      emit(SignUpSuccess(event.email));
    } on FirebaseAuthException catch (e) {
      emit(SignUpFailure(e.message ?? "Unknown error"));
    } catch (e) {
      emit(SignUpFailure("Something went wrong"));
    }
  }
}
