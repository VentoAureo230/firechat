import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/components/login_button.dart';
import 'package:firechat/components/text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  void signIn() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        Navigator.pop(context);
        displayErrorMessage(e.code);
      }
    }
  }

  void displayErrorMessage(String msgErr) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(msgErr),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              const Icon(
                Icons.lock,
                size: 100,
              ),
              //greetings
              const SizedBox(
                height: 25,
              ),
              const Text("Welcome Back !"),
              //email
              const SizedBox(
                height: 25,
              ),
              MyTextField(
                controller: emailTextController,
                hintText: "johndoe@gmail.com",
                obscureText: false,
              ),
              //password
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                controller: passwordTextController,
                hintText: "Password",
                obscureText: true,
              ),
              //sign in
              const SizedBox(
                height: 25,
              ),
              LoginButton(onTap: signIn, text: 'Sign In'),
              //register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member ? '),
                  const SizedBox(
                    height: 75,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Register now ',
                      style: TextStyle(
                          color: Colors.blue.shade400,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
