import 'package:erp/Helper/Controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Helper/appRoute.dart';
import '../Helper/assets.dart';
import '../Helper/colors.dart';
import '../Helper/custom_gradient.dart';
import '../Helper/fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Controllers controller = Get.put(Controllers());

  var category = ['Example1', 'Example2', 'Example3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildBody(),
          footerWidget(),
        ],
      ),
    );
  }

  buildBody() {
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
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 40),
              child: Image.asset(
                Assets.profile,
                fit: BoxFit.fill,
                scale: 1.8,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: CustomGradient(
                child: Text(
                  "Profile",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                "Enter your company details",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: MyColors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 18,
                    color: MyColors.black,
                    fontFamily: MyFont.myFont2),
                decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.zero,
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: Ink(
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [
                                    MyColors.gradient1,
                                    MyColors.gradient2,
                                    MyColors.gradient3,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 32,
                            width: MediaQuery.of(context).size.width / 3.5,
                            // padding: const EdgeInsets.symmetric(
                            //     vertical: 15, horizontal: 35),
                            child: Text(
                              'Attach File',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: MyColors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    hintText: 'Attach company profile',
                    hintStyle: TextStyle(
                        color: MyColors.black.withOpacity(0.5),
                        fontSize: 16,
                        fontFamily: MyFont.myFont2,
                        letterSpacing: 0.5),
                    filled: true,
                    fillColor: MyColors.greyIcon.withOpacity(0.3),
                    contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                          color: MyColors.greyIcon.withOpacity(0.6),
                          width: 1.8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                          color: MyColors.primaryCustom.withOpacity(0.6),
                          width: 1.8),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: TextFormField(
                style: TextStyle(
                    fontSize: 18,
                    color: MyColors.black,
                    fontFamily: MyFont.myFont2),
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: 'Enter a few words about your Company',
                    hintStyle: TextStyle(
                        color: MyColors.black.withOpacity(0.5),
                        fontSize: 16,
                        fontFamily: MyFont.myFont2,
                        letterSpacing: 0.5),
                    filled: true,
                    fillColor: MyColors.greyIcon.withOpacity(0.3),
                    contentPadding: const EdgeInsets.only(top: 10, left: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                          color: MyColors.greyIcon.withOpacity(0.6),
                          width: 1.8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                          color: MyColors.primaryCustom.withOpacity(0.6),
                          width: 1.8),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
              child: DropdownButtonFormField(
                menuMaxHeight: 100,
                items: category
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (l) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Email Address';
                  }
                  return null;
                },
                hint: Text(
                  'Business Category',
                  style: TextStyle(
                      fontFamily: MyFont.myFont2,
                      fontSize: 16,
                      color: MyColors.black.withOpacity(0.5)),
                ),
                icon: Image.asset(
                  IconAssets.downIcon,
                  scale: 1.3,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyColors.greyIcon.withOpacity(0.3),
                  hintStyle: TextStyle(
                      color: MyColors.black.withOpacity(0.5), fontSize: 16),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                          color: MyColors.greyIcon.withOpacity(0.6),
                          width: 1.8)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  footerWidget() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.registeredSuccessScreen),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, left: 50, right: 50),
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
                ),
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
            ],
          ),
        ),
        const SizedBox(height: 18)
      ],
    );
  }
}
