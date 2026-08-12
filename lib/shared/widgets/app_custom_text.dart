import 'package:flutter/material.dart';

class AppEllipsisText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double boxWidth;

  const AppEllipsisText({
    super.key,
    required this.text,
    required this.style,
    required this.boxWidth,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    );
  }
}
