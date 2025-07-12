import 'package:flutter/material.dart';

class LikeButtonWidget extends StatefulWidget {
  const LikeButtonWidget({super.key});

  @override
  State<LikeButtonWidget> createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        color: isLiked ? Colors.red : Colors.white,
        size: 24,
      ),
      onPressed: () {
        setState(() {
          isLiked = !isLiked;
        });
      },
    );
  }
}
