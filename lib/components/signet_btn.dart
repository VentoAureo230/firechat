import 'package:flutter/material.dart';

class SignetButton extends StatelessWidget {
  final bool isSigned;
  final Function()? onTap;
  const SignetButton({super.key, required this.isSigned, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isSigned ? Icons.bookmark : Icons.bookmark,
        color: isSigned ? Colors.blue : Colors.grey,
      ),
    );
  }
}
