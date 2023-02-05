import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/view/wigdets/custom_appbar.dart';
import 'package:julib/viewmodel/event_viewmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventViewModel>(
        init: EventViewModel(),
        builder: ((controller) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: Get.size * 0.07,
                child: CustomAppBar(
                  title: "upcomingNews".tr,
                )),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * 0.02, horizontal: Get.width * 0.04),
              child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    launch(controller.events[index]["pdf"]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          height: Get.height * 0.15,
                          width: Get.width * 0.9,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(1, 2),
                                  blurRadius: 3,
                                  spreadRadius: 2,
                                  color: Colors.grey.withOpacity(0.1),
                                )
                              ]),
                          child: Row(
                            children: [
                              Container(
                                width: Get.width * 0.25,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      controller.events[index]["image"]),
                                  fit: BoxFit.contain,
                                  scale: 15,
                                )),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: Get.width * 0.03),
                                  child: Text(
                                    controller.events[index]["titleAR"],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: Get.height * 0.02,
                ),
                itemCount: controller.events.length,
              ),
            ),
          );
        }));
  }
}
