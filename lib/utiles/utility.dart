import 'package:flutter/services.dart';
//import 'package:flutter_js/flutter_js.dart';
//import 'package:flutter_js/javascript_runtime.dart';

import '../../../../model/login_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../ui/routers/my_router.dart';
import 'package:intl/intl.dart';
import '../ui/native_code/platform_channel_handler.dart';
import 'constant.dart';
import 'package:otp/otp.dart';

class Utility {
  static bool isLoginRequired() {
    final getStorage = GetStorage();
    return getStorage.hasData(USER_LOGIN_STATUS)
        ? getStorage.read(USER_LOGIN_STATUS)
        : false;
  }

  static showInfo(String content) {
    Get.snackbar(
      "Info",
      content,
      colorText: Colors.white,
    );
  }

  static showError(String content) {
    Get.snackbar(
      "Error",
      content,
      colorText: Colors.red,
    );
  }

  static String getCurrentTime() {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    final String formatted = formatter.format(now);
    return (formatted);
  }

  static saveloginData(LoginResponse userLogin, String userName,
      String emailAddress, String companyName) {
    final getStorage = GetStorage();
    getStorage.write(USER_LOGIN_STATUS, true);
    getStorage.write(USER_ID, userLogin.userId);
    getStorage.write(USER_ADMIN_ID, userLogin.adminId);
    getStorage.write(USER_EMAIL_ADDRESS, emailAddress);
    getStorage.write(USER_NAME, userName);
    getStorage.write(USER_COMPANY_NAME, companyName);
    Get.offAndToNamed(MyRouter.homeScreen);
  }

  static getLoginInfo() {
    final getStorage = GetStorage();
    var userName =
        getStorage.hasData(USER_NAME) ? getStorage.read(USER_NAME) : "";
    var userEmail = getStorage.hasData(USER_EMAIL_ADDRESS)
        ? getStorage.read(USER_EMAIL_ADDRESS)
        : "";
    var userCompanyName = getStorage.hasData(USER_COMPANY_NAME)
        ? getStorage.read(USER_COMPANY_NAME)
        : "";

    return {
      USER_NAME: userName,
      USER_EMAIL_ADDRESS: userEmail,
      USER_COMPANY_NAME: userCompanyName
    };
  }

  static saveIntValue(String keyName, int value) {
    final getStorage = GetStorage();
    getStorage.write(keyName, value);
  }

  static getIntValue(String keyName) {
    final getStorage = GetStorage();
    return getStorage.hasData(keyName) ? getStorage.read(keyName) : 0;
  }

  static saveStringValue(String keyName, bool value) {
    final getStorage = GetStorage();
    getStorage.write(keyName, value);
  }

  static getStringValue(String keyName) {
    final getStorage = GetStorage();
    return getStorage.hasData(keyName) ? getStorage.read(keyName) : "";
  }

  static saveBolValue(String keyName, bool value) {
    final getStorage = GetStorage();
    getStorage.write(keyName, value);
  }

  static getBolValue(String keyName) {
    final getStorage = GetStorage();
    return getStorage.hasData(keyName) ? getStorage.read(keyName) : false;
  }

  static String getUserName() {
    final getStorage = GetStorage();
    return getStorage.hasData(USER_NAME) ? getStorage.read(USER_NAME) : "";
  }

  static String getEmailAddress() {
    final getStorage = GetStorage();
    return getStorage.hasData(USER_EMAIL_ADDRESS)
        ? getStorage.read(USER_EMAIL_ADDRESS)
        : "";
  }

  static String getCompanyName() {
    final getStorage = GetStorage();
    return getStorage.hasData(USER_COMPANY_NAME)
        ? getStorage.read(USER_COMPANY_NAME)
        : "";
  }

  static logout() {
    final getStorage = GetStorage();
    getStorage.write(USER_LOGIN_STATUS, false);
    getStorage.write(USER_ID, 0);
    getStorage.write(USER_ADMIN_ID, 0);

    getStorage.write(GAME_TOTAL_PRE, 0.0);
    getStorage.write(GAME_TOTAL, 0.0);

    getStorage.write(GAME_WORD_TOTAL, 0.0);
    getStorage.write(GAME_WORD_ATTEMPT, 0.0);
    getStorage.write(GAME_WORD_DONE, false);

    getStorage.write(GAME_ROLE_PLAY_TOTAL, 0.0);
    getStorage.write(GAME_ROLE_PLAY_ATTEMPT, 0.0);
    getStorage.write(GAME_WORD_DONE, false);

    getStorage.write(QUIZ_TOTAL_PRE, 0.0);
    getStorage.write(QUIZ_TOTAL, 0.0);

    getStorage.write(QUIZ_PHISHING_TOTAL, 0.0);
    getStorage.write(QUIZ_PHISHING_ATTEMPT, 0.0);
    getStorage.write(Quiz_PHISHING_DONE, false);

    getStorage.write(TUTORIAL_OFFICE_TOTAL, 0.0);
    getStorage.write(TUTORIAL_OFFICE_ATTEMPT, 0.0);
    getStorage.write(TUTORIAL_OFFICE_DONE, false);

    getStorage.write(TUTORIAL_STEP_TOTAL, 0.0);
    getStorage.write(TUTORIAL_STEP_ATTEMPT, 0.0);
    getStorage.write(TUTORIAL_STEP_ATTEMPT_Done, false);

    Get.offAndToNamed(MyRouter.loginScreen);
  }

// #################### GAME ##############################
  static updateGameWordTotal(int total) {
    print("updateGameWordTotal() total ${total}");
    final getStorage = GetStorage();
    getStorage.write(GAME_WORD_TOTAL, total);
  }

  static int getGameWordTotal() {
    final getStorage = GetStorage();
    return getStorage.hasData(GAME_WORD_TOTAL)
        ? getStorage.read(GAME_WORD_TOTAL)
        : 0;
  }

  static updateGameWordAttempt(int total) {
    print("updateGameWordAttempt() total ${total}");
    final getStorage = GetStorage();
    getStorage.write(GAME_WORD_ATTEMPT, total);
  }

  static int getGameWordAttempt() {
    final getStorage = GetStorage();
    return getStorage.hasData(GAME_WORD_TOTAL)
        ? getStorage.read(GAME_WORD_TOTAL)
        : 0;
  }

  static updateGameRolePlayTotal(int total) {
    print("updateGameRolePlayTotal() total ${total}");
    final getStorage = GetStorage();
    getStorage.write(GAME_ROLE_PLAY_TOTAL, total);
  }

  static int getGameRolePlayTotal() {
    final getStorage = GetStorage();
    return getStorage.hasData(GAME_ROLE_PLAY_TOTAL)
        ? getStorage.read(GAME_ROLE_PLAY_TOTAL)
        : 0;
  }

  static updateGameRolePlayAttempt(int total) {
    print("updateGameRolePlayAttempt() total ${total}");
    final getStorage = GetStorage();
    getStorage.write(GAME_ROLE_PLAY_ATTEMPT, total);
  }

  static int getGameRolePlayAttempt() {
    final getStorage = GetStorage();
    return getStorage.hasData(GAME_ROLE_PLAY_ATTEMPT)
        ? getStorage.read(GAME_ROLE_PLAY_ATTEMPT)
        : 0;
  }

  static updateQuizPhishingTotal(int total) {
    print("updateQuizPhishingTotal() total ${total}");
    final getStorage = GetStorage();
    getStorage.write(QUIZ_PHISHING_TOTAL, total);
  }

  static int getQuizPhishingTotal() {
    final getStorage = GetStorage();
    return getStorage.hasData(QUIZ_PHISHING_TOTAL)
        ? getStorage.read(QUIZ_PHISHING_TOTAL)
        : 0;
  }

  static updateQuizPhishingAttempt(int total) {
    print("updateQuizPhishingAttempt() total ${total}");
    final getStorage = GetStorage();
    getStorage.write(QUIZ_PHISHING_ATTEMPT, total);
  }

  static int getQuizPhishingAttempt() {
    final getStorage = GetStorage();
    return getStorage.hasData(QUIZ_PHISHING_ATTEMPT)
        ? getStorage.read(QUIZ_PHISHING_ATTEMPT)
        : 0;
  }

  static Map<String, double> getGameScore() {
    final Map<String, double> result = {};
    final getStorage = GetStorage();
    result[GAME_WORD_TOTAL] = getStorage.hasData(GAME_WORD_TOTAL)
        ? getStorage.read(GAME_WORD_TOTAL).toDouble()
        : 0.0;
    result[GAME_WORD_ATTEMPT] = getStorage.hasData(GAME_WORD_ATTEMPT)
        ? getStorage.read(GAME_WORD_ATTEMPT).toDouble()
        : 0.0;

    result[GAME_ROLE_PLAY_TOTAL] = getStorage.hasData(GAME_ROLE_PLAY_TOTAL)
        ? getStorage.read(GAME_ROLE_PLAY_TOTAL).toDouble()
        : 0.0;
    result[GAME_ROLE_PLAY_ATTEMPT] = getStorage.hasData(GAME_ROLE_PLAY_ATTEMPT)
        ? getStorage.read(GAME_ROLE_PLAY_ATTEMPT).toDouble()
        : 0.0;

    var wordGame =
        (result[GAME_WORD_ATTEMPT]! / result[GAME_WORD_TOTAL]!) * 100;

    print("getGameScore() wordGame ${wordGame}");

    var rolePlayGame =
        (result[GAME_ROLE_PLAY_ATTEMPT]! / result[GAME_ROLE_PLAY_TOTAL]!) * 100;
    print("getGameScore() rolePlayGame ${rolePlayGame}");
    var tt = 0.0;
    if (rolePlayGame.isNaN && wordGame.isNaN) {
      tt = 0.0;
    } else if (rolePlayGame.isNaN && !wordGame.isNaN) {
      tt = wordGame;
    } else if (!rolePlayGame.isNaN && wordGame.isNaN) {
      tt = rolePlayGame;
    } else {
      tt = (wordGame + rolePlayGame) / 2;
    }
    result[GAME_TOTAL_PRE] = tt.toPrecision(2);

    if (result[GAME_WORD_TOTAL]!.isNaN && result[GAME_ROLE_PLAY_TOTAL]!.isNaN) {
      result[GAME_TOTAL] = 0.0;
    } else if (result[GAME_WORD_TOTAL]!.isNaN &&
        !result[GAME_ROLE_PLAY_TOTAL]!.isNaN) {
      result[GAME_TOTAL] = result[GAME_WORD_TOTAL]!;
    } else if (!result[GAME_WORD_TOTAL]!.isNaN &&
        result[GAME_ROLE_PLAY_TOTAL]!.isNaN) {
      result[GAME_TOTAL] = result[GAME_WORD_TOTAL]!;
    } else {
      result[GAME_TOTAL] =
          result[GAME_WORD_TOTAL]! + result[GAME_ROLE_PLAY_TOTAL]!;
    }

    return result;
  }

  static Map<String, double> getQuizScore() {
    final Map<String, double> result = {};
    final getStorage = GetStorage();

    result[QUIZ_PHISHING_TOTAL] = getStorage.hasData(QUIZ_PHISHING_TOTAL)
        ? getStorage.read(QUIZ_PHISHING_TOTAL).toDouble()
        : 0.0;
    result[QUIZ_PHISHING_ATTEMPT] = getStorage.hasData(QUIZ_PHISHING_ATTEMPT)
        ? getStorage.read(QUIZ_PHISHING_ATTEMPT).toDouble()
        : 0.0;

    var quizTotalPhising =
        (result[QUIZ_PHISHING_ATTEMPT]! / result[QUIZ_PHISHING_TOTAL]!) * 100;

    if (quizTotalPhising.isNaN) {
      result[QUIZ_TOTAL_PRE] = 0.0;
    } else {
      result[QUIZ_TOTAL_PRE] = quizTotalPhising.toPrecision(2);
    }

    result[QUIZ_TOTAL] = result[QUIZ_PHISHING_TOTAL]!;
    return result;
  }

  // static getTotp() async {
  //   return OTP
  //       .generateTOTPCode('EHFHEOFJOIEJFOIJIOSFJIOSJIOFIOFR', 5551600,
  //           algorithm: Algorithm.SHA1, interval: 300)
  //       .toString();

  //   // return OTP.generateTOTPCodeString('EHFHEOFJOIEJFOIJIOSFJIOSJIOFIOFR',
  //   //     DateTime.now().millisecondsSinceEpoch,
  //   //     interval: 30, algorithm: Algorithm.SHA1, length: 6, isGoogle: false);
  // }

  static getTotp() async {
    var totp = "";
    try {
      final _platformChannelHandler = PlatformChannelHandler();
      totp = await _platformChannelHandler.getTotp();
      //totp = Utility.getTotp();
    } on PlatformException catch (e) {
      Get.snackbar("Error", e.message.toString());
    }
    return totp.toString();
  }

  static String getOS() {
    var os = "";
    if (GetPlatform.isAndroid) {
      os = "android";
    } else if (GetPlatform.isIOS) {
      os = "ios";
    }

    print("os ${os}");
    return os;
  }

  static String convertToLocalDateTime(int dateUtc) {
    try {
      //return dateUtc;
      // if (dateUtc.isEmpty) {
      //   return "";
      // }

      // if (dateUtc == "00:00") {
      //   return "";
      // }

      if (dateUtc == 0) {
        return "";
      }

      // var dateTime = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(dateUtc, true);
      // var dateLocal = dateTime.toLocal();
      // return "${dateLocal.year}-${dateLocal.month}-${dateLocal.day} ${dateLocal.hour}:${dateLocal.minute}:${dateLocal.second}";
      var dateLocal = DateTime.fromMillisecondsSinceEpoch(dateUtc);
      //var dateLocal = dateTime.toLocal();
      return "${dateLocal.year}-${dateLocal.month}-${dateLocal.day} ${dateLocal.hour}:${dateLocal.minute}:${dateLocal.second}";
    } catch (e) {
      e.printError();
    }

    return "";
  }

  static int getRoleGameScore() {
    int totalScore = 0;
    var roleGame1 = getBolValue(ROLE_PLAY_GAME1);
    var roleGame2 = getBolValue(ROLE_PLAY_GAME2);
    var roleGame3 = getBolValue(ROLE_PLAY_GAME3);
    var roleGame4 = getBolValue(ROLE_PLAY_GAME4);
    var roleGame5 = getBolValue(ROLE_PLAY_GAME5);

    if (roleGame1) {
      totalScore = totalScore + 1;
    }

    if (roleGame2) {
      totalScore = totalScore + 1;
    }

    if (roleGame3) {
      totalScore = totalScore + 1;
    }
    if (roleGame4) {
      totalScore = totalScore + 1;
    }

    if (roleGame5) {
      totalScore = totalScore + 1;
    }

    var totalScore_ = ((totalScore / 5) * 100);
    return totalScore_.toInt();
  }
}
