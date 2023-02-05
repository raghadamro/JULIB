import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewModel extends GetxController {
  TextEditingController searchBox = TextEditingController();
  bool isChanged = false;
}
