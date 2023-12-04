import 'package:erp/Helper/Controllers.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/Custom_TextField.dart';
import '../Helper/appRoute.dart';
import '../Helper/assets.dart';
import '../Helper/colors.dart';

class ContactInformation extends StatefulWidget {
  const ContactInformation({Key? key}) : super(key: key);

  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  Controllers controller = Get.put(Controllers());

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
          SafeArea(
              child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 25, top: 15),
              child: Image.asset(
                IconAssets.backIcon,
                scale: 1.5,
              ),
            ),
          )),
          Container(
            padding: const EdgeInsets.only(top: 40),
            alignment: Alignment.center,
            child: Image.asset(
              Assets.contactinfo,
              fit: BoxFit.fill,
              scale: 1.2,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 30, left: 25),
              child: CustomGradient(
                child: Text(
                  'Contact Information',
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
              'Enter your contact details',
              style: TextStyle(
                fontFamily: MyFont.myFont2,
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: MyColors.black,
              ),
            ),
          ),
          CustomTextField(
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.companyName,
            hintText: "Name",
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Company Name';
              }
              return null;
            },
            obscureText: false,
          ),
          CustomTextField(
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.companyName,
            hintText: "Mobile No.",
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Company Name';
              }
              return null;
            },
            obscureText: false,
          ),
          CustomTextField(
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.companyName,
            hintText: "Email",
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Company Name';
              }
              return null;
            },
            obscureText: false,
          ),
          CustomTextField(
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.companyName,
            hintText: "Website",
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Company Name';
              }
              return null;
            },
            obscureText: false,
          ),
          CustomTextField(
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.companyName,
            hintText: "Facebook",
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Company Name';
              }
              return null;
            },
            obscureText: false,
          ),
          CustomTextField(
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.companyName,
            hintText: "Instagram",
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Company Name';
              }
              return null;
            },
            obscureText: false,
          ),
          CustomTextField(
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.companyName,
            hintText: "LinkedIn",
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Company Name';
              }
              return null;
            },
            obscureText: false,
          ),
          CustomTextField(
            contentPadding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
            inputBorder: InputBorder.none,
            controller: controller.companyName,
            hintText: "YouTube",
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter your Company Name';
              }
              return null;
            },
            obscureText: false,
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
              onTap: () => Get.toNamed(AppRoutes.profileScreen),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 50, right: 50),
                margin: const EdgeInsets.only(
                  top: 15,
                  bottom: 18,
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
                  "Next",
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
