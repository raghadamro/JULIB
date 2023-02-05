import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/app_colors.dart';

class EventWidget extends StatelessWidget {
  Map<dynamic, dynamic> eventData = {};

  EventWidget({
    super.key,
    required this.eventData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: Get.height * 0.2,
      width: Get.width * 0.75,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: AppColors.grey),
          boxShadow: const [
            BoxShadow(
              color: AppColors.grey,
              offset: Offset(1, 1),
              blurRadius: 1,
              spreadRadius: 1,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: Get.height * 0.15,
            width: Get.width,
            //width: Get.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(eventData["image"]!),
                    fit: BoxFit.contain)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.02, horizontal: Get.width * 0.03),
            child: Text(
              eventData["titleAR"]!,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
