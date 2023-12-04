// ignore_for_file: file_names

import 'package:erp/Helper/Controllers.dart';
import 'package:erp/Helper/Custom_TextField.dart';
import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late Controllers controller;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    controller = Get.put(Controllers());
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
              footerWidget(),
            ],
          ),
        ],
      ),
    );
  }

  Expanded bulidBody() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 50),
              child: Image.asset(
                Assets.forgot,
                fit: BoxFit.fill,
                scale: 2.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 25),
                child: CustomGradient(
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 25),
              child: Text(
                "Enter your Email ID to your password",
                style: TextStyle(
                  fontFamily: MyFont.myFont2,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: MyColors.black,
                ),
              ),
            ),
            CustomTextField(
              contentPadding:
                  const EdgeInsets.only(top: 8, left: 10, bottom: 8),
              inputBorder: InputBorder.none,
              controller: controller.emailController,
              hintText: "Enter Your Email",
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Email Address';
                }
                return null;
              },
              obscureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  Column footerWidget() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.otpVerifyScreen2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 50, right: 50),
                margin: const EdgeInsets.only(
                  top: 5,
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
                  "Send OTP",
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
