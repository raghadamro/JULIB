import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/view/screens/study_rooms_screen.dart';
import 'package:julib/view/screens/tabel_seats_screen.dart';
import 'package:julib/view/wigdets/custom_title.dart';
import '../../helper/app_colors.dart';
import '../../model/studyroom_model.dart';
import '../../viewmodel/studyrooms_viewmodel.dart';

class TabelsScreen extends StatefulWidget {
  const TabelsScreen({Key? key}) : super(key: key);

  @override
  State<TabelsScreen> createState() => _TabelsScreenState();
}

class _TabelsScreenState extends State<TabelsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudyRoomsViewModel>(
        init: StudyRoomsViewModel(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                toolbarHeight: Get.height * 0.04,
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.mainColor,
                  ),
                  onPressed: () {
                    Get.off(const StudyRoomsScreen());
                  },
                ),
                backgroundColor: Colors.white12,
                elevation: 0.0,
              ),
              body: controller.selectedRoomIndex != null && controller.studyRooms[controller.selectedRoomIndex!].tabels != null
                  ? StreamBuilder<dynamic>(
                      stream: FirebaseDatabase.instanceFor(
                              app: Firebase.app(),
                              databaseURL:
                                  "https://julib-2fd16-default-rtdb.firebaseio.com/")
                          .ref('StudyRooms')
                          .onValue,
                      builder: (context, snapshot) {
                        if (snapshot.hasData && !snapshot.hasError) {
                          dynamic map = snapshot.data.snapshot.value;
                          List<Object> mapData = List<Object>.from(map);
                          print(mapData);
                          controller.studyRooms = studyRoomFromJson(json.encode(
                              json.decode(json.encode(mapData.toList()))));
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.05),
                              child: Row(
                                children: [
                                  CustomTitle(
                                    title: controller.studyRooms[controller.selectedRoomIndex!].name ?? "",
                                    color: AppColors.lightBlue,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                            Container(
                              height: Get.height * 0.75,
                              decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.1,
                                    vertical: Get.height * 0.02),
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: (1 / 1),
                                    ),
                                    itemCount: controller
                                        .studyRooms[controller.selectedRoomIndex!]
                                        .tabels!
                                        .length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            controller.selectedTableIndex=index;
                                            print("vvvv${ controller.selectedTableIndex}");
                                            controller.update();
                                            if (controller.bookingModel!.bookingStatus !="waiting" || controller.bookingModel!.bookingStatus !="done") {
                                              controller.bookingModel!.tabelIndex = "$index";
                                              controller.bookingModel!.tabelNum="${controller.studyRooms[controller.selectedRoomIndex!].tabels![index].number}";
                                              print("vvvv${ controller.bookingModel!.tabelNum}");

                                              controller.update();
                                            }
                                            controller.bookingNow = false;
                                            controller.update();
                                            Get.to(const TabelSeatsScreen());
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              height: Get.height * 0.04,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              child: Stack(
                                                children: [
                                                  GridView.builder(
                                                      shrinkWrap: false,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2,
                                                        crossAxisSpacing: 0.2,
                                                        mainAxisSpacing: 0.2,
                                                      ),
                                                      itemCount: controller
                                                          .studyRooms[controller.selectedRoomIndex!]
                                                          .tabels![index]
                                                          .seats!
                                                          .length,
                                                      itemBuilder: (context,
                                                          tableIndex) {
                                                        return Container(
                                                          alignment:
                                                              Alignment.center,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: controller
                                                                        .studyRooms[controller.selectedRoomIndex!]
                                                                        .tabels![
                                                                            index]
                                                                        .seats![
                                                                            tableIndex]
                                                                        .status ==
                                                                    "UnAvailable"
                                                                ? AppColors.red
                                                                : controller
                                                                            .studyRooms[controller.selectedRoomIndex!]
                                                                            .tabels![
                                                                                index]
                                                                            .seats![
                                                                                tableIndex]
                                                                            .status ==
                                                                        "Waiting"
                                                                    ? AppColors
                                                                        .lightOrange
                                                                    : AppColors
                                                                        .mainColor,
                                                          ),
                                                        );
                                                      }),
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        height:
                                                            Get.height * 0.15,
                                                        width: double.infinity,
                                                        color: Colors.black
                                                            .withOpacity(0.4),
                                                        child: Center(
                                                          child: Text(
                                                            "${controller.studyRooms[controller.selectedRoomIndex!].tabels![index].number}",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      )),
                                                ],
                                              )));
                                    }),
                              ),
                            ),
                          ],
                        );
                      })
                  : const Center(child: CupertinoActivityIndicator()));
        });
  }
}
