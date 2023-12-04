import 'dart:async';

import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/assets.dart';
import '../Helper/fonts.dart';

class SuccessfullyMsgScreen extends StatefulWidget {
  final String name;
  final Future<dynamic>? filename;

  const SuccessfullyMsgScreen({
    super.key,
    required this.name,
    required this.filename,
  });

  @override
  State<SuccessfullyMsgScreen> createState() => _SuccessfullyMsgScreenState();
}

class _SuccessfullyMsgScreenState extends State<SuccessfullyMsgScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Get.offAndToNamed(widget.filename.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }

  buildBody() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.white.withOpacity(0.2),
        padding: const EdgeInsets.only(top: 70),
        height: height(context),
        width: width(context),
        child: Column(children: [
          Image.asset(
            Assets.changedSuccess,
            fit: BoxFit.fill,
            scale: 1,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Text(
              widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: MyFont.myFont2,
                fontWeight: FontWeight.bold,
                color: MyColors.white,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 35),
          Image.asset(
            Assets.successGif,
            scale: 4,
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
