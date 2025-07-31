import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:register_auth/bloc/bloc/login_bloc.dart';
import 'package:register_auth/signup_screan_with_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          backgroundColor: Colors.blue,
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              Fluttertoast.showToast(msg: state.error, backgroundColor: Colors.red);
            } else if (state is LoginSuccess) {
              Fluttertoast.showToast(msg: "Welcome back ${state.email}", backgroundColor: Colors.green);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _email,
                      decoration: InputDecoration(labelText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),),
                      
                      validator: (value) =>
                          value!.contains('@') ? null : 'Enter a valid email',
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      validator: (value) =>
                          value!.length < 6 ? 'Min 6 characters' : null,
                    ),
                    const SizedBox(height: 30),
                    state is LoginLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<LoginBloc>().add(
                                      LoginSubmittedEvent(
                                        email: _email.text.trim(),
                                        password: _password.text.trim(),
                                      ),
                                    );
                              }
                            },
                            child: const Text("Login"),
                          ),
                    const SizedBox(height: 15),

                    
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreenWithBloc(),
                          ),
                        );
                      },
                      child: const Text("Don't have an account? Sign Up"),
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
