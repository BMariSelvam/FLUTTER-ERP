// ignore_for_file: file_names

import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:flutter/material.dart';

import 'custom_gradient.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final InputBorder inputBorder;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autoValidateMode;

  const CustomTextField({
    super.key,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.keyboardType,
    required this.controller,
    required this.inputBorder,
    this.hintText,
    this.contentPadding,
    this.autoValidateMode,
    this.obscureText,
    this.borderSide,
    this.borderRadius,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 25,
        right: 25,
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        autovalidateMode:
            AutovalidateMode.onUserInteraction ?? widget.autoValidateMode,
        style: TextStyle(
            fontSize: 17, color: MyColors.black, fontFamily: MyFont.myFont2),
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            contentPadding: widget.contentPadding,
            suffixIcon: widget.suffixIcon,
            suffixIconColor: MyColors.black.withOpacity(0.8),
            hintText: widget.hintText,
            hintStyle:
                TextStyle(color: MyColors.black.withOpacity(0.5), fontSize: 16),
            labelText: widget.labelText,
            labelStyle:
                TextStyle(color: MyColors.black.withOpacity(0.5), fontSize: 16),
            // filled: true,
            // fillColor: MyColors.greyIcon.withOpacity(0.3),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            )),
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText ?? false,
      ),
    );
  }
}
