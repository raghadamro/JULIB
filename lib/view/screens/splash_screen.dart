import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewmodel/splash_viewmodel.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashViewModel>(//state managment
        init: SplashViewModel(),
        builder: ((controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/logo.png"),
                scale: 5,
              )),
            ),
          );
        }));
  }
}
