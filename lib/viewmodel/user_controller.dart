import 'package:get/get.dart';

import '../helper/auth_helper.dart';

UserController userController = Get.put(UserController());

class UserController extends GetxController {
  RxString token = RxString('');

  RxString usernameAR = RxString('');
  RxString usernameEN = RxString('');
  RxString userId = RxString('');
  RxString status = RxString('');

  RxString studyRoomName = RxString('');
  RxString tabelNum = RxString('');
  RxString seatNum = RxString('');

  RxString roomIndex = RxString('');
  RxString tabelIndex = RxString('');
  RxString seatIndex = RxString('');
  RxString bookingTime = RxString('');
  RxString validTime = RxString('');

  setToken(String t) {
    token.value = t;
  }

  setUserNameAR(String t) {
    usernameAR.value = t;
  }

  setUserNameEN(String t) {
    usernameEN.value = t;
  }

  setUserId(String t) {
    userId.value = t;
  }

  setBookingStatus(String t) {
    status.value = t;
  }
  setStudyRoomName(String t) {
    studyRoomName.value = t;
  }
  setTabelNum(String t) {
    tabelNum.value = t;
  } setSeatNum(String t) {
    seatNum.value = t;
  }

  setRoomIndex(String t) {
    roomIndex.value = t;
  }

  setTabelIndex(String t) {
    tabelIndex.value = t;
  }

  setSeatIndex(String t) {
    seatIndex.value = t;
  }

  setBookingTime(String t) {
    bookingTime.value = t;
  }

  setValidTime(String t) {
    validTime.value = t;
  }

  @override
  void onInit() async {
    token.value = await AuthHelper().getToken() ?? "";
    usernameAR.value = await AuthHelper().getUserNameAR() ?? "";
    usernameEN.value = await AuthHelper().getUserNameEN() ?? "";
    userId.value = await AuthHelper().getUserId() ?? "";

    status.value = await AuthHelper().getBookingStatus() ?? "";
    studyRoomName.value =await AuthHelper().getStudyRoomName()??"";
    tabelNum.value =await AuthHelper().getTabelNum()??"";
    seatNum.value =await AuthHelper().getSeatNum()??"";

    roomIndex.value = await AuthHelper().getRoomIndex() ?? "";
    tabelIndex.value = await AuthHelper().getTabelIndex() ?? "";
    seatIndex.value = await AuthHelper().getSeatIndex() ?? "";

    bookingTime.value = await AuthHelper().getBookingTime() ?? "";
    validTime.value = await AuthHelper().getValidTime() ?? "";
    super.onInit();
  }
}
