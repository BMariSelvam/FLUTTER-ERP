import 'package:erp/screens/successfully_msg_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../Helper/appRoute.dart';
import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../../../widgets/Custom_TextField_2.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  bool selected = false;
  TextEditingController categoryCodeController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Image.asset(
              IconAssets.leftIcon,
              color: MyColors.white,
              scale: 1.3,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 25),
              child: Image.asset(
                IconAssets.search,
                scale: 1.8,
              ),
            )
          ],
          titleSpacing: -15,
          title: Text(
            "Product",
            style: TextStyle(
                decoration: TextDecoration.none,
                fontFamily: MyFont.myFont2,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.5,
                color: MyColors.white),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                MyColors.gradient1,
                MyColors.gradient2,
                MyColors.gradient3,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
          ),
        ),
        backgroundColor: MyColors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'category',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.heading354038),
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width * 0.45,),
                    FlutterSwitch(
                        width: 100,
                        activeText: 'Active',
                        activeColor: Colors.green,
                        activeTextColor: MyColors.white,
                        showOnOff: true,
                        inactiveText: 'Inactive',
                        inactiveTextColor: Colors.white70,
                        value: selected,
                        onToggle: (val) {
                          setState(() {
                            selected = val;
                          });
                        })
                  ],
                ),
              ),
              CustomTextField2(
                inputBorder: InputBorder.none,
                controller: categoryController,
                keyboardType: TextInputType.text,
                labelText: "Category",
                hintText: 'Chips',
                suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: categoryCodeController,
                keyboardType: TextInputType.datetime,
                labelText: "Category Code",
                hintText: '002GG3',
                suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: subCategoryController,
                keyboardType: TextInputType.number,
                labelText: "Sub Category",
                suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                hintText: "Banana Chips",
              ),
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: MyColors.greyText,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Image.asset(IconAssets.uploadIcon),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Click here to upload Photo/Video',
                        style: TextStyle(color: hexStringToColor('B4B4B4')),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () => Get.to(SuccessfullyMsgScreen(
                    name: 'Category Saved Successfully..!',
                    filename: Get.toNamed(AppRoutes.subCategoryList))),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  // height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [
                            MyColors.gradient1,
                            MyColors.gradient2,
                            MyColors.gradient3,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Save',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: MyFont.myFont2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: MyColors.white),
                    ),
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
}
