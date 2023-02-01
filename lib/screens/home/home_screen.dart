import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quizquiz/configs/themes/app_colors.dart';
import 'package:quizquiz/configs/themes/app_icons.dart';
import 'package:quizquiz/configs/themes/custom_text_style.dart';
import 'package:quizquiz/controllers/question_paper/question_paper_controller.dart';
import 'package:quizquiz/controllers/zoom_drawer_controller.dart';
import 'package:quizquiz/screens/home/my_menu_screen.dart';
import 'package:quizquiz/screens/home/question_card.dart';
import 'package:quizquiz/widgets/app_circle_button.dart';
import 'package:quizquiz/widgets/content_area.dart';

import '../../configs/themes/ui_parameters.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = "/home";
  
  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(builder: (_) {
      return ZoomDrawer(
        isRtl: Get.locale==const Locale('ar', 'EG')? true:false,
        controller: _.zoomDrawerController,
        borderRadius: 50,
        menuBackgroundColor: Theme.of(context).primaryColor,
        style: DrawerStyle.defaultStyle,
        slideWidth: MediaQuery.of(context).size.width*0.7,
        angle: 0.0,
        menuScreen:  MyMenueScreen(),
        mainScreen: Container(
          decoration: BoxDecoration(
            gradient: mainGradient()),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(mobileScreenPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppCircleButton(
                        onTap: controller.toogleDrawer,
                        child: const Icon(
                          Icons.menu,size: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Icon(
                              AppIcons.peace,
                            ),
                            const SizedBox(width: 5,),
                            Text(
                              'hellofriend'.tr,
                              style: detailText.copyWith(
                                  color: onSurfaceTextColor),
                            )
                          ],
                        ),
                      ),
                       Text(
                        'lerntoday'.tr,
                        style: headerText,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ContentArea(
                      addPadding: false,
                      child: Obx(
                        () => ListView.separated(
                            padding: UiParameters.mobileScreenPadding,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return QuestionCard(
                                  model:
                                      questionPaperController.allPapers[index]);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount:
                                questionPaperController.allPapers.length),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
