import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/app_colors.dart';
import '../../helper/auth_helper.dart';
import '../../helper/helper_widget.dart';
import '../../main.dart';
import '../screens/login_screen.dart';
import 'dart:async';

class HomeAppBar extends StatefulWidget {
  final String userNameAR;
  final String userNameEN;
  final String userId;
  final bool libAvailable;

  const HomeAppBar({
    super.key,
    required this.userNameAR,
    required this.userNameEN,
    required this.userId,
    required this.libAvailable,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  DateTime _time = DateTime.now();

  bool loading = false;
  late String dayAR;
  late String dayEN;
  late int hour;

  late Timer _timer;

  @override
  void initState() {
    dayAR = DateFormat.EEEE('ar').format(_time);
    dayEN = DateFormat("EEEE").format(_time);

    hour = int.parse(DateFormat("H").format(_time));

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _time = DateTime.now();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.5,
      width: double.infinity,
      decoration: BoxDecoration(
          color: widget.libAvailable ? AppColors.mainColor : AppColors.red,
          borderRadius: languageCode == "ar"
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                )
              : const BorderRadius.only(
                  bottomRight: Radius.circular(80),
                ),
          boxShadow: const [
            BoxShadow(
                offset: Offset(1, 1),
                spreadRadius: 2,
                blurRadius: 2,
                color: AppColors.grey)
          ]),
      child: Column(
        children: [
          AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () async {
                  final SharedPreferences shared =
                      await SharedPreferences.getInstance();
                  setState(() {
                    languageCode == "en"
                        ? languageCode = "ar"
                        : languageCode = "en";
                  });
                  shared.setString("language_code", languageCode);
                  Get.updateLocale(Locale(languageCode));
                },
                child: Text(
                  languageCode == "en" ? "ع" : "EN",
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 18,
                ),
                onPressed: () async {
                  AwesomeDialog(
                    padding: const EdgeInsets.all(20),
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.rightSlide,
                    title: "logOut".tr,
                    titleTextStyle: const TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    desc: "areYouSureYouWantToLogOut".tr,
                    btnCancelText: "Cancel".tr,
                    btnCancelColor: Colors.grey,
                    btnCancelOnPress: () {
                      Get.back();
                    },
                    btnOkColor: AppColors.red,
                    btnOkText: 'ok'.tr,
                    btnOkOnPress: () async {
                      HelperWidgets.loading();
                      try {
                        await FirebaseAuth.instance.signOut();
                        AuthHelper().logout();
                        Get.back();
                        Get.deleteAll();
                        Get.offAll(const LoginScreen());
                      } catch (e) {
                        print(e);
                      }
                    },
                  ).show();
                },
              )
            ],
            backgroundColor:
                widget.libAvailable ? AppColors.mainColor : AppColors.red,
            elevation: 0.0,
            title: const Text(
              "J U L I B R A R Y",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageCode == "ar" ? widget.userNameAR : widget.userNameEN,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  widget.userId,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Text(
                            languageCode == "ar" ? dayAR : dayEN,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                            ),
                          ),
                          Text(
                            DateFormat.jm('en').format(_time),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Row(
                          children: [
                            Text(
                              widget.libAvailable
                                  ? "availablelib".tr
                                  : "closed".tr,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                              ),
                            ),
                            Icon(
                              widget.libAvailable ? Icons.check : Icons.close,
                              color: Colors.white,
                              size: 18.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
