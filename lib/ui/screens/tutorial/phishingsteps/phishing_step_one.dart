import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../ui/widgets/text/light_text_sub_head.dart';
import '../../../widgets/button/dark_blue_button.dart';
import '../../../widgets/text/light_text_body.dart';
import '../../../styles/my_app_theme.dart';
import '../../../widgets/dialogs/phishingsteps/phishing_one_dialog.dart';
import '../../../widgets/my_app_bar.dart';
import '../../../widgets/text/light_text_head.dart';

class PhishingStepOne extends StatefulWidget {
  const PhishingStepOne({Key? key}) : super(key: key);

  @override
  State<PhishingStepOne> createState() => _PhishingStepOneState();
}

class _PhishingStepOneState extends State<PhishingStepOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final GlobalKey<State> keyLoader = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const MyAppBar(),
        backgroundColor: MyAppTheme.whitehaxBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: LightTextHead(
                    data: "STEP 1",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LightTextBody(data: 'phishingOne'.tr),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    LightTextSubHead(data: "NOTE :"),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(child: LightTextBody(data: "phishingOneNote".tr))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () =>
                      PhishingOneDialog.showLoadingDialog(context, keyLoader),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: DarkBlueButton(buttonText: "Next"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}