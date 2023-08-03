import 'package:flutter/material.dart';

import '../components/login_button.dart';
import '../components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

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
              const Text("Register to get access !"),
              //email
              const SizedBox(
                height: 25,
              ),
              LoginTextField(
                controller: emailTextController,
                hintText: "johndoe@email.com",
                obscureText: false,
              ),
              //password
              const SizedBox(
                height: 10,
              ),
              LoginTextField(
                controller: passwordTextController,
                hintText: "Password",
                obscureText: true,
              ),

              //Confirm password
              const SizedBox(
                height: 10,
              ),
              LoginTextField(
                controller: confirmPasswordTextController,
                hintText: "Confirm Password",
                obscureText: true,
              ),
              //sign in
              const SizedBox(
                height: 25,
              ),
              LoginButton(onTap: () {}, text: 'Sign Up'),
              //Redirect to sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account ? '),
                  const SizedBox(
                    height: 75,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Log in now',
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
