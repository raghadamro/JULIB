import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EventViewModel extends GetxController {
  List events = [];
  CollectionReference eventRef =
      FirebaseFirestore.instance.collection("Events");

  getEventsData() async {
    var response = await eventRef.get();
    response.docs.forEach((element) {
      events.add(element.data());
      update();
    });
  }

  @override
  void onInit() {
    getEventsData();
    super.onInit();
  }
}
