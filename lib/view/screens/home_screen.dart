import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/view/screens/book_details_screen.dart';
import 'package:julib/view/screens/bot_screen.dart';
import 'package:julib/view/screens/search_screen.dart';
import 'package:julib/view/screens/section_screen.dart';
import 'package:julib/view/wigdets/book_button.dart';
import 'package:julib/view/wigdets/custom_title.dart';
import 'package:julib/view/wigdets/event_widget.dart';
import 'package:julib/view/wigdets/home_appbar.dart';
import 'package:julib/view/wigdets/section_widget.dart';
import 'package:julib/viewmodel/event_viewmodel.dart';
import 'package:julib/viewmodel/home_viewmodel.dart';
import 'package:julib/viewmodel/section_viewmodel.dart';
import 'package:julib/viewmodel/studyrooms_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../helper/app_colors.dart';
import 'events_screen.dart';
import 'study_rooms_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
        init: HomeViewModel(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                  preferredSize: Get.size * 0.273,
                  child: HomeAppBar(
                    libAvailable: controller.libAvailable,
                    userNameAR: controller.userNameAR,
                    userNameEN: controller.userNameEN,
                    userId: controller.userId,
                  )),
              floatingActionButton: FloatingActionButton(
                materialTapTargetSize: MaterialTapTargetSize.padded,
                backgroundColor: AppColors.mainColor,
                elevation: 4.0,
                onPressed: () {
                  Get.to(const BotScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Center(
                    child: Image.asset('assets/images/botlogo.png'),
                  ),
                ),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchUserData();
                  Get.put(StudyRoomsViewModel());
                  Get.find<StudyRoomsViewModel>().fetchBookingData();
                  Get.find<StudyRoomsViewModel>().update();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Get.height * 0.03,
                    ),
                    child: Column(
                      children: [
                        GetBuilder<StudyRoomsViewModel>(
                            init: StudyRoomsViewModel(),
                            builder: (con) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.025),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Get.to(const SearchScreen());
                                        },
                                        child: BookButton(
                                          color: AppColors.lightOrange,
                                          title: "bookSearch".tr,
                                          icon: Icons.search,
                                        )),
                                    con.bookingModel!.bookingStatus == "waiting" ||
                                            con.bookingModel!.bookingStatus == "done"
                                        ? InkWell(
                                            onTap: () {
                                              Get.to(const BookDetailsScreen());
                                            },
                                            child: BookButton(
                                              color: AppColors.red,
                                              title: "bookingDetails".tr,
                                              icon: Icons.check_box,
                                            ))
                                        : const SizedBox(),
                                    InkWell(
                                        onTap: () {
                                          if (controller.libAvailable == true) {
                                            Get.to(const StudyRoomsScreen());
                                          } else {
                                            AwesomeDialog(
                                              padding: const EdgeInsets.all(10),
                                              context: context,
                                              dialogType: DialogType.warning,
                                              animType: AnimType.rightSlide,
                                              title: "libraryisClosed".tr,
                                              titleTextStyle: const TextStyle(
                                                  color: AppColors.mainColor,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                              desc: "youCannotBookNow".tr,
                                              btnOkColor: AppColors.mainColor,
                                              btnOkText: 'ok'.tr,
                                              btnOkOnPress: () {
                                                Get.back();
                                              },
                                            ).show();
                                          }
                                        },
                                        child: BookButton(
                                          color: controller.libAvailable == true
                                              ? AppColors.mainColor
                                              : AppColors.grey,
                                          title: "bookASeat".tr,
                                          icon: Icons.chair_alt,
                                        )),
                                  ],
                                ),
                              );
                            }),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.05),
                          child: Container(
                            height: Get.height * 0.42,
                            decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomTitle(
                                        title: "upcomingNews".tr,
                                        color: AppColors.lightOrange,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Get.to(const EventScreen());
                                          },
                                          child: Text(
                                            "showMore".tr,
                                            style: const TextStyle(
                                              color: AppColors.mainColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )),
                                    ],
                                  ),
                                  Row(children: [
                                    Expanded(
                                        child: SizedBox(
                                            height: Get.height * 0.32,
                                            child: GetBuilder<EventViewModel>(
                                              init: EventViewModel(),
                                              builder: (event) =>
                                                  ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, index) =>
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: InkWell(
                                                            onTap: () {
                                                              launch(
                                                                  event.events[
                                                                          index]
                                                                      ["pdf"]);
                                                            },
                                                            child: EventWidget(
                                                              eventData:
                                                                  event.events[
                                                                      index],
                                                            ))),
                                                itemCount: event.events.length,
                                              ),
                                            )))
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.05),
                          child: Container(
                            height: Get.height * 0.42,
                            decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomTitle(
                                        title: "librarySections".tr,
                                        color: AppColors.lightOrange,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                            height: Get.height * 0.32,
                                            child: GetBuilder<SectionViewModel>(
                                              init: SectionViewModel(),
                                              builder: (con) {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          child: InkWell(
                                                              onTap: () async {
                                                                Get.to(
                                                                    SectionScreen(
                                                                  sectionData:
                                                                      con.sections[
                                                                          index],
                                                                ));
                                                              },
                                                              child:
                                                                  SectionWidget(
                                                                sectionData:
                                                                    con.sections[
                                                                        index],
                                                              )),
                                                        ),
                                                    itemCount:
                                                        con.sections.length);
                                              },
                                            )),
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
                  ),
                ),
              ));
        });
  }
}
