import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmittedEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess(event.email));
      } on FirebaseAuthException catch (e) {
        emit(LoginFailure(e.message ?? 'Login failed'));
      }
    });
  }
}
