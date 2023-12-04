import 'package:erp/Helper/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../../../widgets/Custom_TextField_2.dart';

class AddGoodsReceive extends StatefulWidget {
  const AddGoodsReceive({Key? key}) : super(key: key);

  @override
  State<AddGoodsReceive> createState() => _AddGoodsReceiveState();
}

class _AddGoodsReceiveState extends State<AddGoodsReceive> {
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
            "Purchase",
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
                      'Goods Receive',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.heading354038),
                    ),
                    // SizedBox(width: MediaQuery.of(context).size.width * 0.3,),
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
                labelText: "Select Supplier",
                hintText: 'Mohan',
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: descriptionController,
                keyboardType: TextInputType.datetime,
                labelText: "Delivery Address",
                hintText: 'Address one',
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: percentageController,
                keyboardType: TextInputType.number,
                labelText: "Ship To",
                hintText: "Address one - Home",
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.greyIcon),
              ),
              CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: taxTypeController,
                  keyboardType: TextInputType.name,
                  labelText: "GRA Number",
                  hintText: "Chips",
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon)),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "GRA Date",
                hintText: "05/23/2023",
                suffixIcon:
                    const Icon(Icons.date_range, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "PO Date",
                hintText: "05/23/2023",
                suffixIcon:
                    const Icon(Icons.date_range, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "Currency",
                hintText: "USD",
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "Tax",
                hintText: "20%",
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "Do Number",
                hintText: "20%",
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "DO Date",
                hintText: "05/23/2023",
                suffixIcon:
                    const Icon(Icons.date_range, color: MyColors.greyIcon),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      MyColors.gradient1,
                      MyColors.gradient2,
                      MyColors.gradient3,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                    borderRadius: BorderRadius.circular(8)),
                child: Container(
                  decoration: BoxDecoration(
                      color: hexStringToColor('F2F1FF'),
                      borderRadius: BorderRadius.circular(8)),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 10, left: 15, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            containerText('Item Discount'),
                            containerText('0.00')
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 10, left: 15, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            containerText('Bill Discount'),
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  gradient: const LinearGradient(
                                      colors: [
                                        MyColors.gradient1,
                                        MyColors.gradient2,
                                        MyColors.gradient3,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                ),
                                child: Text(
                                  '0%',
                                  style: TextStyle(
                                      fontFamily: MyFont.myFont2,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: MyColors.white),
                                ))
                          ],
                        ),
                      ),
                      const CustomGradient(child: Divider()),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                containerText('Sub Total'),
                                containerText('0.00')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                containerText('Tax'),
                                containerText('0.00')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                containerText('NetTotal'),
                                containerText('0.00')
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  elevation: 0,
                ),
                // onPressed: () => Get.to(const SuccessfullyMsgScreen(
                //     name: 'Goods Receive Saved Successfully..! ',
                //     filename: AppRoutes.purchaseReturnList)),
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
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 35),
                    child: Text(
                      'Save',
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
              const SizedBox(
                height: 18,
              )
            ],
          ),
        ));
  }

  Text containerText(String val) {
    return Text(
      val,
      style: TextStyle(
          fontFamily: MyFont.myFont2,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: hexStringToColor('666666')),
    );
  }
}
