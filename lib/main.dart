import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:julib/view/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/localization/translation.dart';

String languageCode = "ar";

void main() async {
  //start firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //end firebase
  SharedPreferences shared = await SharedPreferences.getInstance();
  languageCode = shared.getString("language_code") ?? "ar";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ar');
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale:  Locale(languageCode),
      translations: Translation(),
      theme: ThemeData(
        fontFamily: 'NotoKufiArabic',
      ),
      home:  const SplashScreen(),
    );
  }
}
