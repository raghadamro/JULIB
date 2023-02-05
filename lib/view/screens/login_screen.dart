import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/helper/helper_widget.dart';
import 'package:julib/view/screens/home_screen.dart';
import 'package:julib/view/wigdets/custom_textfield.dart';
import 'package:julib/view/wigdets/cutstom_button.dart';
import 'package:julib/view/wigdets/julibrary_widget.dart';
import 'package:julib/view/wigdets/login_header.dart';
import 'package:julib/viewmodel/home_viewmodel.dart';
import 'package:julib/viewmodel/login_viewmodel.dart';
import 'package:julib/viewmodel/studyrooms_viewmodel.dart';
import '../../helper/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginViewModel>(
        init: LoginViewModel(),
        builder: (controller) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const LoginHeader(),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.1,
                            vertical: Get.height * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "welcome".tr,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            Container(
                              height: Get.height * 0.01,
                              width: Get.width * 0.12,
                              decoration: BoxDecoration(
                                color: AppColors.lightOrange,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.1,
                                vertical: Get.height * 0.02),
                            child: Column(
                              children: [
                                Form(
                                  key: controller.formKey,
                                  child: Column(
                                    children: [
                                      CustomTextField(
                                        isPassword: false,
                                        hint: "uniEmail".tr,
                                        onSave: (value) {
                                          controller.uniEmail =
                                              TextEditingController(
                                                  text: value);
                                          controller.update();
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'pleaseEnterYourUniversityEmail'.tr;
                                          }
                                          return null;
                                        },
                                        type: TextInputType.emailAddress,
                                        controller: controller.uniEmail,
                                      ),
                                      CustomTextField(
                                        isPassword: true,
                                        hint: "password".tr,
                                        onSave: (value) {
                                          controller.password =
                                              TextEditingController(text: value);
                                          controller.update();
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'pleaseEnterYourPassword'.tr;
                                          }
                                          return null;
                                        },
                                        type: TextInputType.visiblePassword,
                                        controller: controller.password,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        Get.width * 0.02),
                                                child: InkWell(
                                                    onTap: () async {
                                                      if (controller.formKey.currentState!.validate()) {
                                                        HelperWidgets.loading();
                                                        try {
                                                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                                                            email: controller.uniEmail.text,
                                                            password: controller.password.text,
                                                          );
                                                          Get.back();
                                                          Get.put(HomeViewModel());
                                                          Get.find<HomeViewModel>().getUserData(controller.uniEmail.text)
                                                              .then((value) {
                                                            if (value) {
                                                              StudyRoomsViewModel().fetchBookingData()
                                                                  .then(
                                                                      (value) {
                                                                if (value) {
                                                                  Get.find<HomeViewModel>().fetchUserData();
                                                                  Get.find<HomeViewModel>()
                                                                      .update();
                                                                  Get.offAll(
                                                                      const HomeScreen());
                                                                }
                                                              });
                                                            }
                                                          });
                                                        } on FirebaseAuthException catch (e) {
                                                          if (e.code ==
                                                              'user-not-found') {
                                                            Get.back();
                                                            AwesomeDialog(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(20),
                                                              context: context,
                                                              dialogType:
                                                                  DialogType
                                                                      .warning,
                                                              animType: AnimType
                                                                  .rightSlide,
                                                              title:
                                                                  "CannotFindAccount"
                                                                      .tr,
                                                              titleTextStyle: const TextStyle(
                                                                  color: AppColors
                                                                      .mainColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              desc:
                                                                  " ${"findAnAccountWith".tr} ${controller.uniEmail.text} ${"pleaseEnterCorrectEmail".tr}",

                                                              btnOkColor:
                                                                  AppColors
                                                                      .mainColor,
                                                              btnOkText:
                                                                  'ok'.tr,
                                                              btnOkOnPress: () {
                                                                Get.back();
                                                              },
                                                            ).show();
                                                          } else if (e.code ==
                                                              'wrong-password') {
                                                            Get.back();
                                                            AwesomeDialog(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              context: context,
                                                              dialogType:
                                                                  DialogType
                                                                      .warning,
                                                              animType: AnimType
                                                                  .rightSlide,
                                                              title:
                                                                  "incorrectPassword"
                                                                      .tr,
                                                              titleTextStyle: const TextStyle(
                                                                  color: AppColors
                                                                      .mainColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              desc:
                                                                  "thePasswordouEnteredIsIncorrect"
                                                                      .tr,
                                                              btnOkColor:
                                                                  AppColors
                                                                      .mainColor,
                                                              btnOkText:
                                                                  'ok'.tr,
                                                              btnOkOnPress: () {
                                                                Get.back();
                                                              },
                                                            ).show();
                                                          }
                                                        } catch (e) {
                                                          print(e);
                                                        }
                                                      }
                                                    },
                                                    child: CustomButton(
                                                      name: "logIn".tr,
                                                      color:
                                                          AppColors.mainColor,
                                                    ))),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.02),
                                              child: InkWell(
                                                  onTap: () async {
                                                    controller.uniEmail.clear();
                                                    controller.password.clear();
                                                  },
                                                  child: CustomButton(
                                                    name: "clear".tr,
                                                    color: AppColors.red,
                                                  )),
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
                          Padding(
                            padding: EdgeInsets.only(top: Get.height * 0.08),
                            child: const JULibraryWidget(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
