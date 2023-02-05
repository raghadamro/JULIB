import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../viewmodel/user_controller.dart';

class AuthHelper {
  final storage = const FlutterSecureStorage();

  Future<void> setToken(String token) async {
    userController.setToken(token);
    storage.write(key: "user_token", value: token);
    // print(token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'user_token');
  }

  Future<void> setUserNameAR(String usernameAR) async {
    userController.setUserNameAR(usernameAR);
    storage.write(key: "usernameAR", value: usernameAR);
  }

  Future<void> setUserNameEN(String usernameEN) async {
    userController.setUserNameEN(usernameEN);
    storage.write(key: "usernameEN", value: usernameEN);
  }

  Future<void> setUserId(String id) async {
    userController.setUserId(id);
    storage.write(key: "id", value: id);
  }

  Future<String?> getUserNameAR() async {
    return await storage.read(key: 'usernameAR');
  }

  Future<String?> getUserNameEN() async {
    return await storage.read(key: 'usernameEN');
  }

  Future<String?> getUserId() async {
    return await storage.read(key: 'id');
  }


  Future<void> setBookingStatus(String status) async {
    userController.setBookingStatus(status);
    storage.write(key: "status", value: status);
  }
  Future<void> setStudyRoomName(String studyRoomName) async {
    userController.setStudyRoomName(studyRoomName);
    storage.write(key: "studyRoomName", value: studyRoomName);
  }
  Future<void> setTabelNum(String tabelNum) async {
    userController.setTabelNum(tabelNum);
    storage.write(key: "tabelNum", value: tabelNum);
  } Future<void> setSeatNum(String seatNum) async {
    userController.setSeatNum(seatNum);
    storage.write(key: "seatNum", value: seatNum);
  }

  Future<void> setRoomIndex(String roomIndex) async {
    userController.setRoomIndex(roomIndex);
    storage.write(key: "roomIndex", value: roomIndex);
  }

  Future<void> setTabelIndex(String tabelIndex) async {
    userController.setTabelIndex(tabelIndex);
    storage.write(key: "tabelIndex", value: tabelIndex);
  }

  Future<void> setSeatIndex(String seatIndex) async {
    userController.setSeatIndex(seatIndex);
    storage.write(key: "seatIndex", value: seatIndex);
  }

  Future<void> setBookingTime(String bookingTime) async {
    userController.setBookingTime(bookingTime);
    storage.write(key: "bookingTime", value: bookingTime);
  }

  Future<void> setValidTime(String validTime) async {
    userController.setBookingTime(validTime);
    storage.write(key: "validTime", value: validTime);
  }

  Future<String?> getBookingStatus() async {
    return await storage.read(key: 'status');
  }
  Future<String?> getStudyRoomName() async {
    return await storage.read(key: 'studyRoomName');
  }
  Future<String?> getTabelNum() async {
    return await storage.read(key: 'tabelNum');
  }
  Future<String?> getSeatNum() async {
    return await storage.read(key: 'seatNum');
  }

  Future<String?> getRoomIndex() async {
    return await storage.read(key: 'roomIndex');
  }

  Future<String?> getTabelIndex() async {
    return await storage.read(key: 'tabelIndex');
  }

  Future<String?> getSeatIndex() async {
    return await storage.read(key: 'tabelIndex');
  }

  Future<String?> getBookingTime() async {
    return await storage.read(key: 'bookingTime');
  }

  Future<String?> getValidTime() async {
    return await storage.read(key: 'validTime');
  }

  Future<bool> isLogin() async {
    return await storage.containsKey(key: 'user_token');
  }

  void logout() async {
    await storage.delete(key: 'user_token');
    await storage.delete(key: 'usernameAR');
    await storage.delete(key: 'usernameEN');
    await storage.delete(key: 'id');
    await storage.delete(key: 'status');
    await storage.delete(key: 'tabelIndex');
    await storage.delete(key: 'roomIndex');
    await storage.delete(key: 'seatIndex');
    await storage.delete(key: 'bookingTime');
    await storage.delete(key: 'validTime');
  }

  void cancleBooking() async {
    await storage.delete(key: 'tabelIndex');
    await storage.delete(key: 'roomIndex');
    await storage.delete(key: 'seatIndex');
    await storage.delete(key: 'bookingTime');
    await storage.delete(key: 'validTime');
  }
}
