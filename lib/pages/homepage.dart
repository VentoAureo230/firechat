import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/components/firechat_posts.dart';
import 'package:flutter/material.dart';

import '../components/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final textController = TextEditingController();

  // log out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // post message
  void postFirechat() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'Likes': [],
        'Retweets': [],
        'Signets': [],
        'TimeStamp': Timestamp.now()
      });
      setState(() {
        textController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(
          "FireChat",
          style: TextStyle(color: Colors.grey.shade300),
        ),
        elevation: 0,
        actions: [
          IconButton(onPressed: signOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(children: [
          // Retrieve all the existing posts
          Expanded(
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .orderBy("TimeStamp", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // get post
                    final post = snapshot.data!.docs[index];
                    return FireChatPost(
                      message: post['Message'],
                      user: post['UserEmail'],
                      postId: post.id,
                      likes: List<String>.from(post['Likes'] ?? []),
                      retweets: List<String>.from(post['Retweets'] ?? []),
                      signets: List<String>.from(post['Signets']?? []),
                      //time: post['time']
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error${snapshot.error}'),
                );
              }
              return const CircularProgressIndicator();
            },
          )),

          // Post input
          Container(
            color: Colors.grey[900],
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                      child: MyTextField(
                    controller: textController,
                    obscureText: false,
                    hintText: 'Write something',
                  )),
                  IconButton(
                      onPressed: postFirechat,
                      icon: const Icon(Icons.arrow_circle_up)),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
