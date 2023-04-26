// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  const TitleText({
    Key? key,
    required this.title,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:  TextStyle(
        fontSize: 22,
        fontWeight:fontWeight?? FontWeight.w600,
      ),
    );
  }
}
