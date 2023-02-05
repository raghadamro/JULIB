import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../helper/app_colors.dart';
import '../../viewmodel/studyrooms_viewmodel.dart';
import 'book_details_screen.dart';
import 'home_screen.dart';

class TabelSeatsScreen extends StatelessWidget {
  const TabelSeatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyRoomsViewModel>(
        init: StudyRoomsViewModel(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.mainColor,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              backgroundColor: Colors.white12,
              elevation: 0.0,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: controller.bookingModel!.bookingStatus == "waiting" ||
                    controller.bookingModel!.bookingStatus == "done"
                ? Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: Get.size.width * 0.1),
                    child: FloatingActionButton.extended(
                        onPressed: () {
                           Get.to( const BookDetailsScreen());
                        },
                        label: Center(
                          child: Text(
                            "showBookingInfo".tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        backgroundColor: AppColors.mainColor),
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: Get.size.width * 0.1),
                    child: FloatingActionButton.extended(
                        onPressed: () {
                          if (controller.bookingNow == true && controller.bookingModel!.seatIndex!="") {
                            DateTime timeNow = DateTime.now();
                            final currentTime =
                                DateFormat.jm('en').format(timeNow);
                            final validTime = DateFormat.jm('en').format(
                                timeNow.add(const Duration(minutes: 10)));
                            controller.bookingModel!.bookingTime = currentTime;
                            controller.bookingModel!.validTime = validTime;
                            controller.update();
                            FirebaseDatabase.instanceFor(
                                    app: Firebase.app(),
                                    databaseURL:
                                        "https://julib-2fd16-default-rtdb.firebaseio.com/")
                                .ref('StudyRooms')
                                .child(controller.bookingModel!.studyRoomIndex)
                                .child("tabels")
                                .child("${controller.bookingModel!.tabelIndex}")
                                .child("seats")
                                .child(controller.bookingModel!.seatIndex)
                                .update(({"status": "Waiting"}))
                                .then((value) {});
                            controller.bookingNow = false;
                            controller.slectedSeatID = null;
                            controller.bookingModel!.bookingStatus = "waiting";
                            controller.setBookingData();
                            controller.update();
                            AwesomeDialog(
                              padding: const EdgeInsets.all(10),
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: "bookingConfirmed".tr,
                              titleTextStyle: const TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                              desc: "bookingSuccessfullyConfirmed".tr,
                              btnOkColor: AppColors.mainColor,
                              btnOkText: 'homePage'.tr,
                              btnOkOnPress: () {
                                Get.off(const HomeScreen());
                              },
                            ).show();
                          } else {
                            if (controller.bookingNow == false) {
                            controller.bookingNow = true;
                            controller.slectedSeatID = null;
                            controller.update();
                          }
                          }
                        },
                        label: Center(
                          child: Text(
                            controller.bookingNow
                                ? "confirmBooking".tr
                                : "bookYourSeat".tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        backgroundColor: controller.bookingNow
                            ? AppColors.brawn
                            : AppColors.mainColor),
                  ),
            body: controller.selectedTableIndex != null
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              controller
                                      .studyRooms[controller.selectedRoomIndex!]
                                      .name ?? "",
                              style: const TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            controller.bookingModel!.tabelIndex != null
                                ? Text(
                                    "${"table".tr} ${controller.studyRooms[controller.selectedRoomIndex!].tabels![controller.selectedTableIndex!].number ?? ""}",
                                    style: const TextStyle(
                                      color: AppColors.brawn,
                                      fontSize: 15.0,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.05, bottom: Get.height * 0.1),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: AppColors.mainColor,
                                    radius: 8,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "available".tr,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: AppColors.lightOrange,
                                    radius: 8,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "pending".tr,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor: AppColors.red,
                                    radius: 8,
                                  ),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "unAvailable".tr,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.4,
                          width: Get.width * 0.4,
                          child: GridView.builder(
                              shrinkWrap: false,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 40,
                                mainAxisSpacing: 40,
                              ),
                              itemCount: controller
                                  .studyRooms[
                              controller.selectedRoomIndex!]
                                  .tabels![
                              controller.selectedTableIndex!]
                                  .seats!
                                  .length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    if (controller.bookingNow) {

                                      if (controller.studyRooms[controller.selectedRoomIndex!]
                                              .tabels![controller.selectedTableIndex!]
                                              .seats![index].status == "Available") {
                                        controller.slectedSeatID = controller
                                            .studyRooms[controller.selectedRoomIndex!]
                                            .tabels![controller.selectedTableIndex!]
                                            .seats![index]
                                            .id;
                                        controller.selectedSeatIndex=index;

                                        controller.update();
                                        controller.bookingModel!.seatIndex = "$index";
                                        controller.bookingModel!.seatNum="${controller.studyRooms[controller.selectedRoomIndex!].tabels![controller.selectedTableIndex!].seats![index].num}";
                                        controller.update();

                                      }
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: controller
                                                    .studyRooms[controller.selectedRoomIndex!]
                                                    .tabels![controller.selectedTableIndex!]
                                                    .seats![index]
                                                    .status ==
                                                "UnAvailable"
                                            ? AppColors.red
                                            : controller
                                                        .studyRooms[controller.selectedRoomIndex!]
                                                        .tabels![controller.selectedTableIndex!]
                                                        .seats![index]
                                                        .status ==
                                                    "Waiting"
                                                ? AppColors.lightOrange
                                                : controller.bookingNow
                                                    ?  controller.slectedSeatID ==controller.studyRooms[controller.selectedRoomIndex!].tabels![controller.selectedTableIndex!].seats![index].id

                                        ? AppColors.lightBlue
                                                        : AppColors.mainColor
                                                    : AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Text(
                                      "${controller.studyRooms[controller.selectedRoomIndex!].tabels![controller.selectedTableIndex!].seats![index].num ?? ""}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  )
                : const Center(child: CupertinoActivityIndicator()),
          );
        });
  }
}
