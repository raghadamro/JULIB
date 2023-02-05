import 'package:flutter/material.dart';
import 'package:julib/main.dart';

import '../../helper/app_colors.dart';

class JULibraryWidget extends StatelessWidget {
  const JULibraryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return languageCode == "en"
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "J U L I B ",
                style: TextStyle(
                  color: AppColors.brawn,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "R A R Y ",
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "R A R Y ",
                style: TextStyle(
                  color: AppColors.mainColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "J U L I B ",
                style: TextStyle(
                  color: AppColors.brawn,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          );
  }
}
