import 'package:erp/Helper/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../Helper/appRoute.dart';
import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../../../widgets/Custom_TextField_2.dart';
import '../../successfully_msg_screen.dart';

class AddProductStock extends StatefulWidget {
  const AddProductStock({Key? key}) : super(key: key);

  @override
  State<AddProductStock> createState() => _AddProductStockState();
}

class _AddProductStockState extends State<AddProductStock> {
  bool selected = false;
  TextEditingController taxCodeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  TextEditingController taxTypeController = TextEditingController();

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
                      'Product Stock',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.heading354038),
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width * 0.33,),
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
                controller: taxCodeController,
                keyboardType: TextInputType.text,
                labelText: "Product Name",
                hintText: 'Lays Chips',
                suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: descriptionController,
                keyboardType: TextInputType.datetime,
                labelText: "Product Code",
                hintText: '002GG3',
                suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: percentageController,
                keyboardType: TextInputType.number,
                labelText: "Pcs per  box",
                hintText: "12",
                suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "Branch Code",
                hintText: "2332",
                suffixIcon: const Icon(Icons.arrow_drop_down_sharp,
                    color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "Box Qty",
                hintText: "230",
                suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "Pcs Qty",
                hintText: "265",
                suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "Lot qty ",
                hintText: "265",
                suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
              ),
              SizedBox(height: height(context) / 15),
              InkWell(
                onTap: () => Get.to(SuccessfullyMsgScreen(
                    name: 'Product Stock Saved Successfully..!',
                    filename: Get.toNamed(AppRoutes.purchaseOrderList))),
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
              const SizedBox(height: 18)
            ],
          ),
        ));
  }
}
