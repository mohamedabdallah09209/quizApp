import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizquiz/configs/themes/app_icons.dart';
import 'package:quizquiz/configs/themes/ui_parameters.dart';
import 'package:quizquiz/screens/question/test_overview_screen.dart';
import 'package:quizquiz/widgets/app_circle_button.dart';

import '../../configs/themes/custom_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;
  final Widget? leading;

  const CustomAppBar(
      {super.key,
      this.leading,
      this.title = '',
      this.titleWidget,
      this.showActionIcon = false,
      this.onMenuActionTap});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: mobileScreenPadding, vertical: mobileScreenPadding),
        child: Stack(
          children: [
            Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                        title,
                        style: appBarTs,
                      ),
                    )
                  : Center(child: titleWidget),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leading ??
                    Transform.translate(
                      offset:const Offset(-14, 0),
                      child:const BackButton(),
                    ),
                if (showActionIcon)
                  Transform.translate(
                    offset:const Offset(10, 0),
                    child: AppCircleButton(
                      onTap: onMenuActionTap ??
                          () => Get.toNamed(TestOverviewScreen.routeName),
                      child: const Icon(AppIcons.menu),
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}
