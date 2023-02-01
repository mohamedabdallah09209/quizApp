import 'package:get/get.dart';
import 'package:quizquiz/controllers/question_paper/question_controller.dart';
import 'package:quizquiz/controllers/question_paper/question_paper_controller.dart';
import 'package:quizquiz/controllers/zoom_drawer_controller.dart';
import 'package:quizquiz/screens/home/home_screen.dart';
import 'package:quizquiz/screens/introduction/introduction.dart';
import 'package:quizquiz/screens/login/login_screen.dart';
import 'package:quizquiz/screens/question/answer_check_screen.dart';
import 'package:quizquiz/screens/question/result_screen.dart';
import 'package:quizquiz/screens/splash/splash_screen.dart';

import '../screens/question/questions_screen.dart';
import '../screens/question/test_overview_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: "/",
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: "/introduction",
          page: () =>  AppIntroductionScreen(),
        ),
        GetPage(
          name: QuestionsScreen.routeName,
          page: () => const QuestionsScreen(),
          binding: BindingsBuilder(
            () {
              Get.put<QuestionsController>(QuestionsController());
            },
          ),
        ),
        GetPage(
          name: "/home",
          page: () => const HomeScreen(),
          binding: BindingsBuilder(
            () {
              Get.put(
                QuestionPaperController(),
              );
              Get.put(
                MyZoomDrawerController(),
              );
            },
          ),
        ),
         GetPage(
          name: "/testoverview",
          page: () => const TestOverviewScreen(),
          
        ),
          GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
          
        ),
         GetPage(
          name: AnswerCheckScreen.routeName,
          page: () => const AnswerCheckScreen(),
          
        ),
      ];
}
