import 'package:flutter/material.dart';

class BodyText extends StatelessWidget {
  const BodyText(
      {Key? key,
      required this.color,
      required this.size,
      this.overflow = TextOverflow.ellipsis,
      this.maxLines = 1,
      required this.text,
      required this.weight,
      this.letterSpacing = 0.1,
      this.align = TextAlign.start})
      : super(key: key);

  final Color color;
  final String text;
  final double size;
  final TextOverflow overflow;
  final FontWeight weight;
  final TextAlign align;
  final double letterSpacing;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(fontFamily: 'KrossNeueGrotesk', fontSize: size, fontWeight: weight, letterSpacing: letterSpacing, height: 1.5, color: color),
    );
  }
}
