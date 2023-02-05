import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/main.dart';

import '../../helper/app_colors.dart';
import '../wigdets/custom_title.dart';

class SectionScreen extends StatelessWidget {
  Map<dynamic, dynamic> sectionData = {};

  SectionScreen({Key? key, required this.sectionData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.mainColor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: Get.width * 0.05,
              right: Get.width * 0.05,
              bottom: Get.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      bottom: Get.height * 0.02, top: Get.height * 0.025),
                  child: CustomTitle(
                    title: languageCode == "ar"
                        ? "${sectionData["nameAR"]}"
                        : "${sectionData["nameEN"]}",
                    color: AppColors.lightBlue,
                  )),
              Container(
                height: Get.height * 0.25,
                width: Get.width * 0.9,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(sectionData["image"]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Text(
                  languageCode == "ar"
                      ? sectionData["descAR"]
                      : sectionData["descEN"],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
