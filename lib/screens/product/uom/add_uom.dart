import 'package:erp/Helper/size.dart';
import 'package:erp/Model/RequestModel/CreateUomModel.dart';
import 'package:erp/screens/product/uom/add_uom_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../../../widgets/Custom_TextField_2.dart';

class AddUom extends StatefulWidget {
  const AddUom({Key? key}) : super(key: key);

  @override
  State<AddUom> createState() => _AddUomState();
}

class _AddUomState extends State<AddUom> {
  late AddUomController addUomController;

  @override
  void initState() {
    super.initState();
    addUomController = Get.put(AddUomController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addUomController.addUomKey,
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
                        'UOM',
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
                          value: addUomController.selected,
                          onToggle: (val) {
                            setState(() {
                              addUomController.selected = val;
                            });
                          })
                    ],
                  ),
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: InputBorder.none,
                  controller: addUomController.codeController,
                  keyboardType: TextInputType.text,
                  labelText: "Code",
                  // hintText: 'Lays Chips',
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addUomController.nameController,
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please Enter the Name';
                    }
                    return null;
                  },
                  labelText: "Name",
                  // hintText: '002GG3',
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                // CustomTextField2(
                //   inputBorder: const OutlineInputBorder(),
                //   controller: percentageController,
                //   keyboardType: TextInputType.number,
                //   labelText: "Unit of measurement",
                //   hintText: "Banana Chips",
                //   suffixIcon: const Icon(Icons.arrow_drop_down_sharp,
                //       color: MyColors.greyIcon),
                // ),
                // CustomTextField2(
                //   inputBorder: const OutlineInputBorder(),
                //   controller: taxTypeController,
                //   keyboardType: TextInputType.name,
                //   labelText: "Category",
                //   hintText: "Snacks",
                //   suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                // ),
                // CustomTextField2(
                //   inputBorder: const OutlineInputBorder(),
                //   controller: taxTypeController,
                //   keyboardType: TextInputType.name,
                //   labelText: "Sub Category",
                //   hintText: "Chips",
                //   suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                // ),
                SizedBox(height: height(context) / 4.2),
                InkWell(
                  onTap: () {
                    if (addUomController.addUomKey.currentState!.validate()) {
                      addUomController.addUomKey.currentState!.save();
                      addUomController.createUomModel = CreateUomModel(
                        orgId: 1,
                        code: '',
                        name: addUomController.nameController.text,
                        displayOrder: 0,
                        isActive: addUomController.selected,
                        createdBy: 'admin',
                        createdOn: addUomController.currentTimeAndDate,
                        changedBy: 'admin',
                        changedOn: addUomController.currentTimeAndDate,
                      );
                      addUomController.onSaved();
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
