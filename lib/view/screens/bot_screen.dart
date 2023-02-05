import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/helper/app_colors.dart';
import 'package:julib/main.dart';
import 'package:julib/view/wigdets/bot_button.dart';
import 'package:julib/viewmodel/bot_viewmodel.dart';

import '../wigdets/custom_appbar.dart';
import 'messages.dart';

class BotScreen extends StatelessWidget {
  const BotScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BotViewModel>(
        init: BotViewModel(),
        builder: (controller) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Get.size * 0.07,
                child: CustomAppBar(
                  title: "askTheBot".tr,
                )),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: MessagesScreen(messages: controller.messages)),
                controller.isServices
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: Get.height * 0.01),
                        child: SizedBox(
                          width: Get.width,
                          height: Get.height * 0.05,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.01),
                              child: InkWell(
                                  onTap: () {
                                    if (controller.selectedIndex == 0) {
                                      controller.sendMessage(
                                          languageCode == "ar"
                                              ? controller.servicesAR[index]
                                              : controller.servicesEN[index]);
                                      if (index == 2) {
                                        controller.selectedIndex = 1;
                                        controller.update();
                                      } else if (index == 3) {
                                        controller.selectedIndex = 2;
                                        controller.update();
                                      }
                                    } else if (controller.selectedIndex == 1) {
                                      controller.sendMessage(
                                          languageCode == "ar"
                                              ? controller.doorsAR[index]
                                              : controller.doorsEN[index]);
                                    } else if (controller.selectedIndex == 2) {
                                      controller.sendMessage(
                                          languageCode == "ar"
                                              ? controller.studyRoomsAR[index]
                                              : controller.studyRoomsEN[index]);
                                    }
                                  },
                                  child: BotButton(
                                      title: controller.selectedIndex == 0
                                          ? languageCode == "ar"
                                              ? controller.servicesAR[index]
                                              : controller.servicesEN[index]
                                          : controller.selectedIndex == 1
                                              ? languageCode == "ar"
                                                  ? controller.doorsAR[index]
                                                  : controller.doorsEN[index]
                                              : languageCode == "ar"
                                                  ? controller
                                                      .studyRoomsAR[index]
                                                  : controller
                                                      .studyRoomsEN[index])),
                            ),
                            itemCount: controller.selectedIndex == 0
                                ? controller.servicesAR.length
                                : controller.selectedIndex == 1
                                    ? controller.doorsAR.length
                                    : controller.studyRoomsAR.length,
                          ),
                        ),
                      )
                    : Container(),
                Container(
                  height: Get.height * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(1, 1),
                          blurRadius: 1,
                          spreadRadius: 1,
                        )
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: Get.height * 0.01,
                            left: Get.width * 0.03,
                            right: Get.width * 0.03),
                        child: Container(
                          height: Get.height * 0.06,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(color: AppColors.grey),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                controller: controller.messageController,
                                style:
                                    const TextStyle(color: AppColors.mainColor),
                                textDirection: TextDirection.rtl,
                                cursorColor: AppColors.brawn,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 5),
                                    hintText: "writeYourMessage".tr,
                                    hintStyle: const TextStyle(
                                        color: AppColors.grey, fontSize: 15)),
                              )),
                              IconButton(
                                onPressed: () {
                                  controller.sendMessage(
                                      controller.messageController.text);
                                  controller.messageController.clear();
                                },
                                icon: const Icon(Icons.send),
                                color: AppColors.mainColor,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.02),
                              child: InkWell(
                                onTap: () {
                                  controller.isServices = true;
                                  controller.selectedIndex = 0;
                                  controller.sendMessage('services'.tr);
                                  controller.update();
                                },
                                child: Container(
                                  height: Get.height * 0.05,
                                  width: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.grey.withOpacity(0.2),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "services".tr,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.02),
                              child: InkWell(
                                onTap: () {
                                  controller.sendMessage("whoAreWe".tr);
                                  controller.update();
                                },
                                child: Container(
                                  height: Get.height * 0.05,
                                  width: Get.width * 0.3,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.mainColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      "whoAreWe".tr,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
