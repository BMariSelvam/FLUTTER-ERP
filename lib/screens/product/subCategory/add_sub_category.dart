import 'dart:io';

import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Model/GetAllCategory.dart';
import 'package:erp/Model/RequestModel/CreateSubCategoryModel.dart';
import 'package:erp/screens/product/category/category_list_controller.dart';
import 'package:erp/screens/product/subCategory/add_sub_category_controller.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:erp/widgets/search_dropdown_textfield2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class AddSubCategory extends StatefulWidget {
  const AddSubCategory({Key? key}) : super(key: key);

  @override
  State<AddSubCategory> createState() => _AddSubCategoryState();
}

class _AddSubCategoryState extends State<AddSubCategory> {
  late AddSubCategoryController addSubCategoryController;

  late CategoryListController listController;

  int? orgId;
  late File imageFile;

  @override
  void initState() {
    super.initState();
    addSubCategoryController = Get.put(AddSubCategoryController());
    listController = Get.put(CategoryListController());
    listController.categoryListGet();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addSubCategoryController.addSubCategoryKey,
      child: Scaffold(
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
                        'Sub category',
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
                          value: addSubCategoryController.selected,
                          onToggle: (val) {
                            setState(() {
                              addSubCategoryController.selected = val;
                            });
                          })
                    ],
                  ),
                ),
                CustomTextField2(
                  inputBorder: InputBorder.none,
                  controller: addSubCategoryController.codeController,
                  keyboardType: TextInputType.text,
                  labelText: "Code",
                  // hintText: 'Chips',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please Enter the Code";
                    }
                    return null;
                  },
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addSubCategoryController.descriptionController,
                  keyboardType: TextInputType.text,
                  labelText: "Description",
                  // hintText: '002GG3',
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Please Enter the Description";
                    }
                    return null;
                  },
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                // CustomTextField2(
                //   inputBorder: const OutlineInputBorder(),
                //   controller: ,
                //   keyboardType: TextInputType.number,
                //   labelText: "Select Category",
                //   suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                //   // hintText: "Banana Chips",
                // ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Obx(() {
                    return SearchDropdownTextField2<GetAllCategory>(
                        // filledColor: MyColors.greyIcon.withOpacity(0.3),
                        hintText: 'Select Category',
                        hintTextStyle: TextStyle(
                          fontFamily: MyFont.myFont2,
                          color: MyColors.black.withOpacity(0.5),
                        ),
                        textStyle: TextStyle(
                          fontFamily: MyFont.myFont2,
                          color: MyColors.black,
                        ),
                        suffixIcon: Icon(
                          Icons.expand_circle_down_outlined,
                          color: MyColors.black.withOpacity(0.4),
                        ),
                        inputBorder: const BorderSide(color: MyColors.greyIcon),
                        items: listController.getCategoryList.value,
                        color: Colors.black54,
                        selectedItem: listController.getAllCategory,
                        isValidator: true,
                        errorMessage: '*',
                        onAddPressed: () {
                          setState(() {
                            listController.category = "";
                            listController.getAllCategory = null;
                          });
                        },
                        onChanged: (value) async {
                          FocusScope.of(context).unfocus();
                          listController.getAllCategory = value;
                          listController.category = value.name;
                          setState(() {
                            listController.category = value.name.toString();
                            orgId = value.orgId;
                          });
                        });
                  }),
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
                          'Click here to upload Icon Image',
                          style: TextStyle(color: hexStringToColor('B4B4B4')),
                        )
                      ],
                    ),
                  ),
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
                          'Click here to upload Image',
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
                  onTap: () {
                    if (addSubCategoryController.addSubCategoryKey.currentState!
                        .validate()) {
                      addSubCategoryController.addSubCategoryKey.currentState!
                          .save();
                      addSubCategoryController.createSubCategoryModel =
                          CreateSubCategoryModel();
                    }
                  },
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
          )),
    );
  }
}
