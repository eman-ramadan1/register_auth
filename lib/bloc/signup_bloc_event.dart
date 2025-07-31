// signup_event.dart
part of 'signup_bloc_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpSubmittedEvent extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpSubmittedEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
