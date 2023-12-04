import 'dart:async';

import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/appRoute.dart';

class SuccessfullyScreen extends StatefulWidget {
  const SuccessfullyScreen({super.key});

  @override
  State<SuccessfullyScreen> createState() => _SuccessfullyScreenState();
}

class _SuccessfullyScreenState extends State<SuccessfullyScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Get.offAndToNamed(AppRoutes.loginScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Column(
            children: [
              bulidBody(),
              // const Spacer(),
              // footerWidget(),
            ],
          ),
        ],
      ),
    );
  }

  bulidBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: Image.asset(
                Assets.changedSuccess,
                fit: BoxFit.fill,
                scale: 1,
              ),
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                CustomGradient(
                  child: Text(
                    "Password Changed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                CustomGradient(
                  child: Text(
                    "Successfully..!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Image.asset(
              Assets.successGif,
              scale: 4,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  footerWidget() {
    return Column(
      children: [
        GestureDetector(
          // onTap: () => Get.toNamed(AppRoutes.loginScreen),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                  right: 20,
                  left: 20,
                ),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      MyColors.gradient1,
                      MyColors.gradient2,
                      MyColors.gradient3,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.mainTheme),
                child: Text(
                  "Go to Log In Page",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
                      color: MyColors.white),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 18,
        )
      ],
    );
  }
}
