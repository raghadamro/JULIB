import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelperWidgets {
  static loading() {
    Get.closeCurrentSnackbar();
    Get.closeAllSnackbars();
    if (Platform.isIOS) {
      Get.dialog(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              CupertinoActivityIndicator(),
            ],
          ),
          barrierColor: Get.theme.scaffoldBackgroundColor.withOpacity(0.6),
          barrierDismissible: true);
    } else {
      Get.dialog(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
          barrierColor: Get.theme.scaffoldBackgroundColor.withOpacity(0.6),
          barrierDismissible: false);
    }
  }
}
