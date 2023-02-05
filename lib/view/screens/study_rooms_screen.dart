import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/view/wigdets/studyroom_widget.dart';
import 'package:julib/viewmodel/studyrooms_viewmodel.dart';
import '../wigdets/custom_appbar.dart';
import 'seats_screen.dart';
import 'tabels_screen.dart';

class StudyRoomsScreen extends StatelessWidget {
  const StudyRoomsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyRoomsViewModel>(
        init: StudyRoomsViewModel(),
        builder: (controller) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Get.size * 0.07,
                child: CustomAppBar(
                  title: "studyRooms".tr,
                )),
            body: controller.loading == false
                ? SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(Get.height * 0.03),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      InkWell(
                                    onTap: () {
                                      controller.selectedRoomIndex =index;
                                      print("sssss${controller.selectedRoomIndex}");
                                      controller.update();

                                      if (controller.bookingModel!.bookingStatus != "waiting"|| controller.bookingModel!.bookingStatus!="done") {
                                        controller.bookingModel!.studyRoomIndex = "$index";
                                        controller.bookingModel!.studyRoomName = controller.studyRooms[index].name!;
                                        print("sssss${controller.bookingModel!.studyRoomName}");

                                        controller.update();
                                      }
                                        controller.bookingNow = false;
                                        controller.slectedSeatID = null;
                                        controller.update();

                                      controller.studyRooms[index].tabels == null
                                          ? Get.to(const SeatsScreen())
                                          : Get.to(const TabelsScreen());
                                    },
                                    child: StudyRoomWidget(
                                      studyRoomModel:
                                          controller.studyRooms[index],
                                    ),
                                  ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: Get.size.height * 0.02,
                                  ),
                                  itemCount: controller.studyRooms.length,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(child: CupertinoActivityIndicator()),
          );
        });
  }
}
