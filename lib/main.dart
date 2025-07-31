
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:register_auth/firebase_options.dart';
import 'package:register_auth/myapp.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

  // runApp(const MyApp());


