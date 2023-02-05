import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final bool isPassword;
  final String hint;
  final Function(String?)? onSave;
  final FormFieldValidator<String>? validator;
  final TextInputType type;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.isPassword,
    required this.hint,
    required this.onSave,
    required this.validator,
    required this.type,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: TextFormField(
        obscureText: isPassword ? true : false,
        controller: controller,
        onSaved: onSave,
        validator: validator,
        keyboardType: type,
        cursorColor: AppColors.brawn,
        style: const TextStyle(color: AppColors.mainColor),
        decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.all(15.0),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.black26,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.0),
          ),
          fillColor: AppColors.grey,
        ),
      ),
    );
  }
}
