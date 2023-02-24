import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ojt_timelogs/firebase_options.dart';
import 'package:ojt_timelogs/screens/login_screen.dart';
import 'package:ojt_timelogs/screens/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(); // loading
          } else if (snapshot.hasError) {
            return Container(); // restart the app message
          } else if (snapshot.hasData) {
            return const MainScreen(); // home screen
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    this.isPassword,
    required this.controller,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  final String hintText;
  final bool? isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ?? false,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18, color: Colors.black),
      cursorColor: Colors.black,
      validator: validator,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }
}
