

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:register_auth/bloc/signup_bloc_bloc.dart';
import 'package:register_auth/login_screen.dart';
import 'package:register_auth/signup_screan_with_bloc.dart';
import 'package:register_auth/myapp.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignUpBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginScreen (), 
      ),
    );
  }
}

