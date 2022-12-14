import '../../../../controller/server_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../ui/routers/my_router.dart';
import '../../../../utiles/utility.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';
import '../../../../utiles/constant.dart';
import '../../../styles/images.dart';
import '../../../styles/my_app_theme.dart';
import '../../button/dark_blue_button.dart';
import '../../loading.dart';

class PhishingThreeDialog {
  static Future<void> showLoadingDialog(BuildContext context, GlobalKey key,
      ServerUpdateController serverUpdateController) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => true,
            child: SimpleDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              key: key,
              backgroundColor: MyAppTheme.whitehaxdialog,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ZoomOverlay(
                      minScale: 0.5, // Optional
                      maxScale: 3.0, // Optional
                      twoTouchOnly: true, // Defaults to false
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(Images.phisingthree)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () => Get.toNamed(
                    MyRouter.phishingStepFour,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: DarkBlueButton(buttonText: "NEXT"),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
