import 'package:firechat/components/login_button.dart';
import 'package:firechat/components/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              //logo
              const SizedBox(height: 50),
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
              const SizedBox(height: 25,),
              LoginTextField(
                controller: emailTextController,
                hintText: "johndoe@gmail.com",
                obscureText: false,
              ),
              //password
              const SizedBox(height: 10,),
              LoginTextField(
                controller: passwordTextController,
                hintText: "*******",
                obscureText: true,
              ),
              //sign in
              const SizedBox(height: 25,),
              LoginButton(onTap: () {}, text: 'Sign In'),
              //register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  const Text('Not a member ?'),
                  const SizedBox(height: 75,),
                  Text(
                    'Register now ',
                    style: TextStyle(
                      color: Colors.blue.shade400,
                      fontWeight: FontWeight.bold),
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
