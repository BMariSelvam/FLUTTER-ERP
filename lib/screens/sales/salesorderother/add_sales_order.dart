import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/GetAllCurrencyModel.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/GetAllTaxModel.dart';
import 'package:erp/widgets/search_dropdown_textfield2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Helper/assets.dart';
import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../../../widgets/Custom_TextField_2.dart';
import 'add_sales_order_controller.dart';

class AddSalesOrder extends StatefulWidget {
  const AddSalesOrder({Key? key}) : super(key: key);

  @override
  State<AddSalesOrder> createState() => _AddSalesOrderState();
}

class _AddSalesOrderState extends State<AddSalesOrder> {
  late AddSalesOrderController addSalesOrderController;

  @override
  void initState() {
    super.initState();
    addSalesOrderController = Get.put(AddSalesOrderController());
    addSalesOrderController.customerListGet();
    addSalesOrderController.currencyListGet();
    addSalesOrderController.taxListGet();
    addSalesOrderController.dateController.text =
        addSalesOrderController.orderDate.toString();
    addSalesOrderController.dateController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: addSalesOrderController.addSalesOrderKey,
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
              "Sales",
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
                        'Sales Order',
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
                          value: addSalesOrderController.selected,
                          onToggle: (val) {
                            setState(() {
                              addSalesOrderController.selected = val;
                            });
                          })
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 12,
                    bottom: 8,
                  ),
                  child: Obx(() {
                    return SearchDropdownTextField2<GetCustomerModel>(
                        filledColor: MyColors.greyIcon.withOpacity(0.8),
                        hintText: 'Select Customer',
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
                          color: MyColors.black.withOpacity(0.7),
                        ),
                        inputBorder: BorderSide.none,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.greyIcon.withOpacity(0.6),
                              width: 1.8),
                        ),
                        items: addSalesOrderController.getCustomerList.value,
                        color: Colors.black54,
                        selectedItem: addSalesOrderController.getCustomer,
                        isValidator: true,
                        errorMessage: 'Please enter Customer Name',
                        onAddPressed: () {
                          setState(() {
                            addSalesOrderController.selectCustomer = "";
                            addSalesOrderController.selectCustomer = null;
                          });
                        },
                        onChanged: (value) async {
                          FocusScope.of(context).unfocus();
                          addSalesOrderController.getCustomer = value;
                          addSalesOrderController.selectCustomer = value.name;
                          setState(() {
                            addSalesOrderController.selectCustomer = value.name;
                            addSalesOrderController.deliveryAddress.text =
                                "${value.addressLine1!}"
                                ","
                                "${value.addressLine2!}"
                                ","
                                "${value.addressLine3!}";
                          });
                        });
                  }),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addSalesOrderController.deliveryAddress,
                  keyboardType: TextInputType.datetime,
                  labelText: "Delivery Address",
                  hintText: 'Delivery Address',
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addSalesOrderController.soNumberController,
                  keyboardType: TextInputType.name,
                  labelText: "So Number",
                  hintText: "2023",
                  suffixIcon: const Icon(Icons.edit, color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  readOnly: true,
                  inputBorder: const OutlineInputBorder(),
                  controller: addSalesOrderController.dateController,
                  keyboardType: TextInputType.datetime,
                  hintText: "So Date",
                  labelText: "So Date",
                  suffixIcon:
                      const Icon(Icons.date_range, color: MyColors.mainTheme),
                  onTap: () async {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100))
                        .then((value) {
                      setState(() {
                        addSalesOrderController.orderDate = value!;
                        addSalesOrderController.dateController.text =
                            '${addSalesOrderController.orderDate.day}-${addSalesOrderController.orderDate.month}-${addSalesOrderController.orderDate.year}';
                        addSalesOrderController.dates =
                            '${addSalesOrderController.orderDate.year}-${addSalesOrderController.orderDate.month}-${addSalesOrderController.orderDate.day}';
                      });
                    });
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Obx(() {
                    return SearchDropdownTextField2<GetAllCurrencyModel>(
                        labelText: 'Currency',
                        hintText: 'Select atleast one Currency',
                        suffixIcon: Icon(
                          Icons.expand_circle_down_outlined,
                          color: MyColors.black.withOpacity(0.4),
                        ),
                        items: addSalesOrderController.getCurrencyList.value,
                        color: Colors.black54,
                        selectedItem: addSalesOrderController.getCurrencyModel,
                        isValidator: true,
                        errorMessage: '*',
                        onAddPressed: () {
                          setState(() {
                            addSalesOrderController.currency = "";
                            addSalesOrderController.getCurrencyModel = null;
                          });
                        },
                        onChanged: (value) async {
                          FocusScope.of(context).unfocus();
                          addSalesOrderController.getCurrencyModel = value;
                          addSalesOrderController.currency = value.name;
                          setState(() {
                            addSalesOrderController.currency = value.name;
                            addSalesOrderController.currencyController.text =
                                value.name ?? "";
                          });
                        });
                  }),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addSalesOrderController.currencyController,
                  keyboardType: TextInputType.name,
                  labelText: "Currency",
                  hintText: "USD",
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: MyColors.greyIcon),
                ),
                CustomTextField2(
                  inputBorder: const OutlineInputBorder(),
                  controller: addSalesOrderController.taxTypeController,
                  keyboardType: TextInputType.name,
                  labelText: "Tax",
                  hintText: "%",
                  suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: MyColors.greyIcon),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 12,
                    bottom: 8,
                  ),
                  child: Obx(() {
                    return SearchDropdownTextField2<GetTaxModel>(
                        filledColor: MyColors.greyIcon.withOpacity(0.8),
                        hintText: 'Select Tax',
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
                          color: MyColors.black.withOpacity(0.7),
                        ),
                        inputBorder: BorderSide.none,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: MyColors.greyIcon.withOpacity(0.6),
                              width: 1.8),
                        ),
                        items: addSalesOrderController.getTaxList.value,
                        color: Colors.black54,
                        selectedItem: addSalesOrderController.getTaxModel,
                        isValidator: true,
                        errorMessage: "Please enter Tax",
                        onAddPressed: () {
                          setState(() {
                            addSalesOrderController.tax = "";
                            addSalesOrderController.tax = null;
                          });
                        },
                        onChanged: (value) async {
                          FocusScope.of(context).unfocus();
                          addSalesOrderController.getTaxModel = value;
                          addSalesOrderController.tax = value.taxName;
                          setState(() {
                            addSalesOrderController.tax = value.taxName;
                          });
                        });
                  }),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.only(right: 15, bottom: 8),
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                                colors: [
                                  MyColors.gradient1,
                                  MyColors.gradient2,
                                  MyColors.gradient3,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              CustomGradient(
                                  child: Image.asset(
                                IconAssets.product,
                                scale: 2.5,
                              )),
                              const SizedBox(width: 6),
                              CustomGradient(
                                  child: Text(
                                'Add',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ))
                            ],
                          ),
                        ),
                      ),
                    )
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
                        heading5: "Total",
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
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
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
              heading2: "Apple",
              heading3: "10",
              heading4: "87.00",
              heading5: "870.00",
            );
            // Container(
            //     padding: const EdgeInsets.all(10),
            //     margin: const EdgeInsets.only(left: 18, right: 18),
            //     decoration: BoxDecoration(
            //         // color: index.isEven ? hexStringToColor('FFFFFF') : hexStringToColor('F4F4F4'),
            //         border: Border.all(color: MyColors.greyBackground)),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Text(
            //           "123",
            //           style: TextStyle(
            //               decoration: TextDecoration.none,
            //               fontFamily: MyFont.myFont,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 12,
            //               color: MyColors.greyText),
            //         ),
            //         Text(
            //           "Apple",
            //           style: TextStyle(
            //               decoration: TextDecoration.none,
            //               fontFamily: MyFont.myFont,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 12,
            //               color: MyColors.greyText),
            //         ),
            //         Text(
            //           "10",
            //           style: TextStyle(
            //               decoration: TextDecoration.none,
            //               fontFamily: MyFont.myFont,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 12,
            //               color: MyColors.greyText),
            //         ),
            //         Text(
            //           "87.00",
            //           style: TextStyle(
            //               decoration: TextDecoration.none,
            //               fontFamily: MyFont.myFont,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 12,
            //               color: MyColors.greyText),
            //         ),
            //         Text(
            //           "870.00",
            //           style: TextStyle(
            //               decoration: TextDecoration.none,
            //               fontFamily: MyFont.myFont,
            //               fontWeight: FontWeight.bold,
            //               fontSize: 12,
            //               color: MyColors.greyText),
            //         ),
            //       ],
            //     ));
          },
        ));
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
                        child: Text('Sub Total',
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
                        child: Text('Net Total',
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
