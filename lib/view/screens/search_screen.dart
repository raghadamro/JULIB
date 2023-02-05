import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:julib/viewmodel/search_viewmodel.dart';

import '../../helper/app_colors.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
        init: SearchViewModel(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              centerTitle: true,
              titleSpacing: 0,
              title: SizedBox(
                height: 40.0,
                width: Get.width * 0.8,
                child: TextFormField(
                  onChanged: (str) {
                    str != ""
                        ? controller.isChanged = true
                        : controller.isChanged = false;
                    controller.update();
                  },
                  textInputAction: TextInputAction.search,
                  controller: controller.searchBox,
                  autofocus: true,
                  cursorColor: AppColors.brawn,
                  cursorHeight: 20.0,
                  decoration: InputDecoration(
                    suffixIcon: controller.isChanged
                        ? IconButton(
                            onPressed: () {
                              controller.searchBox.clear();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 25.0,
                              color: AppColors.grey,
                            ),
                          )
                        : null,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    hintText: "searchForABook".tr,
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    fillColor: Colors.white,
                  ),
                ),
              ),
              backgroundColor: AppColors.mainColor,
              elevation: 0.0,
            ),
            backgroundColor: Colors.white,
          );
        });
  }
}
