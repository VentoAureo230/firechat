import 'package:flutter/material.dart';

class SignetButton extends StatelessWidget {
  final bool isSaved;
  final Function()? onTap;
  const SignetButton({super.key, required this.isSaved, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isSaved ? Icons.bookmark : Icons.save,
        color: isSaved ? Colors.blue : Colors.grey,
      ),
    );
  }
}
