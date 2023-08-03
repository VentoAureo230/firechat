import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
            child: Text(
          "FireChat",
          style: TextStyle(color: Colors.grey.shade300),
        )),
        actions: [
          IconButton(
            onPressed: signOut, 
            icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
