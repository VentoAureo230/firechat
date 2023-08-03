import 'package:firechat/pages/login.dart';
import 'package:firechat/pages/register.dart';
import 'package:flutter/material.dart';

class LogOrReg extends StatefulWidget {
  const LogOrReg({super.key});

  @override
  State<LogOrReg> createState() => _LogOrRegState();
}

class _LogOrRegState extends State<LogOrReg> {
  bool showLogPage = true;

  void togglePages() {
    setState(() {
      showLogPage = !showLogPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegisterPage(onTap: togglePages);
    }
  }
}
