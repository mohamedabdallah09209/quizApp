import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Dialogs {
  static final Dialogs _singileton = Dialogs._internal();
  Dialogs._internal();

  factory Dialogs() {
    return _singileton;
  }

  Widget questionStartDialog({required VoidCallback onTap}){
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
        Text('hi'.tr,
        style: TextStyle(
          fontSize: 25,fontWeight: FontWeight.bold,
        ),
        ),
        Text("pleaseLogin".tr),

      ]),
      actions: [
        TextButton(onPressed: onTap, child:  Text("confirm".tr)),
      ],
    );
  }
}
