import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/app_colors.dart';

class BotButton extends StatelessWidget {
  final String title;

  const BotButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.05,
      width: Get.width * 0.32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.mainColor,
      ),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
