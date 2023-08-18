import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/components/delete_button.dart';
import 'package:flutter/material.dart';

class FireChatPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  //final String time;
  const FireChatPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    //required this.time
  });

  @override
  State<FireChatPost> createState() => _FireChatPostState();
}

class _FireChatPostState extends State<FireChatPost> {
  @override
  void initState() {
    super.initState();
  }

  void deletePost() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Delete post"),
              content: const Text("Are you sure ?"),
              actions: [
                // Cancel
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                // Delete
                TextButton(
                    onPressed: () async {
                      // delete comments 1st if there's any

                      // delete post
                      FirebaseFirestore.instance
                          .collection("User Posts")
                          .doc(widget.postId)
                          .delete()
                          .then((value) => print("Post deleted"))
                          .catchError(
                              (onError) => print("Failed to delete post"));
                    },
                    child: const Text("Delete"))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
          padding: const EdgeInsets.all(25),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user,
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  //Text(
                  //  widget.time,
                  //  style: TextStyle(color: Colors.grey[300]),
                  //),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.message,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),

              // delete button
              if (widget.user == currentUser?.email)
                DeleteButton(onTap: deletePost)
            ],
          ),
        ),
      ],
    );
  }
}
