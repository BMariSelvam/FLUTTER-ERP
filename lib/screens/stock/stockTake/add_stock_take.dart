import 'package:erp/Helper/custom_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/appRoute.dart';
import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../../../widgets/product_text_field.dart';
import '../../successfully_msg_screen.dart';

class AddStockTake extends StatefulWidget {
  const AddStockTake({Key? key}) : super(key: key);

  @override
  State<AddStockTake> createState() => _AddStockTakeState();
}

TextEditingController cartonController = TextEditingController();
TextEditingController unitController = TextEditingController();
TextEditingController qtyController = TextEditingController();
TextEditingController newController = TextEditingController();
TextEditingController unitController2 = TextEditingController();
TextEditingController qtyController2 = TextEditingController();

class _AddStockTakeState extends State<AddStockTake> {
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
            "Add",
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ST.No 6569878',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: MyFont.myFont2,
                        fontWeight: FontWeight.bold,
                        color: MyColors.heading354038),
                  ),
                  Text(
                    '03/24/2023',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: MyFont.myFont2,
                        fontWeight: FontWeight.bold,
                        color: MyColors.heading354038),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: list(),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                              (Set<MaterialState> states) {
                        return const EdgeInsets.all(0);
                      }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        name: 'Stock Take saved Successfully..!',
                        filename: Get.toNamed(AppRoutes.stockTransferList)));
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
        ));
  }

  list() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(left: 12, right: 12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: MyColors.white, boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 2)
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomGradient(
                  child: Text(
                    'Product Name',
                    style: TextStyle(fontSize: 15, fontFamily: MyFont.myFont2),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProductTextFormField(
                          controller: cartonController,
                          inputBorder: InputBorder.none,
                          labelText: 'Carton',
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                        ),
                        ProductTextFormField(
                          controller: unitController,
                          inputBorder: InputBorder.none,
                          labelText: 'Unit',
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                        ),
                        ProductTextFormField(
                          controller: qtyController,
                          inputBorder: InputBorder.none,
                          labelText: 'Qty',
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ProductTextFormField(
                          controller: newController,
                          inputBorder: InputBorder.none,
                          labelText: 'New',
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                        ),
                        ProductTextFormField(
                          controller: unitController2,
                          inputBorder: InputBorder.none,
                          labelText: 'Unit',
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                        ),
                        ProductTextFormField(
                          controller: qtyController2,
                          inputBorder: InputBorder.none,
                          labelText: 'Qty',
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
