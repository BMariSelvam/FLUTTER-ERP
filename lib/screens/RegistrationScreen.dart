import 'package:erp/Helper/Controllers.dart';
import 'package:erp/Helper/Custom_TextField.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/appRoute.dart';
import '../Helper/assets.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late Controllers controller = Get.put(Controllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [buildBody(), footerWidget()],
      ),
    );
  }

  Expanded buildBody() {
    return Expanded(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              Assets.registraton,
              fit: BoxFit.fill,
              scale: 1.1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: CustomGradient(
                child: Text(
              'Registration',
              style: TextStyle(
                fontFamily: MyFont.myFont2,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 5.0, right: 25.0),
            child: Text(
                'Let’s get started with creating your Account and '
                'Company information',
                style: TextStyle(
                  fontFamily: MyFont.myFont2,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: MyColors.black,
                )),
          ),
          CustomTextField(
            obscureText: false,
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.companyName,
            hintText: "Company Name",
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Company Name';
              }
              return null;
            },
          ),
          CustomTextField(
            obscureText: false,
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.emailController,
            hintText: "Reg No.",
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Reg No.';
              }
              return null;
            },
          ),
          CustomTextField(
            obscureText: false,
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.emailController,
            hintText: "Email",
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    ));
  }

  Column footerWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.otpVerifyScreen1),
              child: Container(
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
                    color: MyColors.primaryCustom),
                child: Text(
                  "Validate",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
                      color: MyColors.white),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an Account ? ",
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: MyFont.myFont2,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: MyColors.black),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.loginScreen),
              child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [
                            MyColors.gradient1,
                            MyColors.gradient2,
                            MyColors.gradient3,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(30),
                      color: MyColors.mainTheme),
                  padding: const EdgeInsets.only(
                      top: 4, bottom: 4, right: 15, left: 15),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont2,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 0.5,
                        color: MyColors.white),
                  )),
            )
          ],
        ),
        const SizedBox(
          height: 18,
        )
      ],
    );
  }
}
