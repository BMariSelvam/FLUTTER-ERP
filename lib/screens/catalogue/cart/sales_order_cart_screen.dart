import 'dart:convert';
import 'dart:io';

import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/GetAllProductModel.dart';
import 'package:erp/Model/RequestModel/CreateSalesOrderModel.dart';
import 'package:erp/Model/RequestModel/invioce_model/Invoice.dart';
import 'package:erp/Model/RequestModel/invioce_model/InvoiceDetail.dart';
import 'package:erp/screens/catalogue/catalogue_controller.dart';
import 'package:erp/widgets/signature/signature_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../Helper/preferenceHelper.dart';
import '../../../../../Model/LoginUserModel.dart';
import '../../../../../Model/RequestModel/SalesOrderDetail.dart';
import '../../../Model/GetCustomerByCodeModel.dart';
import 'sales_order_cart_controller.dart';

class SalesOrderCartScreen extends StatefulWidget {
  const SalesOrderCartScreen({super.key});

  @override
  State<SalesOrderCartScreen> createState() => _SalesOrderCartScreenState();
}

class _SalesOrderCartScreenState extends State<SalesOrderCartScreen> {
  // late CatalogueController catalogueController;
  late SalesOrderCartController controller;

  // late SalesProductController controller;

  SignatureCImage? sign1;
  XFile? pickedFile;

  final geoLocator =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  Position? _currentPosition;
  String currentAddress = "";

  double? summaryNetTotal;
  double? summaryTotalPrice;

  double taxValue = 0;
  double cartonTotal = 0;
  double unitTotal = 0;
  double price = 0;
  double total = 0;
  int totalCount = 0;
  double grandTotal = 0;
  double finalTotalPrice = 0;
  double summaryListUnitPrice = 0;
  double summaryListCartPrice = 0;

  double boxtotal = 0;
  double unittotal = 0;
  double qtytotal = 0;
  double subtotal = 0;

  double tax = 0;
  double totalcount = 0;
  double GrandTotal = 0;
  int slNo = 0;

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<GetAllProductModel> productList = [];

  List<SalesOrderDetail> salesProductList = [];

  List<GetCustomerByCodeModel> getCustomerByCodeModel = [];

  LoginUserModel? userDetail;

  int? orgId;
  int? salesOrderSelectedRadio;

  initialiseData() async {
    await PreferenceHelper.getUserData().then((value) {
      setState(() {
        userDetail = value;
        orgId = userDetail?.orgId;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initialiseData();
    controller = Get.put(SalesOrderCartController());
    CatalogueController productController = Get.put(CatalogueController());
    getCustomerByCodeModel =
        productController.getCustomerByCodeList.value!.toList();
    productList = controller.productService.catalogueProductSelectedListItems;
    locationPermission();
    controller.isSumSelected = false;
    controller.productService.catalogueProductListChangeStream.listen((_) {});
    controller
        .getTaxDetails(getCustomerByCodeModel.first.taxTypeId)
        .then((value) {
      setState(() {});
    });
    salesOrderSelectedRadio = 0;
  }

  @override
  Widget build(BuildContext context) {
    double taxValue = 0;
    double boxtotal = 0;
    double unittotal = 0;
    double subtotal = 0;
    double grandTotal = 0;
    for (var element in productList) {
      unittotal += element.unitcount * element.sellingCost!;
      boxtotal += element.boxcount * element.sellingBoxCost!;
      subtotal = unittotal + boxtotal;

      taxValue = (subtotal * controller.taxPercentage) / 100;
      if (controller.taxName == "Inclusive") {
        grandTotal = subtotal;
      } else if (controller.taxName == "Exclusive") {
        grandTotal = subtotal + taxValue;
      } else if (controller.taxName == "GSTs") {
        grandTotal = subtotal + taxValue;
      } else {
        grandTotal = subtotal + taxValue;
      }
    }

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 5,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: MyColors.primaryCustom),
                      borderRadius: BorderRadius.circular(20),
                      color: MyColors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomGradient(
                        child: Text(
                          "SalesOrder",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: MyColors.black),
                        ),
                      ),
                      Radio<int>(
                        value: 0,
                        groupValue: salesOrderSelectedRadio,
                        activeColor: MyColors.white,
                        // Change the active radio button color here
                        fillColor:
                            MaterialStateProperty.all(MyColors.mainTheme),
                        // Change the fill color when selected
                        splashRadius: 20,
                        // Change the splash radius when clicked
                        onChanged: (value) {
                          setState(() {
                            salesOrderSelectedRadio = value;
                            print("sssssssssssss");
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 5,
                    right: 5,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(color: MyColors.primaryCustom),
                      borderRadius: BorderRadius.circular(20),
                      color: MyColors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomGradient(
                        child: Text(
                          "Invoice",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: MyColors.black),
                        ),
                      ),
                      Radio<int>(
                        value: 1,
                        groupValue: salesOrderSelectedRadio,
                        activeColor: MyColors.white,
                        // Change the active radio button color here
                        fillColor:
                            MaterialStateProperty.all(MyColors.mainTheme),
                        // Change the fill color when selected
                        splashRadius: 20,
                        // Change the splash radius when clicked
                        onChanged: (value) {
                          setState(() {
                            salesOrderSelectedRadio = value;
                            print("hhh$salesOrderSelectedRadio");
                            print("ggg$salesOrderSelectedRadio");
                            print("jj$salesOrderSelectedRadio");
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              MyColors.gradient1,
              MyColors.gradient2,
              MyColors.gradient3,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios, color: MyColors.white),
        ),
        title: Text('Cart',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: MyFont.myFont,
                color: MyColors.white)),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              if (salesOrderSelectedRadio == 0) {
                onPressedSalesOrderValue();
              } else if (salesOrderSelectedRadio == 1) {
                onPressedInvoiceValue();
              }
            },
            icon: const Icon(Icons.save_rounded, color: MyColors.white),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            MyColors.gradient1,
            MyColors.gradient2,
            MyColors.gradient3,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Table(
          children: [
            TableRow(children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: MyColors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      subtotal.toStringAsFixed(2),
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: MyColors.white),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Tax',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: MyColors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      taxValue.toStringAsFixed(2),
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: MyColors.white),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Net Total',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: MyColors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      grandTotal.toStringAsFixed(2),
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: MyColors.white),
                    ),
                  ],
                ),
              ),
            ]),
          ],
        ),
      ),
      backgroundColor: MyColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: width(context) / 1.5,
                          child: CustomGradient(
                            child: Text(
                              getCustomerByCodeModel.first.name ?? "",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: MyColors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: width(context) / 1.5,
                          child: Text(
                            getCustomerByCodeModel.first.code ?? "",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: MyColors.black),
                          ),
                        ),
                        SizedBox(
                          width: width(context) / 1.5,
                          child: Text(
                            '${getCustomerByCodeModel.first.addressLine1 ?? ""},${getCustomerByCodeModel.first.addressLine1 ?? ""},${getCustomerByCodeModel.first.addressLine1 ?? ""}',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: MyColors.black),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      currentDate,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: MyColors.black),
                    ),
                  ]),
            ),
            Container(
              color: MyColors.primaryCustom.withOpacity(0.4),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(0.5),
                      1: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Code',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: MyFont.myFont2),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Description',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: MyFont.myFont2),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Carton',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: MyFont.myFont2),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Unit',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: MyFont.myFont2),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Qty',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: MyFont.myFont2),
                          ),
                        ),
                      ])
                    ],
                  ),
                  const SizedBox(height: 5),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'C Price',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: MyFont.myFont2),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'U Price',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                fontFamily: MyFont.myFont2),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Amt',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: MyFont.myFont2),
                          ),
                        ),
                      ])
                    ],
                  ),
                ],
              ),
            ),
            listView(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 85,
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 10,
                      right: 5,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: MyColors.greyText),
                        borderRadius: BorderRadius.circular(20),
                        color: MyColors.white),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: MyColors.mainTheme,
                        ),
                        SingleChildScrollView(
                          child: SizedBox(
                            width: width(context) / 5.8,
                            child: Text(
                              currentAddress,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: MyColors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // _showDialogToGetImage(context);
                      _getImage(true);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 5,
                        right: 5,
                      ),
                      height: 85,
                      decoration: BoxDecoration(
                          border: Border.all(color: MyColors.greyText),
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors.white),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Container(
                        child: (pickedFile == null)
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    IconAssets.imgIcon,
                                    // fit: BoxFit.fill,
                                    scale: 3,
                                  ),
                                ],
                              )
                            : pickedFile != null
                                ? Image.file(
                                    File(pickedFile!.path),
                                    fit: BoxFit.fill,
                                  )
                                : Container(
                                    color: Colors.grey,
                                    child: const Icon(
                                      Icons.person,
                                      size: 70,
                                    )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignatureScreen(),
                          )).then((value) {
                        setState(() {
                          sign1 = value as SignatureCImage;
                        });
                      });
                    },
                    child: Builder(builder: (context) {
                      return Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          left: 5,
                          right: 10,
                        ),
                        height: 85,
                        decoration: BoxDecoration(
                            border: Border.all(color: MyColors.greyText),
                            borderRadius: BorderRadius.circular(20),
                            color: MyColors.white),
                        padding: const EdgeInsets.symmetric(
                            vertical: 05, horizontal: 20),
                        child: (sign1?.userSignatureExportedImage != null &&
                                sign1?.customerSignatureExportedImage != null)
                            ? Column(
                                children: [
                                  Text(
                                    "Customer Signature",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 5,
                                      color: MyColors.black,
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: MyColors.white,
                                    ),
                                    width: width(context),
                                    height: 25,
                                    child: Image.memory(
                                      sign1!.customerSignatureExportedImage!,
                                      scale: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    "User Signature",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: MyFont.myFont,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 5,
                                      color: MyColors.black,
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: MyColors.white,
                                    ),
                                    width: width(context),
                                    height: 25,
                                    child: Image.memory(
                                      sign1!.userSignatureExportedImage!,
                                      scale: 2,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    IconAssets.signIcon,
                                    // fit: BoxFit.fill,
                                    scale: 3,
                                  ),
                                ],
                              ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
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
                  onPressed: () {
                    controller.productService.clearProductList();
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
                  onPressed: () {
                    if (salesOrderSelectedRadio == 0) {
                      onPressedSalesOrderValue();
                    } else if (salesOrderSelectedRadio == 1) {
                      onPressedInvoiceValue();
                    }
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
                          vertical: 15, horizontal: 35),
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
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  listView() {
    return SizedBox(
      // height: height(context) / 2,
      height: height(context) / 3.5,
      child: ListView.builder(
          shrinkWrap: true,
          physics: productList.length == 2
              ? const NeverScrollableScrollPhysics()
              : const PageScrollPhysics(),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            GetAllProductModel values = productList[index];
            unittotal = values.unitcount * values.sellingCost!;
            boxtotal = values.boxcount * values.sellingBoxCost!;
            totalCount =
                values.unitcount + (values.pcsPerCarton! * values.boxcount);
            total = unittotal + boxtotal;
            if (values.boxcount == 0 && values.unitcount == 0) {
              return Container();
            } else {
              return Container(
                // color: MyColors.greyText,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(0.5),
                        1: FlexColumnWidth(),
                      },
                      children: [
                        TableRow(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              values.code ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: MyFont.myFont2),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              values.name ?? "",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: MyFont.myFont2),
                            ),
                          ),
                        ]),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                      },
                      children: [
                        TableRow(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              values.boxcount.toStringAsFixed(0),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: MyFont.myFont2),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              values.unitcount.toStringAsFixed(0),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: MyFont.myFont2),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              totalCount.toStringAsFixed(0),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: MyFont.myFont2),
                            ),
                          ),
                        ])
                      ],
                    ),
                    const SizedBox(height: 5),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth(),
                      },
                      children: [
                        TableRow(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              values.sellingBoxCost?.toStringAsFixed(2) ??
                                  "0.00",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: MyFont.myFont2),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              values.sellingCost?.toStringAsFixed(2) ?? "0.00",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: MyFont.myFont2),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              total.toStringAsFixed(2),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: MyFont.myFont2),
                            ),
                          ),
                        ])
                      ],
                    ),
                    const Divider()
                  ],
                ),
              );
            }
          }),
    );
  }

  // _showDialogToGetImage(BuildContext context) {
  //   Widget cameraButton = InkWell(
  //     onTap: () {
  //       _getImage(true);
  //       Navigator.of(context).pop();
  //     },
  //     child: const Padding(
  //       padding: EdgeInsets.all(15),
  //       child: Icon(Icons.camera_alt_outlined, size: 40),
  //     ),
  //   );
  //
  //   Widget clear = InkWell(
  //     onTap: () {
  //       Navigator.of(context).pop();
  //     },
  //     child: const Icon(Icons.clear_rounded),
  //   );
  //
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: Padding(
  //       padding: const EdgeInsets.all(10),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [const Text("Click Image"), clear],
  //       ),
  //     ),
  //     content: cameraButton,
  //   );
  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  Future _getImage(bool isCamera) async {
    final picker = ImagePicker();
    pickedFile = await picker.pickImage(
        imageQuality: Platform.isAndroid ? 40 : 30, source: ImageSource.camera);
    if (pickedFile != null) {
      List<int> imageBytes = await pickedFile!.readAsBytes();
      setState(() {
        controller.createSalesOrder.cameraImage = pickedFile!.name;
      });
      controller.createSalesOrder.cameraImgBase64String =
          base64Encode(imageBytes);
    } else {
      debugPrint('No image selected.');
    }
  }

  void getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      getAddressFromLatLng();
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  void getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = p[0];

      setState(() {
        currentAddress =
            "${place.thoroughfare},${place.subThoroughfare},${place.name}, ${place.subLocality}";
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void locationPermission() async {
    PermissionStatus locationStatus = await Permission.location.request();

    LocationPermission permission;
    permission = await Geolocator.requestPermission();

    if (locationStatus == PermissionStatus.granted) {
      if (kDebugMode) {
        print('location Permission');
      }
      // showPlacePicker();
      getCurrentLocation();
      if (_currentPosition != null) {
        Text(currentAddress, style: const TextStyle(fontSize: 20.0));
      } else {
        const Text("Couldn't fetch the location");
      }
    }

    if (locationStatus == PermissionStatus.denied) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Permission Required'),
      ));
    }
    if (locationStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  salesOrderEditMenu() {
    return SizedBox(
      height: 25,
      width: 28,
      child: PopupMenuButton(
        color: MyColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 2, color: MyColors.primaryCustom)),
        iconSize: 25,
        padding: const EdgeInsets.all(1),
        icon: const Icon(
          Icons.more_vert,
          color: MyColors.white,
          size: 30,
        ),
        offset: const Offset(0, 30),
        itemBuilder: (_) => <PopupMenuEntry>[
          PopupMenuItem(
              onTap: () {
                onPressedSalesOrderValue();
              },
              height: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const CustomGradient(
                      child: Icon(
                        Icons.save,
                        color: MyColors.white,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: width(context) / 50,
                    ),
                    CustomGradient(
                      child: Text(
                        'Sales order ',
                        style: TextStyle(
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: MyColors.mainTheme),
                      ),
                    ),
                  ]),
                ],
              )),
          const PopupMenuDivider(),
          PopupMenuItem(
              onTap: () {
                onPressedInvoiceValue();
              },
              height: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const CustomGradient(
                      child: Icon(
                        Icons.insert_invitation_rounded,
                        color: MyColors.white,
                        size: 25,
                      ),
                    ),
                    SizedBox(
                      width: width(context) / 50,
                    ),
                    CustomGradient(
                      child: Text(
                        'Invoice',
                        style: TextStyle(
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                            color: MyColors.mainTheme),
                      ),
                    ),
                  ]),
                ],
              )),
        ],
      ),
    );
  }

  onPressedSalesOrderValue() async {
    FocusScope.of(context).unfocus();
    if (controller.productService.catalogueProductSelectedListItems.isEmpty) {
      Get.snackbar(
        margin: const EdgeInsets.all(20),
        backgroundColor: MyColors.primaryCustom,
        "Please Select Atleast One Product",
        "Your Product List is empty",
        colorText: MyColors.white,
        icon: const Icon(
          Icons.error,
          color: MyColors.white,
        ),
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
    } else {
      controller.createSalesOrder = SalesOrder(
        salesOrderDetail:
            controller.productService.catalogueProductSelectedListItems
                .map((e) => SalesOrderDetail(
                      orgId: orgId,
                      tranNo: "",
                      slNo: e.slNo,
                      productCode: e.productCode,
                      productName: e.productName,
                      boxCount: e.boxCount ?? 0,
                      pcsQty: e.pcsPerCarton,
                      qty: e.unitCount,
                      foc: 0,
                      exchange: 0,
                      boxPrice: e.sellingBoxCost,
                      price: price,
                      total: grandTotal,
                      itemDiscount: 0,
                      itemDiscountPerc: 0,
                      subTotal: price,
                      tax: taxValue,
                      netTotal: grandTotal,
                      fPrice: price,
                      fBoxPrice: 0,
                      fTotal: grandTotal,
                      fTax: taxValue,
                      fNetTotal: grandTotal,
                      createdBy: "ad",
                      createdOn: currentDate,
                      changedBy: "ad",
                      changedOn: currentDate,
                      stockQty: 0,
                      stockBoxQty: 0,
                      weight: 0,
                      remarks: "",
                      boxQty: e.boxCount ?? 0,
                      fSubTotal: price,
                      fItemDiscount: 0,
                      stockPcsQty: 0,
                      fItemDiscountPerc: 0,
                      isWeight: false,
                    ))
                .toList(),
        orgId: orgId,
        tranNo: "",
        tranDate: currentDate,
        customerId: getCustomerByCodeModel.first.code ?? "",
        customerName: getCustomerByCodeModel.first.name ?? "",
        customerAddress:
            '${getCustomerByCodeModel.first.addressLine1}${getCustomerByCodeModel.first.addressLine2}${getCustomerByCodeModel.first.addressLine3}',
        locationCode: "HO",
        taxCode: int.parse(
          getCustomerByCodeModel.first.taxTypeId ?? "",
        ),
        taxType: getCustomerByCodeModel.first.taxType ?? "",
        taxPerc: taxValue,
        currencyCode: getCustomerByCodeModel.first.currencyId ?? "SGD",
        currencyRate: 1,
        total: grandTotal,
        discount: 0,
        discountPerc: 0,
        subTotal: price,
        tax: taxValue,
        netTotal: grandTotal,
        fTotal: grandTotal,
        fDiscount: 0,
        fSubTotal: price,
        fTax: taxValue,
        fNetTotal: grandTotal,
        remarks: "",
        referenceNo: "",
        createdFrom: "Web",
        isActive: true,
        createdBy: "ad",
        createdOn: currentDate,
        changedBy: "ad",
        changedOn: currentDate,
        assignTo: "",
        tranDateString: "",
        status: 0,
        isUpdate: true,
        customerShipToId: 0,
        customerShipToAddress: getCustomerByCodeModel.first.addressLine1 ?? "",
        priceSettingCode: "",
        termCode: "",
        invoiceType: true,
        billDiscount: 0,
        latitude: _currentPosition?.latitude,
        longitude: _currentPosition?.longitude,
        signatureimage: "",
        cameraimage: "${pickedFile}",
        summaryRemarks: "",
        addressLine1: getCustomerByCodeModel.first.addressLine1 ?? "",
        fBillDiscount: 0,
        fDiscountPerc: 0,
        currencyValue: 0,
        authorizedSignature: "",
        authorizedImage: "",
        cameraImage: "",
        signImage: "",
        signImgBase64String: "",
        cameraImgBase64String: "",
        authImgBase64String: "",
      );
      await controller.salesOrderApi();
    }
  }

  onPressedInvoiceValue() async {
    FocusScope.of(context).unfocus();
    if (controller.productService.catalogueProductSelectedListItems.isEmpty) {
      Get.snackbar(
        margin: const EdgeInsets.all(20),
        backgroundColor: MyColors.primaryCustom,
        "Please Select Atleast One Product",
        "Your Product List is empty",
        colorText: MyColors.white,
        icon: const Icon(
          Icons.error,
          color: MyColors.white,
        ),
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.TOP,
      );
    } else {
      controller.createInvoice = Invoice(
        invoiceDetail:
            controller.productService.catalogueProductSelectedListItems
                .map((e) => InvoiceDetail(
                      orgId: orgId,
                      tranNo: "",
                      slNo: e.slNo,
                      productCode: e.productCode,
                      productName: e.productName,
                      boxCount: e.boxCount ?? 0,
                      pcsQty: e.pcsPerCarton,
                      qty: e.unitCount,
                      foc: 0,
                      exchange: 0,
                      boxPrice: e.sellingBoxCost,
                      price: price,
                      total: grandTotal,
                      itemDiscount: 0,
                      itemDiscountPerc: 0,
                      subTotal: price,
                      tax: taxValue,
                      netTotal: grandTotal,
                      fPrice: price,
                      fBoxPrice: 0,
                      fTotal: grandTotal,
                      fTax: taxValue,
                      fNetTotal: grandTotal,
                      createdBy: "ad",
                      createdOn: currentDate,
                      changedBy: "ad",
                      changedOn: currentDate,
                      stockQty: 0,
                      stockBoxQty: 0,
                      taxPerc: 0.00,
                      remarks: "",
                      boxQty: e.boxCount ?? 0,
                      fSubTotal: price,
                      fItemDiscount: 0,
                      stockPcsQty: 0,
                      fItemDiscountPerc: 0,
                      isWeight: false,
                      fBillDiscount: 0.00,
                      haveBatch: false,
                      haveExpiryDate: false,
                      haveMfDate: false,
                      haveSerialNo: false,
                      taXCode: 0,
                      wQty: 0.00,
                    ))
                .toList(),
        orgId: orgId,
        orderNo: "",
        paymentType: '',
        paidAmount: 0.00,
        orderDateString: currentDate,
        orderDate: currentDate,
        balanceAmount: grandTotal,
        cashRegisterCode: "",
        creditLimit:
            getCustomerByCodeModel.first.creditLimit?.toDouble() ?? 0.00,
        customerEmail: getCustomerByCodeModel.first.mail ?? "",
        dONo: "",
        fBalanceAmount: 0.00,
        fPaidAmount: 0.00,
        invoiceBatchDetail: [],
        isDraft: "",
        outStanding:
            getCustomerByCodeModel.first.outstandingAmount?.toDouble() ?? 0.00,
        pLNo: "",
        roundOff: "",
        salesman: "",
        settlementNo: "",
        sONo: "",
        sQNo: "",
        tranNo: "",
        tranDate: currentDate,
        customerId: getCustomerByCodeModel.first.code ?? "",
        customerName: getCustomerByCodeModel.first.name ?? "",
        customerAddress:
            '${getCustomerByCodeModel.first.addressLine1}${getCustomerByCodeModel.first.addressLine2}${getCustomerByCodeModel.first.addressLine3}',
        locationCode: "HO",
        taxCode: int.parse(
          getCustomerByCodeModel.first.taxTypeId ?? "",
        ),
        taxType: getCustomerByCodeModel.first.taxType ?? "",
        taxPerc: taxValue,
        currencyCode: getCustomerByCodeModel.first.currencyId ?? "SGD",
        currencyRate: 1,
        total: grandTotal,
        discount: 0,
        discountPerc: 0,
        subTotal: price,
        tax: taxValue,
        netTotal: grandTotal,
        fTotal: grandTotal,
        fDiscount: 0,
        fSubTotal: price,
        fTax: taxValue,
        fNetTotal: grandTotal,
        remarks: "",
        referenceNo: "",
        createdFrom: "Web",
        isActive: true,
        createdBy: "ad",
        createdOn: currentDate,
        changedBy: "ad",
        changedOn: currentDate,
        assignTo: "",
        tranDateString: "",
        isUpdate: true,
        customerShipToId: 0,
        customerShipToAddress: getCustomerByCodeModel.first.addressLine1 ?? "",
        priceSettingCode: "",
        termCode: "",
        invoiceType: true,
        billDiscount: 0,
        latitude: _currentPosition?.latitude,
        longitude: _currentPosition?.longitude,
        signatureimage: "",
        cameraimage: "${pickedFile}",
        summaryRemarks: "",
        fBillDiscount: 0,
        fDiscountPerc: 0,
        currencyValue: 0,
        authorizedSignature: "",
        authorizedImage: "",
        cameraImage: "",
        signImage: "",
        signImgBase64String: "",
        cameraImgBase64String: "",
        authImgBase64String: "",
      );
      await controller.invoiceApi();
    }
  }
}
