import 'dart:convert';
import 'dart:io';

import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/screens/sales/salesorder/add/AddSalesCustomer/customersalescontroller.dart';
import 'package:erp/screens/sales/salesorder/add/AddSalesProduct/productsalescontroller.dart';
import 'package:erp/screens/sales/salesorder/add/AddSalesSummary/summary_sales_controller.dart';
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
import '../../../../../Model/RequestModel/CreateSalesOrderModel.dart';
import '../../../../../Model/RequestModel/SalesOrderDetail.dart';

class SummarySales extends StatefulWidget {
  const SummarySales({super.key});

  @override
  State<SummarySales> createState() => _SummarySalesState();
}

class _SummarySalesState extends State<SummarySales> {
  late CustomerSalesController customerController;
  late SummarySalesController controller;
  late SalesProductController productController;

  SignatureCImage? sign1;
  XFile? pickedFile;

  final geoLocator =
      Geolocator.getCurrentPosition(forceAndroidLocationManager: true);
  Position? _currentPosition;
  String currentAddress = "";
  String address = "";

  double? summaryNetTotal;
  double? summaryTotalPrice;

  double taxValue = 0;
  double cartonTotal = 0;
  double unitTotal = 0;
  double price = 0;

  double totalCount = 0;
  double grandTotal = 0;
  double finalTotalPrice = 0;

  String? customerSignature;
  String? userSignature;
  String? trnasNo = "";

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  int? orgId;
  String? branchCode;

  LoginUserModel? userDetail;

  bool isAddProduct = false;

  initialiseData() async {
    await PreferenceHelper.getUserData().then((value) {
      setState(() {
        userDetail = value;
        orgId = userDetail?.orgId;
        branchCode = userDetail?.branchCode;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initialiseData();
    locationPermission();
    controller = Get.put(SummarySalesController());
    customerController = Get.find<CustomerSalesController>();
    if (customerController.customerAddressLine1Controller.text.isEmpty &&
        customerController.customerAddressLine2Controller.text.isEmpty &&
        customerController.customerAddressLine3Controller.text.isEmpty) {
      address = '';
    } else {
      address =
          '${customerController.customerAddressLine1Controller.text},${customerController.customerAddressLine2Controller.text},${customerController.customerAddressLine3Controller.text}';
    }
    productController = Get.find<SalesProductController>();
    SalesOrder? productCodePassing = Get.arguments as SalesOrder?;
    if (productCodePassing != null) {
      // productController.salesOrderByCodeList(productCodePassing.tranNo);
      // productCodePassing.salesOrderDetail?.first.productName;
      controller.productList = productController.productList;
      trnasNo = productController.tranNumbar;

      print(
          "${customerController.getCustomerByCodeList.value?.first.taxTypeId}::>:>:>:>:");
      print(customerController.getCustomerByCodeList.value?.first.taxTypeId);

      print(
          "${customerController.getCustomerByCodeList.value?.first.taxTypeId}::>:>:>:>:");

      print("122222");
      isAddProduct = true;
      print("122222");
    } else {
      print("99999999999999");
      isAddProduct = false;
      controller.productList = controller.productService.productListItems;
    } // customerController.isCusSelected = true;
    // productController.isProductSelect = true;
    controller.isSumSelected = false;
    controller.productService.salesOrderDetailListChangeStream.listen((_) {
      setState(() {});
    });
    controller
        .getTaxDetails(
            customerController.getCustomerByCodeList.value?.first.taxTypeId)
        .then(
      (value) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double taxValue = 0.00;
    double cartonTotalPrice = 0.00;
    double unitTotalPrice = 0.00;
    double grandTotal = 0.00;
    double price = 0.00;

    for (var element in controller.productList ?? []) {
      unitTotalPrice += (element.pcsQty! * element.price!);
      cartonTotalPrice += (element.boxQty! * element.boxPrice!);
      price = unitTotalPrice + cartonTotalPrice;
      taxValue =
          (price * double.parse(controller.taxPercentage.toString())) / 100;
      if (controller.taxName == "Inclusive") {
        grandTotal = price;
      } else if (controller.taxName == "Exclusive") {
        grandTotal = price + taxValue;
      } else if (controller.taxName == "GSTs") {
        grandTotal = price + taxValue;
      } else {
        grandTotal = price + taxValue;
      }
    }

    return GetBuilder<SummarySalesController>(builder: (logic) {
      if (logic.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CustomGradient(child: CircularProgressIndicator()),
          ),
        );
      }
      return Scaffold(
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
                        price.toStringAsFixed(2),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                                customerController.customerNameController.text,
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
                              customerController.customerCodeController.text,
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
                              address,
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
                        customerController.dateController.text,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: MyColors.black),
                      ),
                    ]),
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
                                    fontSize: 14,
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

                            Uint8List customerSignatureUint8List =
                                Uint8List.fromList(
                                    sign1!.customerSignatureExportedImage!);
                            customerSignature =
                                base64Encode(customerSignatureUint8List);
                            Uint8List userSignatureUint8List =
                                Uint8List.fromList(
                                    sign1!.userSignatureExportedImage!);
                            userSignature =
                                base64Encode(userSignatureUint8List);
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
                    onPressed: () {
                      print("Reference");
                      print(controller
                          .productService.productListItems.first.boxCount);
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
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      elevation: 0,
                    ),
                    onPressed: () {
                      if (isAddProduct == true) {
                        print('iiiiiiiiiiiiiiiiiiiiiii');
                        FocusScope.of(context).unfocus();
                        if (controller.productList != null) {
                          if (controller.productList!.isEmpty) {
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
                            print('}}}}}}}}}}}]');
                            controller.createSalesOrder = SalesOrder(
                              salesOrderDetail: controller.productList ??
                                  []
                                      .map((e) => SalesOrderDetail(
                                            orgId: e.orgId,
                                            tranNo: trnasNo,
                                            slNo: e.slNo,
                                            productCode: e.productCode,
                                            productName: e.productName,
                                            boxCount: e.boxCount ?? 0,
                                            pcsQty: e.pcsQty,
                                            qty: e.qty,
                                            foc: 0,
                                            exchange: 0,
                                            boxPrice: e.boxPrice,
                                            price: e.price,
                                            total: e.total,
                                            itemDiscount: 0,
                                            itemDiscountPerc: 0,
                                            subTotal: e.subTotal,
                                            tax: e.tax,
                                            netTotal: e.netTotal,
                                            fPrice: e.subTotal,
                                            fBoxPrice: 0,
                                            fTotal: e.subTotal,
                                            fTax: e.tax,
                                            fNetTotal: e.netTotal,
                                            createdBy: "ad",
                                            createdOn: currentDate,
                                            changedBy: "ad",
                                            changedOn: currentDate,
                                            stockQty: 0,
                                            stockBoxQty: 0,
                                            remarks: "",
                                            boxQty: e.boxQty ?? 0,
                                            fSubTotal: e.subTotal,
                                            fItemDiscount: 0,
                                            stockPcsQty: 0,
                                            fItemDiscountPerc: 0,
                                            isWeight: false,
                                            weight: 0,
                                          ))
                                      .toList(),
                              tranNo: trnasNo,
                              orgId: orgId,
                              status: 0,
                              addressLine1: customerController
                                      .getCustomerByCodeList
                                      .value
                                      ?.first
                                      .addressLine1 ??
                                  "",
                              tranDate: currentDate,
                              customerId: customerController
                                      .getCustomerByCodeList
                                      .value
                                      ?.first
                                      .code ??
                                  "",
                              customerName: customerController
                                      .getCustomerByCodeList
                                      .value
                                      ?.first
                                      .name ??
                                  "",
                              customerAddress:
                                  '${customerController.getCustomerByCodeList.value?.first.addressLine1}${customerController.getCustomerByCodeList.value?.first.addressLine2}${customerController.getCustomerByCodeList.value?.first.addressLine3}',
                              locationCode: "$branchCode",
                              taxCode: int.parse(
                                customerController.getCustomerByCodeList.value
                                        ?.first.taxTypeId ??
                                    "",
                              ),
                              taxType: controller.tax ?? "",
                              taxPerc: controller.taxPercentage,
                              currencyCode: customerController
                                      .getCustomerByCodeList
                                      .value
                                      ?.first
                                      .currencyId ??
                                  "SGD",
                              currencyRate: 1,
                              total: price,
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
                              createdFrom: "M",
                              isActive: true,
                              createdBy: "ad",
                              createdOn: currentDate,
                              changedBy: "ad",
                              changedOn: currentDate,
                              assignTo: "",
                              tranDateString: "",
                              isUpdate: true,
                              customerShipToId: 0,
                              customerShipToAddress:
                                  "${customerController.getCustomerByCodeList.value?.first.addressLine1 ?? ""}"
                                  ","
                                  "${customerController.getCustomerByCodeList.value?.first.addressLine1 ?? ""}"
                                  ","
                                  "${customerController.getCustomerByCodeList.value?.first.addressLine1 ?? ""}",
                              priceSettingCode: "",
                              termCode: "",
                              invoiceType: true,
                              billDiscount: 0,
                              latitude: _currentPosition?.latitude,
                              longitude: _currentPosition?.longitude,
                              signatureimage: customerSignature ?? "",
                              cameraimage: pickedFile?.path ?? "",
                              summaryRemarks: "",
                              fBillDiscount: 0,
                              fDiscountPerc: 0,
                              currencyValue: 0,
                              authorizedSignature: "",

                              ///user sign
                              authorizedImage: "",
                              cameraImage: "",
                              signImage: "",
                              signImgBase64String: "",
                              cameraImgBase64String: "",
                              authImgBase64String: "",
                            );
                            controller.salesOrderApi();
                          }
                        } else {
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
                        }
                      } else {
                        print('iiiiiiiiiiiiiiiiiiiiiii');
                        FocusScope.of(context).unfocus();
                        if (controller
                            .productService.productListItems.isEmpty) {
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
                          print('}}}}}}}}}}}]');
                          controller.createSalesOrder = SalesOrder(
                            salesOrderDetail:
                                controller.productService.productListItems
                                    .map((e) => SalesOrderDetail(
                                          orgId: e.orgId,
                                          tranNo: "",
                                          slNo: e.slNo,
                                          productCode: e.productCode,
                                          productName: e.productName,
                                          boxCount: e.boxCount ?? 0,
                                          pcsQty: e.pcsQty,
                                          qty: e.qty,
                                          foc: 0,
                                          exchange: 0,
                                          boxPrice: e.boxPrice,
                                          price: e.price,
                                          total: e.total,
                                          itemDiscount: 0,
                                          itemDiscountPerc: 0,
                                          subTotal: e.subTotal,
                                          tax: e.tax,
                                          netTotal: e.netTotal,
                                          fPrice: e.subTotal,
                                          fBoxPrice: 0,
                                          fTotal: e.subTotal,
                                          fTax: e.tax,
                                          fNetTotal: e.netTotal,
                                          createdBy: "ad",
                                          createdOn: currentDate,
                                          changedBy: "ad",
                                          changedOn: currentDate,
                                          stockQty: 0,
                                          stockBoxQty: 0,
                                          remarks: "",
                                          boxQty: e.boxQty ?? 0,
                                          fSubTotal: e.subTotal,
                                          fItemDiscount: 0,
                                          stockPcsQty: 0,
                                          fItemDiscountPerc: 0,
                                          isWeight: false,
                                          weight: 0,
                                        ))
                                    .toList(),
                            tranNo: "",
                            orgId: orgId,
                            status: 0,
                            addressLine1: customerController
                                    .getCustomerByCodeList
                                    .value
                                    ?.first
                                    .addressLine1 ??
                                "",
                            tranDate: currentDate,
                            customerId: customerController
                                    .getCustomerByCodeList.value?.first.code ??
                                "",
                            customerName: customerController
                                    .getCustomerByCodeList.value?.first.name ??
                                "",
                            customerAddress:
                                '${customerController.getCustomerByCodeList.value?.first.addressLine1}${customerController.getCustomerByCodeList.value?.first.addressLine2}${customerController.getCustomerByCodeList.value?.first.addressLine3}',
                            locationCode: "$branchCode",
                            taxCode: int.parse(
                              customerController.getCustomerByCodeList.value
                                      ?.first.taxTypeId ??
                                  "",
                            ),
                            taxType: controller.tax ?? "",
                            taxPerc: controller.taxPercentage,
                            currencyCode: customerController
                                    .getCustomerByCodeList
                                    .value
                                    ?.first
                                    .currencyId ??
                                "SGD",
                            currencyRate: 1,
                            total: price,
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
                            createdFrom: "M",
                            isActive: true,
                            createdBy: "ad",
                            createdOn: currentDate,
                            changedBy: "ad",
                            changedOn: currentDate,
                            assignTo: "",
                            tranDateString: "",
                            isUpdate: true,
                            customerShipToId: 0,
                            customerShipToAddress:
                                "${customerController.getCustomerByCodeList.value?.first.addressLine1 ?? ""}"
                                ","
                                "${customerController.getCustomerByCodeList.value?.first.addressLine1 ?? ""}"
                                ","
                                "${customerController.getCustomerByCodeList.value?.first.addressLine1 ?? ""}",
                            priceSettingCode: "",
                            termCode: "",
                            invoiceType: true,
                            billDiscount: 0,
                            latitude: _currentPosition?.latitude,
                            longitude: _currentPosition?.longitude,
                            signatureimage: customerSignature ?? "",
                            cameraimage: pickedFile?.path ?? "",
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
                          controller.salesOrderApi();
                        }
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
                height: 20,
              ),
            ],
          ),
        ),
      );
    });
  }

  listView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: MyColors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(0.3),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(0.2),
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
        const SizedBox(height: 20),
        SizedBox(
          // height: height(context) / 3.5,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.productList?.length,
              itemBuilder: (context, index) {
                SalesOrderDetail? values = controller.productList?[index];
                if (controller.productList != null) {
                  controller.summaryListUnitPrice =
                      values!.pcsQty! * values.price!;
                  controller.summaryListCartPrice =
                      values.boxQty! * values.boxPrice!;
                  controller.total = controller.summaryListUnitPrice +
                      controller.summaryListCartPrice;
                }

                return GestureDetector(
                  onTapDown: (position) {
                    // _getTapPosition(position);
                    // _showContextMenu(context, index);
                  },
                  child: Container(
                    // color: MyColors.greyText,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(0.3),
                            1: FlexColumnWidth(),
                            2: FlexColumnWidth(0.2),
                          },
                          children: [
                            TableRow(children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  values?.productCode ?? "",
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
                                  values?.productName ?? "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: MyFont.myFont2),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  child: const Icon(
                                    Icons.clear,
                                    size: 20,
                                    color: MyColors.red,
                                  ),
                                  onTap: () {
                                    if (index >= 0 &&
                                        index <
                                            controller.productList!.length) {
                                      setState(() {
                                        controller.productList?.removeAt(index);
                                      });
                                    }
                                  },
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
                                  values?.boxQty?.toStringAsFixed(0) ?? "0",
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
                                  values?.pcsQty?.toStringAsFixed(0) ?? "0",
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
                                  values?.qty?.toStringAsFixed(0) ?? "0",
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
                                  values?.boxPrice?.toStringAsFixed(2) ??
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
                                  values?.price?.toStringAsFixed(2) ?? "0.00",
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
                                  controller.total.toStringAsFixed(2) ?? "0.00",
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
                  ),
                );
              }),
        ),
      ],
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
      // PreferenceHelper.showSnackBar(context: context, msg: 'Permission Required');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Permission Required'),
      ));
    }
    if (locationStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }
}
