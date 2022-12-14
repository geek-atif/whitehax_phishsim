import '../../../../utiles/sound_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';
import '../../../../controller/role_play_game_controller.dart';
import '../../../../model/questions.dart';
import '../../../../utiles/constant.dart';
import '../../../styles/images.dart';
import '../../../widgets/dialogs/dialogs_confetti.dart';
import '../../../widgets/text/light_text_sub_head.dart';
import 'email_phishing_option.dart';

class EmailPhishingQuestionCard extends StatefulWidget {
  EmailPhishingQuestionCard({
    // it means we have to pass this
    required this.question,
    required this.tooltipkey,
  }) : super();

  final Question question;
  final GlobalKey<TooltipState> tooltipkey;

  @override
  State<EmailPhishingQuestionCard> createState() =>
      _EmailPhishingQuestionCardState();
}

class _EmailPhishingQuestionCardState extends State<EmailPhishingQuestionCard> {
  late AudioPlayer player;
  final GlobalKey<State> keyLoader = GlobalKey<State>();
  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RolePlayGameController _controller = Get.put(RolePlayGameController());
    return SingleChildScrollView(
      // margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      // padding: const EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(25),
      // ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LightTextSubHead(data: widget.question.question),
            widget.question.image.isEmpty
                ? Text("")
                : SizedBox(
                    height: Get.height * 0.4,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.laptop_mac,
                            size: Get.height * 0.45,
                            color: Colors.white,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ZoomOverlay(
                            minScale: 0.5, // Optional
                            maxScale: 3.0, // Optional
                            twoTouchOnly: true, // Defaults to false
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                widget.question.image,
                                height: Get.height * 0.248,
                                //fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: kDefaultPadding / 2),
            ...List.generate(
              widget.question.options.length,
              (index) => EmailPhishingOption(
                index: index,
                text: widget.question.options[index],
                press: () async {
                  _controller.checkAns(widget.question, index);
                  var _correctAns = widget.question.answer;
                  var _selectedAns = index;
                  if (_correctAns == _selectedAns) {
                    if (!GetPlatform.isWindows) {
                      await player.setAsset(SoundConstant.correct);
                      player.play();
                    }
                    MyDialogsConfetti.showLoadingDialog(context, keyLoader);
                  } else {
                    if (!GetPlatform.isWindows) {
                      await player.setAsset(SoundConstant.incorrect);
                      player.play();
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
