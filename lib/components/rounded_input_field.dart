import 'package:flutter/material.dart';

import '../consts.dart';



class RoundedInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
 final TextInputType textInputType;
  const RoundedInputField({
    required this.icon,
    required this.hintText,
    required this.controller, required this.textInputType,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: kLightPrimary,
      ),
      width: MediaQuery.of(context).size.width * .8,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        cursorColor: kPrimary,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
            color: kPrimary,
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: kPrimary),
        ),
      ),
    );
  }
}
