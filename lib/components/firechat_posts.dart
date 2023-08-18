import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firechat/components/delete_button.dart';
import 'package:firechat/components/like_btn.dart';
import 'package:firechat/components/retweet_btw.dart';
import 'package:firechat/components/signet_btn.dart';
import 'package:flutter/material.dart';

class FireChatPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  final List<String> retweets;
  final List<String>? signets;
  //final String time;
  const FireChatPost({
    super.key,
    required this.message,
    required this.user,
    required this.postId,
    required this.likes,
    required this.retweets,
    this.signets,
    //required this.time
  });

  @override
  State<FireChatPost> createState() => _FireChatPostState();
}

class _FireChatPostState extends State<FireChatPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;
  bool isRetweeted = false;
  bool isSigned = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
    isRetweeted = widget.retweets.contains(currentUser.email);
    isSigned = widget.signets!.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  void toggleRetweet() {
    setState(() {
      isRetweeted = !isRetweeted;
    });
  }

  void toggleSignet() {
    setState(() {
      isSigned = !isSigned;
    });
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
                      FirebaseFirestore.instance
                          .collection("comments")
                          .doc(widget.postId)
                          .delete();
                      // delete post
                      FirebaseFirestore.instance
                          .collection("User Posts")
                          .doc(widget.postId)
                          .delete();
                      Navigator.pop(context);
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
          width: MediaQuery.of(context).size.width *
              0.92, // take max width available
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[400]),
                child: const Icon(Icons.person, size: 40, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user,
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.message,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // like btn
                        LikeButton(
                          isLiked: isLiked,
                          onTap: toggleLike,
                        ),
                        // like counter
                        // retweet btn
                        RetweetButton(
                          isRetweeted: isRetweeted,
                          onTap: toggleRetweet,
                        ),
                        // retweet counter
                        // signet btn
                        SignetButton(
                          isSaved: isSigned,
                          onTap: toggleSignet,
                        )
                      ]),
                ],
              ),
              if (widget.user == currentUser?.email)
                DeleteButton(onTap: deletePost)
            ],
          ),
        ),
      ],
    );
  }
}
