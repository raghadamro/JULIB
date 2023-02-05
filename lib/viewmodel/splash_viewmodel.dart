import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:julib/helper/helper_widget.dart';
import 'package:julib/view/screens/home_screen.dart';
import 'package:julib/view/screens/login_screen.dart';

import '../helper/auth_helper.dart';
import 'home_viewmodel.dart';
import 'studyrooms_viewmodel.dart';

class SplashViewModel extends GetxController {
  bool isLogin = false;
  int hour = int.parse(DateFormat("H").format(DateTime.now()));

  Future<bool> avaliabilty() async {
    switch (DateFormat("EEEE").format(DateTime.now())) {
      case "Friday":
        return false;
        break;
      case "Saturday":
        return hour >= 9 && hour < 15;
        break;
      default:
        return hour >= 9 && hour < 21;
    }
  }

  @override
  void onInit() async {
    isLogin = await AuthHelper().isLogin();
    await Future.delayed(const Duration(seconds: 4)).then((value) async {
      if (isLogin) {
        return Get.offAll(() => const HomeScreen());

        // Get.put(StudyRoomsViewModel());
        // Get.find<StudyRoomsViewModel>().fetchBookingData().then((value) {
        //   if(value){
        //   }
        // });

      } else {
        return Get.offAll(() => const LoginScreen());
      }
    });
    super.onInit();
  }
}
