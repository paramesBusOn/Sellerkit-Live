// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sellerkit/Constant/Screen.dart';

class LottieContainer extends StatelessWidget {
  const LottieContainer(
      {Key? key,
      required this.height,
      required this.width,
      required this.file});

  final double width;
  final double height;
  final String file;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Lottie.asset('$file',
          animate: true,
          repeat: true,
          height: Screens.padingHeight(context) * 0.2,
          width: Screens.width(context) * 0.2),
    );
  }
}
