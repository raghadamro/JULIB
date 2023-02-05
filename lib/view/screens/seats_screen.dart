import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../helper/app_colors.dart';
import '../../model/studyroom_model.dart';
import '../../viewmodel/studyrooms_viewmodel.dart';
import 'book_details_screen.dart';
import 'home_screen.dart';
class SeatsScreen extends StatelessWidget {
  const SeatsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyRoomsViewModel>(
        init: StudyRoomsViewModel(),
        builder: (controller) {
                return controller.selectedRoomIndex !=null?
                Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    centerTitle: true,
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.mainColor,
                      ),
                      onPressed: () {
                        Get.off(const HomeScreen());
                      },
                    ),
                    backgroundColor: Colors.white12,
                    elevation: 0.0,
                  ),
                  floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
                  floatingActionButton:
                  controller.bookingModel!.bookingStatus=="waiting" || controller.bookingModel!.bookingStatus== "done"?
                  Padding(
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
                        backgroundColor:AppColors.mainColor
                    ),
                  ):
                  Padding(
                          padding: EdgeInsets.symmetric(vertical: Get.size.width * 0.1),
                          child: FloatingActionButton.extended(
                              onPressed: () {
                                if (controller.bookingNow == true && controller.bookingModel!.seatIndex!="") {
                                  DateTime timeNow = DateTime.now();
                                  final currentTime = DateFormat.jm('en').format(timeNow);
                                  final validTime =  DateFormat.jm('en').format(timeNow.add(const Duration(minutes: 10)));
                                  controller.bookingModel!.bookingTime =currentTime;
                                  controller.bookingModel!.validTime=validTime;
                                  controller.update();
                                  FirebaseDatabase
                                      .instanceFor(
                                      app: Firebase.app(),
                                      databaseURL: "https://julib-2fd16-default-rtdb.firebaseio.com/")
                                      .ref('StudyRooms')
                                      .child(controller.bookingModel!.studyRoomIndex)
                                      .child("seats")
                                      .child(controller.bookingModel!.seatIndex)
                                      .update(({
                                    "status": "Waiting"
                                  }))
                                      .then((value) {
                                  });
                                  controller.bookingNow =false;
                                  controller.slectedSeatID =null;
                                  controller.bookingModel!.bookingStatus = "waiting";
                                  controller.bookingModel!.tabelIndex="";
                                  controller.bookingModel!.tabelNum="";
                                  controller.setBookingData();
                                  controller.update();
                                  AwesomeDialog(
                                    padding:
                                    const EdgeInsets
                                        .all(10),
                                    context: context,
                                    dialogType:
                                    DialogType
                                        .success,
                                    animType: AnimType
                                        .rightSlide,
                                    title:
                                    "bookingConfirmed".tr,
                                    titleTextStyle: const TextStyle(
                                        color: AppColors
                                            .mainColor,
                                        fontSize: 18,
                                        fontWeight:
                                        FontWeight
                                            .w500),
                                    desc:
                                    "bookingSuccessfullyConfirmed".tr,
                                    btnOkColor:
                                    AppColors
                                        .mainColor,
                                    btnOkText: 'homePage'.tr,
                                    btnOkOnPress: () {
                                      Get.off(const HomeScreen());
                                    },
                                  ).show();
                                }
                                else if (controller.bookingNow == false) {
                                  controller.bookingNow = true;
                                  controller.slectedSeatID =null;
                                  controller.update();
                                }
                              },
                              label: Center(
                                child: Text(
                                  controller.bookingNow ?
                                  "confirmBooking".tr :
                                  "bookYourSeat".tr,
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
                  body:
                  StreamBuilder<dynamic>(
                      stream: FirebaseDatabase.instanceFor(
                          app: Firebase.app(),
                          databaseURL:
                          "https://julib-2fd16-default-rtdb.firebaseio.com/")
                          .ref('StudyRooms').onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && !snapshot.hasError) {
                          dynamic map = snapshot.data.snapshot.value;
                          List<Object> mapData = List<Object>.from(map);
                          controller.studyRooms = studyRoomFromJson(json
                              .encode(json.decode(json.encode(mapData.toList()))));
                        }
                        return
                             Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    controller
                                        .studyRooms[controller.selectedRoomIndex!].name ?? "",
                                    style: const TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.02),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children:  [
                                        const CircleAvatar(
                                          backgroundColor:
                                          AppColors.mainColor,
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
                                      children:  [
                                        const CircleAvatar(
                                          backgroundColor:
                                          AppColors.lightOrange,
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
                                      children:  [
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
                                height: controller.studyRooms[controller.selectedRoomIndex!].seats!.length<10?
                                Get.height * 0.4:Get.height * 0.7,
                                width: controller.studyRooms[controller.selectedRoomIndex!].seats!.length<10?
                                Get.width * 0.4:Get.width * 0.7,
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                     SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount:  controller.studyRooms[
                                      controller.selectedRoomIndex!].seats!.length<10?
                                      2:5,
                                      crossAxisSpacing:controller
                                          .studyRooms[
                                      controller.selectedRoomIndex!].seats!.length<10?40: 5,
                                      mainAxisSpacing:controller.studyRooms[
                                      controller.selectedRoomIndex!].seats!.length<10?40: 5,
                                    ),
                                    itemCount: controller.studyRooms[
                                    controller.selectedRoomIndex!].seats!.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (controller.bookingNow) {
                                            if (controller.studyRooms[controller.selectedRoomIndex!].seats![index].status == "Available") {
                                              controller.slectedSeatID =
                                                  controller
                                                      .studyRooms[controller.selectedRoomIndex!]
                                                      .seats![index]
                                                      .id;
                                              controller.selectedSeatIndex=index;
                                              controller.update();

                                              controller.bookingModel!.seatIndex = "$index";
                                              controller.bookingModel!.seatNum ="${controller.studyRooms[controller.selectedRoomIndex!].seats![index].num}";
                                              controller.update();

                                            }
                                          }
                                        },
                                        child: Container(
                                          height: Get.height * 0.1,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: controller.studyRooms[controller.selectedRoomIndex!].seats![index].status == "UnAvailable"
                                                  ? AppColors.red
                                                  : controller.studyRooms[controller.selectedRoomIndex!].seats![index].status == "Waiting" ?
                                              AppColors.lightOrange
                                                  : controller.bookingNow ?
                                              controller.slectedSeatID ==controller.studyRooms[controller.selectedRoomIndex!].seats![index].id?
                                              AppColors.lightBlue
                                                  : AppColors
                                                  .mainColor
                                                  : AppColors
                                                  .mainColor,
                                              borderRadius:
                                              BorderRadius.circular(15)),
                                          child: Text(
                                            "${controller.studyRooms[controller.selectedRoomIndex!].seats![index].num}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ));
                      })
                ):
                const Center(child: CupertinoActivityIndicator());

              });

  }
}
