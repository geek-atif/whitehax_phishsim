import 'package:flutter/material.dart';
import '../../styles/fonts.dart';
import '../../styles/my_app_theme.dart';

class DarkTextBody extends StatelessWidget {
  final String data;
  const DarkTextBody({required this.data}) : super();

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      data,
      style: const TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: 14,
        color: Colors.black,
        fontFamily: Fonts.poppins,
      ),
    );
  }
}
