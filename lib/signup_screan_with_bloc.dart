import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:register_auth/custom_text_field.dart';
import '../bloc/signup_bloc_bloc.dart';


class SignUpScreenWithBloc extends StatefulWidget {
  const SignUpScreenWithBloc({super.key});

  @override
  State<SignUpScreenWithBloc> createState() => _SignUpScreenWithBlocState();
}

class _SignUpScreenWithBlocState extends State<SignUpScreenWithBloc> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
          backgroundColor: Colors.blue,
        ),
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpFailure) {
              Fluttertoast.showToast(msg: state.error, backgroundColor: Colors.red);
            } else if (state is SignUpSuccess) {
              Fluttertoast.showToast(msg: "Welcome ${state.email}", backgroundColor: Colors.green);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 30),
                    CustomTextFormField(
                      controller: _name,
                      label: 'Full Name',
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Enter your name' : null,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _email,
                      label: 'Email',
                      validator: (value) =>
                          value!.contains('@') ? null : 'Enter a valid email',
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _password,
                      label: 'Password',
                      obscureText: true,
                      validator: (value) =>
                          value!.length < 6 ? 'Min 6 characters' : null,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      controller: _confirmPassword,
                      label: 'Confirm Password',
                      obscureText: true,
                      validator: (value) => value != _password.text
                          ? 'Passwords do not match'
                          : null,
                    ),
                    const SizedBox(height: 30),
                    state is SignUpLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<SignUpBloc>().add(
                                      SignUpSubmittedEvent(
                                        name: _name.text.trim(),
                                        email: _email.text.trim(),
                                        password: _password.text.trim(),
                                        confirmPassword: _confirmPassword.text.trim(),
                                      ),
                                    );
                              }
                            },
                            child: const Text("Sign Up"),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
