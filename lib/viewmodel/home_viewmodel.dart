import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:julib/viewmodel/section_viewmodel.dart';
import 'package:julib/viewmodel/studyrooms_viewmodel.dart';

import '../helper/auth_helper.dart';
import 'event_viewmodel.dart';

class HomeViewModel extends GetxController {
  late bool libAvailable;
  String userNameAR = '';
  String userNameEN = '';
  String userId = '';
  String userUID = '';

  int hour = int.parse(DateFormat("H").format(DateTime.now()));

  Future<bool> avaliabilty() async {
    switch (DateFormat("EEEE").format(DateTime.now())) {
      case "Friday":
        libAvailable = false;
        break;
      case "Saturday":
        hour >= 9 && hour < 15 ? libAvailable = true : libAvailable = false;
        break;
      default:
        hour >= 9 && hour < 21 ? libAvailable = true : libAvailable = true;
    }
    update();
    return libAvailable;
  }

  fetchUserData() async {
    update();
    userNameAR = await AuthHelper().getUserNameAR() ?? "";
    userNameEN = await AuthHelper().getUserNameEN() ?? "";
    userId = await AuthHelper().getUserId() ?? "";
    update();
  }

  Future<bool> getUserData(String email) async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection('users');
    await userRef.where("email", isEqualTo: email).get().then((value) {
      value.docs.forEach((element) async {
        AuthHelper().setToken(element.id);
        AuthHelper().setUserNameAR(element.get("usernameAR"));
        AuthHelper().setUserNameEN(element.get("usernameEN"));
        AuthHelper().setUserId(element.get("id"));
        update();
        await FirebaseFirestore.instance
            .collection('BookingData')
            .doc(element.id)
            .get()
            .then((value) {
          AuthHelper().setBookingStatus(value.get("status"));

          AuthHelper().setStudyRoomName(value.get("studyRoomName"));
          AuthHelper().setTabelNum(value.get("tabelNum"));
          AuthHelper().setSeatNum(value.get("seatNum"));

          AuthHelper().setRoomIndex("${value.get("studyRoomIndex")}");
          AuthHelper().setTabelIndex("${value.get("tabelIndex")}");
          AuthHelper().setSeatIndex("${value.get("seatIndex")}");

          AuthHelper().setBookingTime("${value.get("bookingTime")}");
          AuthHelper().setValidTime("${value.get("validTime")}");
          update();
        });
      });
    });
    update();
    return true;
  }

  @override
  void onInit() {
    avaliabilty();
    fetchUserData();
    StudyRoomsViewModel().fetchBookingData();
    SectionViewModel().getSectionsData();
    EventViewModel().getEventsData();
    super.onInit();
  }
}
