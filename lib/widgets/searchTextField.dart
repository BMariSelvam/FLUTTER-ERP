// ignore_for_file: file_names

import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:flutter/material.dart';

class searchTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final bool obscureText = false;
  final InputBorder inputBorder;

  const searchTextField({
    super.key,
    this.validator,
    this.suffixIcon,
    this.labelText,
    this.keyboardType,
    required this.controller,
    obscureText = false,
    required this.inputBorder,
    this.hintText,
    this.onTap,
  });

  @override
  State<searchTextField> createState() => _searchTextFieldState();
}

class _searchTextFieldState extends State<searchTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: MyColors.greyIcon,
            )
          ]),
      child: TextFormField(
        onTap: widget.onTap,
        controller: widget.controller,
        validator: widget.validator,
        style: TextStyle(
          fontSize: 13,
          color: MyColors.black,
          fontFamily: MyFont.myFont,
          fontWeight: FontWeight.w900,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: MyFont.myFont,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: MyColors.greyText),
          hintText: widget.hintText,
          border: widget.inputBorder,
          contentPadding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 15),
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: MyColors.mainTheme,
            fontSize: 13,
            fontFamily: MyFont.myFont,
            fontWeight: FontWeight.w900,
          ),
        ),
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
      ),
    );
  }
}
