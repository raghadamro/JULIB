import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/app_colors.dart';

class BookButton extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;

  const BookButton(
      {Key? key, required this.color, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.008),
      child: Container(
        height: Get.height * 0.12,
        width: Get.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: AppColors.grey),
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
