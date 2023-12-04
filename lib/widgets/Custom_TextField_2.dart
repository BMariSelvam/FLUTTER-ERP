// ignore_for_file: file_names

import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField2 extends StatefulWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final String? labelText;
  final String? hintText;
  final int? height;
  final int? maxLength;
  final int? maxLines;
  final bool? readOnly;
  final bool? filled;
  final Color? filledColor;
  final TextInputType? keyboardType;
  final bool obscureText = false;
  final InputBorder? inputBorder;
  final bool? enabled;
  final Function()? onTap;
  final Function(String)? onChanged;
  final void Function(PointerDownEvent)? onTapOutside;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField2(
      {super.key,
      this.validator,
      this.suffixIcon,
      this.labelText,
      this.keyboardType,
      required this.controller,
      obscureText = false,
      this.inputBorder,
      this.hintText,
      this.height,
      this.maxLength,
      this.maxLines,
      this.readOnly,
      this.enabled,
      this.onTap,
      this.onChanged,
      this.filled,
      this.filledColor,
      this.inputFormatters,
      this.contentPadding,
      this.onTapOutside});

  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        onTapOutside: widget.onTapOutside,
        inputFormatters: widget.inputFormatters,
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        readOnly: widget.readOnly ?? false,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines ?? 1,
        controller: widget.controller,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
          filled: widget.filled,
          fillColor: widget.filledColor,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
          suffixIcon: widget.suffixIcon,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            color: MyColors.greyText,
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
