import 'package:erp/Helper/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/appRoute.dart';
import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../../../widgets/Custom_TextField_2.dart';
import '../../successfully_msg_screen.dart';

class AddStockTransfer extends StatefulWidget {
  const AddStockTransfer({Key? key}) : super(key: key);

  @override
  State<AddStockTransfer> createState() => _AddStockTransferState();
}

class _AddStockTransferState extends State<AddStockTransfer> {
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
            "Stock",
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
              CustomTextField2(
                inputBorder: InputBorder.none,
                controller: taxCodeController,
                keyboardType: TextInputType.text,
                labelText: "Name",
                hintText: 'Mohan',
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: descriptionController,
                keyboardType: TextInputType.datetime,
                labelText: "Transfer Code",
                hintText: '33202',
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "Transfer From Location",
                hintText: "Perumbakkam",
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "Transfer To Location",
                hintText: "Singapore",
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "Transfer Date",
                hintText: "05/23/2023",
              ),
              SizedBox(height: height(context) / 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.resolveWith<
                            EdgeInsetsGeometry>((Set<MaterialState> states) {
                          return const EdgeInsets.all(0);
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ))),
                    // style: ElevatedButton.styleFrom(
                    //     padding: EdgeInsets.zero,
                    //     elevation: 0,
                    // ),
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
                        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 35),
                        child: Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: MyColors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 0,
                    ),
                    onPressed: () {
                      Get.to(SuccessfullyMsgScreen(
                          name: 'Stock Transferred Successfully..!',
                          filename: Get.toNamed(AppRoutes.bottomNavBarScreen)));
                    },
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
                        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        child: Text(
                          'Save',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: MyColors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 18,
              )
            ],
          ),
        ));
  }
}
