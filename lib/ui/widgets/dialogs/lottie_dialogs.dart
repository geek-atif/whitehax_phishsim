// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class LottieDialogs {
//   static Future<void> showLoadingDialog(
//       BuildContext context, GlobalKey key) async {
//     return showDialog<void>(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return WillPopScope(
//             onWillPop: () async => false,
//             child: SimpleDialog(
//               key: key,
//               backgroundColor: Colors.transparent,
//               children: <Widget>[
//                 Center(
//                   child: Lottie.asset(Images.coinFlipRupee),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
