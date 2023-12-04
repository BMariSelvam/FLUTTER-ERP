import 'package:flutter/material.dart';

import '../Helper/colors.dart';
import '../Helper/fonts.dart';

class ProductTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final int? hight;
  final int? maxLength;
  final int? maxLines;

  final TextInputType? keyboardType;
  final InputBorder inputBorder;
  final bool obscureText = false;

  const ProductTextFormField({
    super.key,
    this.labelText,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.hintText,
    this.hight,
    this.maxLength,
    this.maxLines,
    this.keyboardType,
    required this.inputBorder,
  });

  @override
  State<ProductTextFormField> createState() => _ProductTextFormFieldState();
}

class _ProductTextFormFieldState extends State<ProductTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 65,
      margin: const EdgeInsets.only(left: 4, right: 4, bottom: 10),
      child: TextFormField(
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
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
              fontFamily: MyFont.myFont2,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: MyColors.greyText),
          hintText: widget.hintText,
          border: widget.inputBorder,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.greyText,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 232, 12, 12),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: MyColors.mainTheme,
            ),
          ),
          contentPadding:
              const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 3),
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: MyColors.mainTheme,
            fontSize: 13,
            fontFamily: MyFont.myFont2,
            fontWeight: FontWeight.w900,
          ),
        ),
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
      ),
    );
  }
}
