import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../styles/fonts.dart';
import '../../widgets/quiz/question_card.dart';
import '../../widgets/quiz/progress_bar.dart';
import '../../../controller/question_controller.dart';
import '../../../utiles/constant.dart';

class Body extends StatelessWidget {
  Body({required this.questionController}) : super();

  QuestionController questionController;

  @override
  Widget build(BuildContext context) {
    // So that we have acccess our controller
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kDefaultPadding),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ProgressBar(),
              ),
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(
                  () => Text.rich(
                    TextSpan(
                      text:
                          "Question ${questionController.questionNumber.value}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: Fonts.poppins,
                          fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: "/${questionController.questions.length}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: Fonts.poppins,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(thickness: 1.5, color: Colors.white),
              const SizedBox(height: 10),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: NeverScrollableScrollPhysics(),
                  controller: questionController.pageController,
                  onPageChanged: questionController.updateTheQnNum,
                  itemCount: questionController.questions.length,
                  itemBuilder: (context, index) {
                    final _random = Random();
                    return QuestionCard(
                        question: questionController.questions[_random
                            .nextInt(questionController.questions.length)]);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
