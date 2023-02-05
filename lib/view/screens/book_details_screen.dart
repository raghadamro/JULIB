import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/helper/helper_widget.dart';
import 'package:julib/main.dart';
import 'package:julib/model/booking_model.dart';
import 'package:julib/view/screens/home_screen.dart';
import 'package:julib/viewmodel/home_viewmodel.dart';
import 'package:julib/viewmodel/studyrooms_viewmodel.dart';

import '../../helper/app_colors.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyRoomsViewModel>(
        init: StudyRoomsViewModel(),
        builder: (controller) {
          return GetBuilder<HomeViewModel>(
              init: HomeViewModel(),
              builder: (homeCon){
                return Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Get.off(const HomeScreen());
                        },
                      ),
                      title:  Text(
                        "currentBookingDetails".tr,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      backgroundColor: AppColors.mainColor,
                      elevation: 0.0,
                    ),
                    body: controller.bookingModel!.bookingStatus=="waiting" ||  controller.bookingModel!.bookingStatus=="done"?
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(Get.width * 0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.02),
                                      child:  Text(
                                        "${"studentName".tr}:",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.02),
                                      child:  Text(
                                        "${"studentID".tr}:",
                                        style: const TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.02),
                                      child:  Text(
                                        "${"studyRoomName".tr}:",
                                        style: const TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    controller.bookingModel!.tabelIndex != "" && controller.bookingModel!.tabelIndex!=null?
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.02),
                                      child:  Text(
                                        "${"tabelNum".tr}:",
                                        style: const TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    )
                                        : const SizedBox(),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.02),
                                      child:  Text(
                                        "${"seatNum".tr}:",
                                        style: const TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.02),
                                      child:  Text(
                                        "${"bookingTime".tr}:",
                                        style: const TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ),
                                    controller.bookingModel!.bookingStatus=="waiting"?
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.02),
                                      child:  Text(
                                        "${"bookValidation".tr}:",
                                        style: const TextStyle(
                                          color: AppColors.mainColor,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                    ):const SizedBox()
                                  ],
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.only(right: Get.width * 0.01),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.02),
                                        child: Text(languageCode=="ar"?
                                          homeCon.userNameAR:homeCon.userNameEN,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: AppColors.brawn,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.02),
                                        child:  Text(
                                          homeCon.userId,
                                          style: const TextStyle(
                                            color: AppColors.brawn,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.02),
                                        child: Text(
                                          controller.
                                          bookingModel!.studyRoomName,
                                          style: const TextStyle(
                                            color: AppColors.brawn,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                      controller.bookingModel!.tabelIndex==""
                                          ? const SizedBox():
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.02),
                                        child: Text(
                                          "${controller.bookingModel!.tabelNum}",
                                          style: const TextStyle(
                                            color: AppColors.brawn,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.02),
                                        child: Text(
                                          controller.bookingModel!.seatNum,
                                          style: const TextStyle(
                                            color: AppColors.brawn,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.02),
                                        child: Text(
                                          controller.bookingModel!.bookingTime??"",
                                          style: const TextStyle(
                                            color: AppColors.brawn,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ),
                                      controller.bookingModel!.bookingStatus =="waiting"?
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.02),
                                        child: Text(
                                          controller.
                                          bookingModel!.validTime??"",
                                          style: const TextStyle(
                                            color: AppColors.brawn,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ):const SizedBox()
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.08,
                                    vertical: Get.height * 0.08),
                                child: controller.bookingModel!.bookingStatus=="done"?
                                InkWell(
                                  onTap: () {
                                    HelperWidgets.loading();
                                    if (controller.studyRooms[int.parse(controller.bookingModel!.studyRoomIndex)].tabels != null) {
                                      FirebaseDatabase.instanceFor(
                                          app: Firebase.app(),
                                          databaseURL:
                                          "https://julib-2fd16-default-rtdb.firebaseio.com/")
                                          .ref('StudyRooms')
                                          .child(
                                          controller.bookingModel!.studyRoomIndex)
                                          .child("tabels").
                                      child(
                                          "${controller.bookingModel!.tabelIndex}")
                                          .child("seats")
                                          .child(
                                          controller.bookingModel!.seatIndex)
                                          .update({
                                        "status": "Available"
                                      })
                                          .then((value) {
                                      });
                                    } else {
                                      FirebaseDatabase.instanceFor(
                                          app: Firebase.app(),
                                          databaseURL:
                                          "https://julib-2fd16-default-rtdb.firebaseio.com/")
                                          .ref('StudyRooms')
                                          .child(
                                          controller.bookingModel!.studyRoomIndex)
                                          .child("seats")
                                          .child(
                                          controller.bookingModel!.seatIndex)
                                          .update({
                                        "status": "Available"
                                      })
                                          .then((value) {
                                      });
                                    }

                                    controller.bookingModel = BookingModel(studyRoomName: "", seatNum: "", studyRoomIndex: "", seatIndex: "", bookingTime: "", validTime: "", bookingStatus: "noBooking",tabelIndex: "",tabelNum: "");
                                    controller.slectedSeatID = null;
                                    controller.update();
                                    controller.setBookingData();
                                    controller.update();
                                    controller.fetchBookingData().then((value) {
                                      if(value){
                                        Get.back();
                                        Get.off( const HomeScreen());
                                        controller.update();
                                      }
                                    });

                                  },
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      color: AppColors.red,
                                      borderRadius:
                                      BorderRadius.circular(25),
                                    ),
                                    child:  Center(
                                      child: Text(
                                        "cancelBooking".tr,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    :  controller.bookingModel!.bookingStatus =="waiting"?
                                Row(
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          print(controller.bookingModel!.studyRoomIndex);
                                          if (controller
                                              .studyRooms[int.parse(controller.
                                              bookingModel!.studyRoomIndex)]
                                              .tabels !=
                                              null) {
                                            FirebaseDatabase.instanceFor(
                                                app: Firebase.app(),
                                                databaseURL:
                                                "https://julib-2fd16-default-rtdb.firebaseio.com/")
                                                .ref('StudyRooms')
                                                .child(
                                                controller.bookingModel!.studyRoomIndex)
                                                .child("tabels")
                                                .child("${controller.bookingModel!.tabelIndex}")
                                                .child("seats")
                                                .child(
                                                controller.bookingModel!.seatIndex)
                                                .update(({
                                              "status":
                                              "UnAvailable"
                                            }))
                                                .then((value) {
                                            });
                                          } else {
                                            FirebaseDatabase.instanceFor(
                                                app: Firebase.app(),
                                                databaseURL:
                                                "https://julib-2fd16-default-rtdb.firebaseio.com/")
                                                .ref('StudyRooms')
                                                .child(
                                                controller.bookingModel!.studyRoomIndex)
                                                .child("seats")
                                                .child(
                                                controller.bookingModel!.seatIndex)
                                                .update({
                                              "status":
                                              "UnAvailable"
                                            })
                                                .then((value) {
                                            });
                                          }
                                          controller.bookingModel!.validTime ="";
                                          controller.bookingModel!.bookingStatus="done";
                                          controller.update();
                                          controller.setBookingData();
                                          controller.update();
                                        },
                                        child: Container(
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: AppColors.mainColor,
                                            borderRadius:
                                            BorderRadius.circular(
                                                25),
                                          ),
                                          child:  Center(
                                            child: Text(
                                              "confirm".tr,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.05,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          if (controller
                                              .studyRooms[int.parse(controller.
                                          bookingModel!.studyRoomIndex)]
                                              .tabels !=
                                              null) {
                                            FirebaseDatabase.instanceFor(
                                                app: Firebase.app(),
                                                databaseURL:
                                                "https://julib-2fd16-default-rtdb.firebaseio.com/")
                                                .ref('StudyRooms')
                                                .child(
                                                controller.bookingModel!.studyRoomIndex)
                                                .child("tabels")
                                                .child(
                                                "${controller.bookingModel!.tabelIndex}")
                                                .child("seats")
                                                .child(
                                                controller.bookingModel!.seatIndex)
                                                .update(({
                                              "status": "Available"
                                            }))
                                                .then((value) {
                                            });
                                          } else {
                                            FirebaseDatabase.instanceFor(
                                                app: Firebase.app(),
                                                databaseURL:
                                                "https://julib-2fd16-default-rtdb.firebaseio.com/")
                                                .ref('StudyRooms')
                                                .child(
                                                controller.bookingModel!.studyRoomIndex)
                                                .child("seats")
                                                .child(
                                                controller.bookingModel!.seatIndex)
                                                .update({
                                              "status": "Available"
                                            })
                                                .then((value) {
                                            });
                                          }
                                          controller.bookingModel = BookingModel(studyRoomName: "", seatNum: "", studyRoomIndex: "", seatIndex: "", bookingTime: "", validTime: "", bookingStatus: "noBooking",tabelIndex: "",tabelNum: "");
                                          controller.slectedSeatID = null;
                                          controller.update();
                                          controller.setBookingData();
                                          controller.update();
                                          controller.fetchBookingData();
                                          controller.update();
                                          Get.off( const HomeScreen());
                                        },
                                        child: Container(
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                            color: AppColors.red,
                                            borderRadius:
                                            BorderRadius.circular(
                                                25),
                                          ),
                                          child:  Center(
                                            child: Text(
                                              "Cancel".tr,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15.0,
                                                fontWeight:
                                                FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):Container()),
                          ],
                        ),
                      ),
                    ):
                    const Center(child: CupertinoActivityIndicator())
                );
              });
        });
  }
}
