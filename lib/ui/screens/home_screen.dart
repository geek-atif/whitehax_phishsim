import 'package:flutter/services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../utiles/constant.dart';
import '../../utiles/utility.dart';
import '../routers/my_router.dart';
import '../styles/my_app_theme.dart';
import '../widgets/navigationmenu/my_navigation_menu.dart';
import 'package:flutter/material.dart';
import '../widgets/text/blue_text_body.dart';
import '../widgets/text/dark_text_body.dart';
import '../widgets/text/light_text_body.dart';
import '../widgets/text/light_text_sub_head.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SliderDrawerState> keyLoader = GlobalKey<SliderDrawerState>();
  var gameScore;
  var quizScore;

  var isQuizScore = false;
  var isWordGameDone = false;
  var isRolePlayGameDone = false;
  var isPhishingScore = false;

  late List<ChartData> gameScoreChart = List.empty(growable: true);
  late List<ChartData> quizScoreChart = List.empty(growable: true);
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    loadScore();
    super.initState();
  }

  void loadScore() {
    print("loadScore()");
    loadGameScore();
    quizScore = Utility.getQuizScore();
    quizScoreChart
        .add(ChartData("Quiz Game", quizScore["QUIZ_PHISHING_ATTEMPT"]));
    print("loadScore() quizScoreChart ${quizScoreChart.length}");

    isQuizScore = Utility.getBolValue(Quiz_PHISHING_DONE);
    isPhishingScore = Utility.getBolValue(TUTORIAL_STEP_ATTEMPT_Done);
  }

  void loadGameScore() {
    gameScore = Utility.getGameScore();
    gameScoreChart.add(ChartData("Game", gameScore[GAME_TOTAL_PRE]));
    print("loadGameScore() gameScoreChart ${gameScoreChart.length}");
    isWordGameDone = Utility.getBolValue(GAME_WORD_DONE);
    isRolePlayGameDone = Utility.getBolValue(GAME_ROLE_PLAY_DONE);
    print(
        "loadGameScore() isWordGameDone ${isWordGameDone}  isRolePlayGameDone ${isRolePlayGameDone}");
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SliderDrawer(
          appBar: const SliderAppBar(
            appBarColor: MyAppTheme.whitehaxBackgroundColor,
            title: LightTextSubHead(
              data: "Whitehax Phishsim",
            ),
            drawerIconColor: Colors.white,
            appBarPadding: EdgeInsets.all(4),
            appBarHeight: 65,
          ),
          key: keyLoader,
          slider: const MyNavigationMenu(),
          child: SingleChildScrollView(
            child: homeContiner(screenSize),
          ),

          //homeContiner(screenSize),
          splashColor: Colors.white,
        ),
      ),
    );
  }

  SizedBox homeContiner(Size screenSize) {
    return SizedBox(
      width: screenSize.width,
      height: screenSize.height,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          right: 5.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Expanded(
              flex: 0,
              child: LightTextSubHead(data: "Your Score"),
            ),
            Expanded(
              flex: 2,
              child: scoreCard(screenSize),
            ),
            Expanded(
              flex: 0,
              child: SizedBox(
                height: screenSize.height * 0.02,
              ),
            ),
            Expanded(
              flex: 3,
              child: actionCard(screenSize),
            ),
            Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Card actionCard(Size screenSize) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.all(10.0),
      color: MyAppTheme.whitehaxdialog,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: LightTextSubHead(data: "Tutorials, Quizzes, Games"),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: actionOne(screenSize),
                )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: actionTwo(screenSize),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox actionOne(Size screenSize) {
    return SizedBox(
      height: Get.size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () => Get.toNamed(MyRouter.phishingStepOne),
              child: myCard(screenSize, isPhishingScore, "3-Steps Detect",
                  Icons.read_more),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () => Get.toNamed(MyRouter.officePhishingOne),
              child:
                  myCard(screenSize, false, "Office365 Risks", Icons.read_more),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () =>
                  Get.toNamed(MyRouter.quizScreen, arguments: "phishingQuiz"),
              child:
                  myCard(screenSize, isQuizScore, "Quizz", Icons.quiz_outlined),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox actionTwo(Size screenSize) {
    return SizedBox(
      height: Get.size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () => Get.toNamed(MyRouter.wordGameScreen),
              child: myCard(
                  screenSize, isWordGameDone, "Word Scrabble", Icons.games),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () => Get.toNamed(MyRouter.emailPhishingScreen,
                  arguments: "phishingEmailGame"),
              child: myCard(
                  screenSize, isRolePlayGameDone, "Role Play", Icons.games),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(""),
          ),
        ],
      ),
    );
  }

  Row scoreCard(Size screenSize) {
    return Row(
      children: [
        displayGraphScore(
            screenSize, "Game", gameScoreChart, gameScore[GAME_TOTAL]),
        displayGraphScore(screenSize, "Quiz", quizScoreChart,
            quizScore["QUIZ_PHISHING_TOTAL"]),
      ],
    );
  }

  Card myCard(Size screenSize, bool isDone, String title, IconData iconDat) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      color: MyAppTheme.whitehaxBoxSmall,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: screenSize.height * 0.011,
          ),
          isDone
              ? Icon(
                  iconDat,
                  size: 30,
                  color: MyAppTheme.whitehaxButtonColor,
                )
              : Icon(
                  iconDat,
                  size: 30,
                  color: Colors.black,
                ),
          isDone
              ? Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: BlueTextBody(data: title),
                  ),
                )
              : Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: DarkTextBody(data: title),
                  ),
                ),
          SizedBox(
            height: screenSize.height * 0.01,
          ),
        ],
      ),
    );
  }

  Expanded displayGraphScore(Size screenSize, String title,
      List<ChartData> totalScore, double maxValue) {
    print("displayGraphScore title ${title} maxValue ${maxValue} ");
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SfCircularChart(
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  widget: LightTextSubHead(
                    data: "${totalScore.first.y.abs()} %",
                  ),
                ),
              ],
              series: <CircularSeries>[
                // Renders radial bar chart
                RadialBarSeries<ChartData, String>(
                    dataSource: totalScore,
                    sortingOrder: SortingOrder.ascending,
                    useSeriesColor: true,
                    trackOpacity: 0.3,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    radius: '80%',
                    innerRadius: '80%',
                    cornerStyle: CornerStyle.endCurve,
                    gap: '3%',
                    maximumValue: 100,
                    // dataLabelSettings: const DataLabelSettings(
                    //     // Renders the data label
                    //     isVisible: true),
                    animationDelay: 2.0,
                    strokeWidth: 0.2,
                    trackBorderWidth: 1.0),
              ],
            ),
          ),
          LightTextBody(data: title),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

// SizedBox(
//   height: screenSize.height * 0.01,
// ),
// const Padding(
//   padding: EdgeInsets.only(left: 2),
//   child: LightTextSubHead(data: "Tutorial"),
// ),
// Row(
//   children: [
//     myCard(
//         screenSize, false, "office 365", Icons.read_more),
//     SizedBox(
//       width: screenSize.width * 0.01,
//     ),
//     InkWell(
//       onTap: () => Get.toNamed(MyRouter.phishingStepOne),
//       child: myCard(screenSize, isPhishingScore,
//           "3 Step\nPhishing", Icons.read_more),
//     ),
//   ],
// ),
// SizedBox(
//   height: screenSize.height * 0.012,
// ),
// const Padding(
//   padding: EdgeInsets.only(left: 2),
//   child: LightTextSubHead(data: "Quiz"),
// ),
// Row(
//   children: [
//     InkWell(
//       onTap: () => Get.toNamed(MyRouter.quizScreen,
//           arguments: "phishingQuiz"),
//       child: myCard(screenSize, isQuizScore, "Phishing",
//           Icons.quiz_outlined),
//     ),
//     SizedBox(
//       width: screenSize.width * 0.01,
//     ),
//   ],
// ),
// SizedBox(
//   height: screenSize.height * 0.012,
// ),
// const Padding(
//   padding: EdgeInsets.only(left: 2),
//   child: LightTextSubHead(data: "Game"),
// ),
// Row(
//   children: [
//     InkWell(
//         onTap: () => Get.toNamed(MyRouter.wordGameScreen),
//         child: myCard(
//             screenSize, isGameScore, "Word", Icons.games)),
//     SizedBox(
//       width: screenSize.width * 0.01,
//     ),
//   ],
// )
