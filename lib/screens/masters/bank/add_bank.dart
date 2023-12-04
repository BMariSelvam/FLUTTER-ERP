import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/RequestModel/CreateBankModel.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import 'add_bank_controller.dart';

class AddBank extends StatefulWidget {
  const AddBank({Key? key}) : super(key: key);

  @override
  State<AddBank> createState() => _AddBankState();
}

class _AddBankState extends State<AddBank> {
  late AddBankController addBankController;

  @override
  void initState() {
    super.initState();
    addBankController = Get.put(AddBankController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addBankController.addBankKey,
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
                        'Bank',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            color: MyColors.heading354038),
                      ),
                      // SizedBox(width: MediaQuery.of(context).size.width * 0.56,),
                      FlutterSwitch(
                          width: 100,
                          activeText: 'Active',
                          activeColor: Colors.green,
                          activeTextColor: MyColors.white,
                          showOnOff: true,
                          inactiveText: 'Inactive',
                          inactiveTextColor: Colors.white70,
                          value: addBankController.selected,
                          onToggle: (val) {
                            setState(() {
                              addBankController.selected = val;
                            });
                          })
                    ],
                  ),
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: InputBorder.none,
                  controller: addBankController.codeController,
                  keyboardType: TextInputType.text,
                  labelText: "Code",
                  // hintText: 'ks2564',
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the Description';
                    }
                    return null;
                  },
                  controller: addBankController.nameController,
                  keyboardType: TextInputType.text,
                  labelText: "Description",
                  // hintText: 'Description One',
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                SizedBox(height: height(context) / 2.5),
                InkWell(
                  onTap: () {
                    if (addBankController.addBankKey.currentState!.validate()) {
                      addBankController.addBankKey.currentState!.save();
                      addBankController.createBankModel = CreateBankModel(
                        orgId: 1,
                        code: '',
                        name: addBankController.nameController.text,
                        isActive: addBankController.selected,
                        createdBy: 'admin',
                        createdOn: addBankController.currentTimeAndDate,
                        changedBy: 'admin',
                        changedOn: addBankController.currentTimeAndDate,
                      );
                      addBankController.onSaved();
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
