import '../../styles/fonts.dart';
import 'package:flutter/material.dart';

class LightTextSubHead extends StatelessWidget {
  final String data;
  const LightTextSubHead({required this.data}) : super();

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 20,
          color: Colors.white,
          fontFamily: Fonts.poppins,
          fontWeight: FontWeight.w400),
    );
  }
}
