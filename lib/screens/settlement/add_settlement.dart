import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/screens/settlement/add_settlement_controller.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../Helper/appRoute.dart';
import '../successfully_msg_screen.dart';

class AddSettlement extends StatefulWidget {
  const AddSettlement({Key? key}) : super(key: key);

  @override
  State<AddSettlement> createState() => _AddSettlementState();
}

class _AddSettlementState extends State<AddSettlement> {
  late AddSettlementController addSettlementController;

  @override
  void initState() {
    super.initState();
    addSettlementController = Get.put(AddSettlementController());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addSettlementController.addSettlementKey,
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
              "Settlement",
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
                        'Settlement',
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
                          value: addSettlementController.selected,
                          onToggle: (val) {
                            setState(() {
                              addSettlementController.selected = val;
                            });
                          })
                    ],
                  ),
                ),
                CustomTextField2(
                  inputBorder: InputBorder.none,
                  controller: addSettlementController.stNoController,
                  keyboardType: TextInputType.text,
                  labelText: "ST.No",
                  hintText: '43543',
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addSettlementController.dateController,
                  keyboardType: TextInputType.datetime,
                  labelText: "Date",
                  hintText: '05/23/2023',
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: MyColors.greyIcon),
                ),
                CustomTextField2(
                    inputBorder: const OutlineInputBorder(),
                    controller: addSettlementController.totalController,
                    keyboardType: TextInputType.name,
                    labelText: "Total",
                    hintText: "\$786.00",
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                        color: MyColors.greyIcon)),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addSettlementController.paymentModeController,
                  keyboardType: TextInputType.name,
                  labelText: "Payment mode",
                  hintText: "Cash",
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 8),
                      child: Text(
                        'Payment Information',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: MyColors.heading354038),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, top: 8, bottom: 8, right: 25),
                  margin: const EdgeInsets.fromLTRB(15, 10, 15, 2),
                  decoration: BoxDecoration(
                      color: hexStringToColor('E8E8E8'),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pay mode',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: MyColors.text2E2E2E),
                      ),
                      Text(
                        'Amount',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: MyColors.text2E2E2E),
                      ),
                    ],
                  ),
                ),
                paymentInfo(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, bottom: 15),
                      child: Text(
                        'Currency Denomination Info',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: MyColors.heading354038),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 100),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      tapBarWidget(
                          context: context,
                          heading1: "S.No",
                          heading2: "Count",
                          heading3: "Amount"),
                      Container(
                        color: MyColors.text878787,
                        height: 1,
                      ),
                      currencyInfo(),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
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
                            name: 'Settlement Successfully..! ',
                            filename:
                                Get.toNamed(AppRoutes.bottomNavBarScreen)));
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
          )),
    );
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
      required String heading3}) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(0.6),
          1: FlexColumnWidth(0.9),
          2: FlexColumnWidth(1.2)
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
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Text(
                heading2,
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
                heading3,
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
      required String heading3}) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(0.6),
          1: FlexColumnWidth(0.9),
          2: FlexColumnWidth(1.2)
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
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              color: MyColors.containerF6F6F6,
              child: Text(
                heading2,
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
          ]),
        ],
      ),
    );
  }

  currencyInfo() {
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return tapBar2Widget(
                context: context,
                heading1: "01.",
                heading2: "12",
                heading3: "870.00");
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
        ));
  }

  paymentInfo() {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: height(context) / 6,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
          margin: const EdgeInsets.fromLTRB(15, 2, 15, 10),
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
                  Text('Sub Total',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.text878787)),
                  Text(':',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.text878787)),
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
                  Text('Tax',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.text878787)),
                  Text('         :',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.text878787)),
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
                  Text('Net Total',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.text878787)),
                  Text('  :',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.text878787)),
                  Text('2302.00',
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
