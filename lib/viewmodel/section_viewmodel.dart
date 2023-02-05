import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SectionViewModel extends GetxController {
  List sections = [];
  CollectionReference sectionRef =
      FirebaseFirestore.instance.collection("Sections");

  getSectionsData() async {
    var response = await sectionRef.get();
    response.docs.forEach((element) {
      sections.add(element.data());
    });
    update();
  }

  @override
  void onInit() {
    getSectionsData();
    super.onInit();
  }
}
