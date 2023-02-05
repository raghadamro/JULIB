import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/main.dart';
import '../../helper/app_colors.dart';

class SectionWidget extends StatelessWidget {
  Map<dynamic, dynamic> sectionData = {};

  SectionWidget({super.key, required this.sectionData});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.height * 0.22,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(sectionData["image"]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Text(
              languageCode == "ar"
                  ? sectionData["nameAR"]
                  : sectionData["nameEN"],
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: Text(
                  "readMore".tr,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
