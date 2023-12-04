import 'dart:async';

import 'package:erp/Helper/appRoute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/assets.dart';
import '../Helper/colors.dart';
import '../Helper/custom_gradient.dart';
import '../Helper/fonts.dart';

class RegisteredSuccessScreen extends StatefulWidget {
  const RegisteredSuccessScreen({Key? key}) : super(key: key);

  @override
  State<RegisteredSuccessScreen> createState() =>
      _RegisteredSuccessScreenState();
}

class _RegisteredSuccessScreenState extends State<RegisteredSuccessScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => Get.offAndToNamed(AppRoutes.forgotPasswordScreen),
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
              buildBody(),
              // const Spacer(),
              // footerWidget(),
            ],
          ),
        ],
      ),
    );
  }

  buildBody() {
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
            CustomGradient(
              child: Text(
                "Registered Successfully..! ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: MyFont.myFont2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
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
          // onTap: () => Get.toNamed(AppRoutes.forgotPasswordScreen),
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
                  "Go to Home Page",
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
        const SizedBox(height: 18)
      ],
    );
  }
}
