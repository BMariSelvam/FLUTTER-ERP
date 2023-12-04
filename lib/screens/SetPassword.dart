import 'package:erp/Helper/Controllers.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/Custom_TextField.dart';
import '../Helper/appRoute.dart';
import '../Helper/assets.dart';
import '../Helper/colors.dart';
import '../Helper/fonts.dart';

class SetPassword extends StatefulWidget {
  const SetPassword({Key? key}) : super(key: key);

  @override
  State<SetPassword> createState() => _SetPasswordState();
}

class _SetPasswordState extends State<SetPassword> {
  late Controllers controller;
  bool confirmPasswordVisible = false;
  bool newPasswordVisible = false;

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
              Assets.reset,
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
                "Set Password",
                style: TextStyle(
                  fontFamily: MyFont.myFont2,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 25),
            child: Text(
              "Enter password for your Account",
              style: TextStyle(
                fontFamily: MyFont.myFont2,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: MyColors.black,
              ),
            ),
          ),
          CustomTextField(
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.resetPasswordController,
            obscureText: newPasswordVisible ? false : true,
            hintText: "Enter New Password",
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    newPasswordVisible = !newPasswordVisible;
                  });
                },
                icon: Image.asset(
                  newPasswordVisible ? IconAssets.eye : IconAssets.eyeClosed,
                  scale: 1.8,
                )),
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter New Password';
              }
              return null;
            },
          ),
          CustomTextField(
            obscureText: confirmPasswordVisible ? false : true,
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.comformPasswordController,
            hintText: "Enter Confirm Password",
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    confirmPasswordVisible = !confirmPasswordVisible;
                  });
                },
                icon: Image.asset(
                  confirmPasswordVisible
                      ? IconAssets.eye
                      : IconAssets.eyeClosed,
                  scale: 1.8,
                )),
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Comfirm Password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 18,
          ),
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
              onTap: () => Get.toNamed(AppRoutes.contactInformation),
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
                    color: MyColors.mainTheme),
                child: Text(
                  "Confirm",
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
        const SizedBox(
          height: 18,
        )
      ],
    );
  }
}
