import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/main.dart';
import 'package:julib/model/studyroom_model.dart';

import '../../helper/app_colors.dart';

class StudyRoomWidget extends StatelessWidget {
  StudyRoom studyRoomModel;

  StudyRoomWidget({Key? key, required this.studyRoomModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      height: Get.height * 0.15,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: AppColors.grey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ]),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studyRoomModel.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        color: AppColors.lightBlue,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.lightOrange,
                          size: 15.0,
                        ),
                        Text(
                          languageCode == 'ar'
                              ? studyRoomModel.locationAR ?? ""
                              : studyRoomModel.locationEN ?? "",
                          overflow: TextOverflow.ellipsis,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                              color: AppColors.lightOrange,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
