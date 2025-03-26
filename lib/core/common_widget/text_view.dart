import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_styles.dart';

class TextView extends StatelessWidget {
  final String? text;
  final TextAlign? textAlign;
  final bool? softWrap;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextStyle? style;

  const TextView(
    this.text, {
    super.key,
    this.textAlign = TextAlign.left,
    this.softWrap,
    this.maxLines,
    this.overflow,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      (text?.isEmpty ?? true) ? "-" : (text ?? "-"),
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.clip,
      softWrap: softWrap,
      maxLines: maxLines,
      style: style ?? AppStyles.regular400(),
    );
  }
}
