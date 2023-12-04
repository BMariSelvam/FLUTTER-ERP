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

class AddStockProduct extends StatefulWidget {
  const AddStockProduct({Key? key}) : super(key: key);

  @override
  State<AddStockProduct> createState() => _AddStockProductState();
}

class _AddStockProductState extends State<AddStockProduct> {
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
                    // SizedBox(width: MediaQuery.of(context).size.width * 0.28,),
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
                hintText: 'Mohan',
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: descriptionController,
                keyboardType: TextInputType.datetime,
                labelText: "Description",
                hintText: 'Address one',
                suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                    color: MyColors.greyIcon),
              ),
              CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: taxTypeController,
                  keyboardType: TextInputType.name,
                  labelText: "Product Quantity",
                  hintText: "Chips",
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: MyColors.greyIcon)),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "SKU Number",
                hintText: "2023",
                suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
              ),
              CustomTextField2(
                inputBorder: const OutlineInputBorder(),
                controller: taxTypeController,
                keyboardType: TextInputType.name,
                labelText: "Stock Update Date",
                hintText: "05/23/2023",
                suffixIcon:
                    const Icon(Icons.date_range, color: MyColors.greyIcon),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 8),
                    child: Text(
                      'PRODUCT DETAILS',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: MyColors.text878787),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    tapBarWidget(
                      context: context,
                      heading1: "S.No",
                      heading2: "Description",
                      heading3: "Qty",
                      heading4: "Price",
                      heading5: "T.Qty",
                    ),
                    Container(
                      color: MyColors.text878787,
                      height: 1,
                    ),
                    productDetails(),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              remarkAndTotal(),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  elevation: 0,
                ),
                onPressed: () => Get.to(SuccessfullyMsgScreen(
                    name: 'Stock Saved Successfully..!',
                    filename: Get.toNamed(AppRoutes.stockAdjustmentList))),
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

  tapBarWidget(
      {required BuildContext context,
      required String heading1,
      required String heading2,
      required String heading3,
      required String heading4,
      required String heading5}) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(0.8),
          1: FlexColumnWidth(2),
          4: FlexColumnWidth(1.2)
        },
        children: [
          TableRow(children: [
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              color: MyColors.containerEBEBEB,
              child: Text(
                heading1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: MyColors.text2E2E2E),
              ),
            ),
            Container(
              color: MyColors.containerF6F6F6,
              padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10),
              child: Text(
                heading2,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: MyColors.text2E2E2E),
              ),
            ),
            Container(
              color: MyColors.containerEBEBEB,
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                heading3,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: MyColors.text2E2E2E),
              ),
            ),
            Container(
              color: MyColors.containerF6F6F6,
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                heading4,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: MyColors.text2E2E2E),
              ),
            ),
            Container(
              color: MyColors.containerEBEBEB,
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                heading5,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: MyColors.text2E2E2E),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  tapBar2Widget(
      {required BuildContext context,
      required String heading1,
      required String heading2,
      required String heading3,
      required String heading4,
      required String heading5}) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(0.8),
          1: FlexColumnWidth(2),
          4: FlexColumnWidth(1.2)
        },
        children: [
          TableRow(children: [
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              color: MyColors.containerEBEBEB,
              child: Text(
                heading1,
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: MyColors.text2E2E2E),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15, left: 10),
              color: MyColors.containerF6F6F6,
              child: Text(
                heading2,
                textAlign: TextAlign.start,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: MyColors.text2E2E2E),
              ),
            ),
            Container(
              color: MyColors.containerEBEBEB,
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                heading3,
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: MyColors.text2E2E2E),
              ),
            ),
            Container(
              color: MyColors.containerF6F6F6,
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                heading4,
                textAlign: TextAlign.center,
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: MyColors.text2E2E2E),
              ),
            ),
            Container(
              color: MyColors.containerEBEBEB,
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(heading5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: MyColors.text2E2E2E)),
            ),
          ]),
        ],
      ),
    );
  }

  productDetails() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return tapBar2Widget(
            context: context,
            heading1: "01.",
            heading2: "Apple",
            heading3: "10",
            heading4: "87.00",
            heading5: "870.00",
          );
          Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(left: 18, right: 18),
              decoration: BoxDecoration(
                  // color: index.isEven ? hexStringToColor('FFFFFF') : hexStringToColor('F4F4F4'),
                  border: Border.all(color: MyColors.greyBackground)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "123",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: MyColors.greyText),
                  ),
                  Text(
                    "Apple",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: MyColors.greyText),
                  ),
                  Text(
                    "10",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: MyColors.greyText),
                  ),
                  Text(
                    "87.00",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: MyColors.greyText),
                  ),
                  Text(
                    "870.00",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: MyColors.greyText),
                  ),
                ],
              ));
        },
      ),
    );
  }

  remarkAndTotal() {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: height(context) / 6,
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.fromLTRB(15, 10, 3, 10),
          decoration: BoxDecoration(
              color: MyColors.containerF6F6F6,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'REMARK',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    color: MyColors.text878787),
              ),
              SizedBox(
                height: height(context) / 8.4,
                child: SingleChildScrollView(
                  child: Text(
                    'Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text,',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.bold,
                      // color: hexStringToColor('878787')
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
        Expanded(
            child: Container(
          height: height(context) / 6,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.fromLTRB(3, 10, 15, 10),
          decoration: BoxDecoration(
              color: MyColors.containerF6F6F6,
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width(context) / 5,
                        child: Text('Sub Qty',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                color: MyColors.text878787)),
                      ),
                      Text(':',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.text878787)),
                    ],
                  ),
                  Text('2152.00',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.text878787)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width(context) / 5,
                        child: Text('Tax',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                color: MyColors.text878787)),
                      ),
                      Text(':',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.text878787)),
                    ],
                  ),
                  Text('150.00',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.text878787)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width(context) / 5,
                        child: Text('Net Qty',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                color: MyColors.text878787)),
                      ),
                      Text(':',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.text878787)),
                    ],
                  ),
                  Text('2152.00',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.text878787)),
                ],
              ),
            ],
          ),
        ))
      ],
    );
  }
}
