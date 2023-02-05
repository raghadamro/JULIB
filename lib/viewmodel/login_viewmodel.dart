import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController uniEmail = TextEditingController();
  TextEditingController password = TextEditingController();

  final CarouselController controller = CarouselController();
  int current = 0;
  List<String> images = [
    'assets/images/libphoto1.png',
    'assets/images/libphoto2.jfif',
    'assets/images/libphoto3.jfif',
    'assets/images/libphoto4.jfif',
    'assets/images/libphoto5.jfif',
    'assets/images/libphoto6.jfif',
    'assets/images/libphoto7.jfif',
  ];
}
