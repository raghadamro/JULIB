import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/main.dart';
import 'package:julib/viewmodel/login_viewmodel.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginViewModel>(
        init: LoginViewModel(),
        builder: ((controller) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider.builder(
                carouselController: controller.controller,
                options: CarouselOptions(
                    aspectRatio: 1,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    height: Get.height * 0.35,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.easeInCubic,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      controller.current = index;
                      controller.update();
                    }),
                itemCount: controller.images.length,
                itemBuilder:
                    (BuildContext context, int bannerIndex, int realIndex) {
                  return GestureDetector(
                      onTap: () async {},
                      child: Container(
                        height: Get.height * 0.35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(controller.images[bannerIndex]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: languageCode == "ar"
                              ? const BorderRadius.only(
                                  bottomLeft: Radius.circular(80),
                                )
                              : const BorderRadius.only(
                                  bottomRight: Radius.circular(80),
                                ),
                        ),
                        child: Container(
                            height: Get.height * 0.35,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: languageCode == "ar"
                                  ? const BorderRadius.only(
                                      bottomLeft: Radius.circular(80),
                                    )
                                  : const BorderRadius.only(
                                      bottomRight: Radius.circular(80),
                                    ),
                            )),
                      ));
                },
              ),
            ],
          );
        }));
  }
}
