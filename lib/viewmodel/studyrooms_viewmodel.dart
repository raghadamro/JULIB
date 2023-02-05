import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:julib/model/booking_model.dart';
import '../helper/auth_helper.dart';
import '../model/studyroom_model.dart';

class StudyRoomsViewModel extends GetxController {
  StudyRoom? studyRoom;
  List<StudyRoom> studyRooms = [];

  BookingModel? bookingModel;

  // String? studyRoomName;
  // String? tabelNum;
  // String? seatNum;
  // String? bookingStatus;
  //
  // String? roomIndex;
  // String? tabelIndex;
  // String? seatIndex;
  //
  int? slectedSeatID;
  // String? bookingTime;
  // String? validTime;

  int? selectedRoomIndex;
  int? selectedTableIndex;
  int? selectedSeatIndex;


  bool bookingNow = false;
  bool loading = false;
  Map<dynamic, dynamic> mapData = {};

  setBookingData() async {
    String userUID = await AuthHelper().getToken() ?? "";
    await FirebaseFirestore.instance
        .collection('BookingData')
        .doc(userUID)
        .update({
      'studyRoomName': bookingModel!.studyRoomName,
      'tabelNum': bookingModel!.tabelNum,
      'seatNum': bookingModel!.seatNum,
      'status': bookingModel!.bookingStatus,

      'studyRoomIndex': bookingModel!.studyRoomIndex,
      'tabelIndex': bookingModel!.tabelIndex,
      'seatIndex': bookingModel!.seatIndex,

      'bookingTime': bookingModel!.bookingTime,
      'validTime': bookingModel!.validTime,
    });
  }

  Future<bool> fetchBookingData() async {
    String status = await AuthHelper().getBookingStatus() ?? "";
    String studyRoomName = await AuthHelper().getStudyRoomName() ?? "";
    String tabelNum = await AuthHelper().getTabelNum() ?? "";
    String seatNum = await AuthHelper().getSeatNum() ?? "";
    String studyRoomIndex = await AuthHelper().getRoomIndex() ?? "";
    String tabelIndex = await AuthHelper().getTabelIndex() ?? "";
    String seatIndex = await AuthHelper().getSeatIndex() ?? "";
    String bookingTime = await AuthHelper().getBookingTime() ?? "";
    String validTime = await AuthHelper().getValidTime() ?? "";

    bookingModel = BookingModel(
        studyRoomName: studyRoomName,
        seatNum: seatNum,
        tabelIndex: tabelIndex,
        tabelNum: tabelNum,
        studyRoomIndex: studyRoomIndex,
        seatIndex: seatIndex,
        bookingTime: bookingTime,
        validTime: validTime,
        bookingStatus: status,
    );

    update();
    return true;
  }

  fetchAllRooms() {
    FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL: "https://julib-2fd16-default-rtdb.firebaseio.com/")
        .ref("StudyRooms")
        .get()
        .then((value) {
      dynamic map = value.value;
      List<Object> mapData = List<Object>.from(map);
      studyRooms = studyRoomFromJson(
          json.encode(json.decode(json.encode(mapData.toList()))));
      update();
    });
  }

  @override
  void onInit() {
    fetchAllRooms();
    fetchBookingData();
    super.onInit();
  }
}
