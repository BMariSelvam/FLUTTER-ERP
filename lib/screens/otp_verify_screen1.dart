import 'package:erp/Helper/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../Helper/appRoute.dart';
import '../Helper/assets.dart';
import '../Helper/colors.dart';
import '../Helper/custom_gradient.dart';
import '../Helper/fonts.dart';

class OtpVerifyScreen1 extends StatefulWidget {
  const OtpVerifyScreen1({Key? key}) : super(key: key);

  @override
  State<OtpVerifyScreen1> createState() => _OtpVerifyScreen1State();
}

class _OtpVerifyScreen1State extends State<OtpVerifyScreen1> {
  String? otp;
  final TextEditingController otpController = TextEditingController();
  final defaultTheme = PinTheme(
      height: 50,
      width: 45,
      textStyle: TextStyle(
        fontFamily: MyFont.myFont2,
        fontSize: 20,
        color: MyColors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: MyColors
            .containerEBEBEB, /*border: Border.all(color: MyColors.mainTheme)*/
      ));

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
            padding: const EdgeInsets.only(top: 100),
            alignment: Alignment.center,
            child: Image.asset(
              Assets.otpImg,
              fit: BoxFit.fill,
              scale: 1.5,
            ),
          ),
          const SizedBox(height: 15),
          Padding(
              padding: const EdgeInsets.only(top: 30, left: 25),
              child: CustomGradient(
                child: Text(
                  'OTP Verification',
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
              'An authentication code has been send to '
              'manivannan****@gmail.com',
              style: TextStyle(
                fontFamily: MyFont.myFont2,
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: MyColors.black,
              ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SizedBox(
              width: width(context) / 0.5,
              child: Pinput(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                controller: otpController,
                length: 6,
                keyboardType: TextInputType.number,
                enabled: true,
                cursor: const SizedBox(height: 0),
                defaultPinTheme: defaultTheme,
                focusedPinTheme: defaultTheme.copyWith(
                    decoration: BoxDecoration(
                  color: MyColors.containerEBEBEB,
                  borderRadius: BorderRadius.circular(10.0),
                )),
                onChanged: (pin) {},
                onCompleted: (pin) {
                  otp = pin;
                },
              ),
            ),
          ),
          const SizedBox(
            height: 18,
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
              onTap: () => Get.toNamed(AppRoutes.setPassword),
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
                ),
                child: Text(
                  "Verify",
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
        GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Resend OTP in ",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: MyColors.black),
              ),
              CustomGradient(
                child: Text(
                  '18 Seconds',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 22,
        ),
      ],
    );
  }
}
