import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/RequestModel/CreateTaxModel.dart';
import 'package:erp/screens/masters/tax/add_tax_controller.dart';
import 'package:erp/screens/successfully_msg_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../../../widgets/Custom_TextField_2.dart';

class AddTax extends StatefulWidget {
  const AddTax({Key? key}) : super(key: key);

  @override
  State<AddTax> createState() => _AddTaxState();
}

class _AddTaxState extends State<AddTax> {
  late AddTaxController addTaxController;

  @override
  void initState() {
    super.initState();
    addTaxController = Get.put(AddTaxController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addTaxController.addTaxKey,
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
              "Master",
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
                        'Tax',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            color: MyColors.heading354038),
                      ),
                      // SizedBox(width: MediaQuery.of(context).size.width * 0.59,),
                      FlutterSwitch(
                          width: 100,
                          activeText: 'Active',
                          activeColor: Colors.green,
                          activeTextColor: MyColors.white,
                          showOnOff: true,
                          inactiveText: 'Inactive',
                          inactiveTextColor: Colors.white70,
                          value: addTaxController.selected,
                          onToggle: (val) {
                            setState(() {
                              addTaxController.selected = val;
                            });
                          })
                    ],
                  ),
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: InputBorder.none,
                  controller: addTaxController.taxCodeController,
                  keyboardType: TextInputType.text,
                  labelText: "Tax Code",
                  // hintText: 'Auto-Generated',
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addTaxController.descriptionController,
                  keyboardType: TextInputType.text,
                  labelText: "Description",
                  // hintText: 'Mohan Kumar',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the Description';
                    }
                    return null;
                  },
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addTaxController.percentageController,
                  keyboardType: TextInputType.number,
                  labelText: "Percentage",
                  // hintText: "20%",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the Percentage';
                    }
                    return null;
                  },
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                SizedBox(
                  // height: 50,
                  child: DropdownButtonFormField(
                    padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
                    style: TextStyle(
                        color: MyColors.black,
                        fontSize: 13,
                        fontFamily: MyFont.myFont2),
                    items: addTaxController.taxTypes
                        .map((e) => DropdownMenuItem(
                            value: e.name, child: Text(e.name)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value == "Inclusive") {
                          addTaxController.taxType = "I";
                        } else if (value == "Exclusive") {
                          addTaxController.taxType = "E";
                        } else {
                          addTaxController.taxType = "Z";
                        }
                      });
                      print("addTaxController.taxType");
                      print(addTaxController.taxType);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select Tax Type';
                      }
                      return null;
                    },
                    hint: Text(
                      'Select Tax Type',
                      style: TextStyle(
                          fontFamily: MyFont.myFont2,
                          fontSize: 13,
                          color: MyColors.black.withOpacity(0.5)),
                    ),
                    icon: Image.asset(
                      IconAssets.downIcon,
                      scale: 1.6,
                      color: MyColors.greyText,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Tax Type',
                      labelStyle: TextStyle(
                          color: MyColors.greyText,
                          fontSize: 13,
                          fontFamily: MyFont.myFont2),
                      hintStyle: TextStyle(
                          color: MyColors.greyText,
                          fontSize: 13,
                          fontFamily: MyFont.myFont2),
                      contentPadding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              const BorderSide(color: MyColors.mainTheme)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(color: MyColors.red)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide:
                              const BorderSide(color: MyColors.greyText)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(color: MyColors.red)),
                    ),
                  ),
                ),
                SizedBox(height: height(context) / 4.2),
                InkWell(
                  onTap: () {
                    if (addTaxController.addTaxKey.currentState!.validate()) {
                      addTaxController.addTaxKey.currentState?.save();
                      addTaxController.createTaxModel = CreateTaxModel(
                        orgId: 1,
                        taxCode: 0,
                        taxName: addTaxController.descriptionController.text,
                        taxPercentage: int.parse(
                            addTaxController.percentageController.text),
                        taxType: addTaxController.taxType,
                        isActive: addTaxController.selected,
                        createdBy: 'admin',
                        createdOn: addTaxController.currentTimeandDate,
                        changedBy: "admin",
                        changedOn: addTaxController.currentTimeandDate,
                      );
                      addTaxController.onSaved();
                      Get.to(SuccessfullyMsgScreen(
                          name: 'Tax Saved Successfully..!',
                          filename: Get.toNamed(AppRoutes.taxList)));
                    } else {
                      print('Fields are empty');
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
