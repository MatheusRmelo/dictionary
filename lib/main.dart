import 'package:dictionary/constants/routes.dart';
import 'package:dictionary/firebase_options.dart';
import 'package:dictionary/views/home_view.dart';
import 'package:dictionary/views/signin_view.dart';
import 'package:dictionary/views/signup_view.dart';
import 'package:dictionary/views/word_detail_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      onGenerateRoute: (settings) {
        Widget page = const HomeView();
        if (settings.name == Routes.details && settings.arguments is Map) {
          page = WordDetailView(
              word: (settings.arguments as Map)['word'] as String,
              words: (settings.arguments as Map)['words'] as List<String>);
        }
        if (settings.name == Routes.signUp) {
          page = const SignUpView();
        } else if (settings.name == Routes.signIn ||
            FirebaseAuth.instance.currentUser == null) {
          page = const SignInView();
        }

        return MaterialPageRoute(
          settings: settings,
          builder: (context) => page,
        );
      },
      initialRoute: '/',
    );
  }
}
