import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BotViewModel extends GetxController{
  late DialogFlowtter dialogFlowtter;
  bool isServices=false;
 int selectedIndex =0;
  final TextEditingController messageController = TextEditingController();

  List<Map<String, dynamic>> messages = [];
  List<String> servicesAR =[
    'اتصل بنا',
    'مواعيد المكتبة',
    'بوابات الجامعة',
    'القاعات',
  ];
  List<String> servicesEN =[
    'Call Us',
    "Library's Hours",
    'Gates',
    'Study Rooms',
  ];
  List<String> doorsAR =[
    'الرئيسة',
    'العلوم',
    'الزراعة',
    'الشمالية',
    'العلمية',
    'الهندسة',
    'الجنوبية',
    'الطب',
  ]; List<String> doorsEN =[
    'Main',
    'Science',
    'Agriculture',
    'North',
    'Scientific',
    'Engineering',
    'South',
    'Medicine',
  ];
  List<String> studyRoomsAR =[
    'البخاري',
    'ابن خلدون',
    'الهاشمية',
    'المراجع',
    'بيت المقدس',
    'ناصر الدين بن اسد',
  ];
  List<String> studyRoomsEN =[
    'Al-Bukhari',
    'Ibn Khaldun',
    'Hashemite',
    'References',
    'Bayt Al-Maqdis',
    'Nasser Eddin Al-Assad',
  ];


  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else
      {
        addMessage(Message(text: DialogText(text: [text])), true);
        update();

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
        addMessage(response.message!);
        update();
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {

    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
  @override
  void onInit() {
      DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.onInit();
  }
}
