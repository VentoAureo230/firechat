import 'package:firebase_core/firebase_core.dart';
import 'package:firechat/auth/auth.dart';
import 'package:firechat/firebase_options.dart';
import 'package:firechat/pages/homepage.dart';
import 'package:firechat/pages/profile_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      routes: {
        '/homepage': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        //'/settings': (context) => const SettingsPage(),
      },
    );
  }
}
