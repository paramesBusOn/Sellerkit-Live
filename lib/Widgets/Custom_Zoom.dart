// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:simple_animations/simple_animations.dart';


// class Zoom extends StatelessWidget {
//   const Zoom({Key? key, required this.child}) : super(key: key);
//       final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     return PlayAnimation<double>(
//       tween: Tween(begin: 50.0, end: 350.0), // specify tween
//       duration: const Duration(milliseconds: 700), // set a duration
//       // delay: const Duration(seconds: 2),
//       builder: (context, childs, value) {
//         // <-- use builder function
//         return SizedBox(
//           width: value , // apply animated value from builder function parameter
//           height: value,
//           child: child,
//         );
//       },
//     );
//   }
// }