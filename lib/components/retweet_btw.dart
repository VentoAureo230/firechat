import 'package:flutter/material.dart';

class RetweetButton extends StatelessWidget {
  final bool isRetweeted;
  final Function()? onTap;
  const RetweetButton({
    Key? key,
    required this.isRetweeted,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isRetweeted ? Icons.compare_arrows_outlined : Icons.favorite_border,
        color: isRetweeted ? Colors.blue : Colors.grey,
      ),
    );
  }
}
