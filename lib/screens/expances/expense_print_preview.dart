import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/preferenceHelper.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/RequestModel/CreateSalesOrderModel.dart';
import 'package:erp/screens/sales/salesorderother/print_preview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrintPreviewScreen extends StatefulWidget {
  const PrintPreviewScreen({
    super.key,
  });

  @override
  State<PrintPreviewScreen> createState() => _PrintPreviewScreenState();
}

class _PrintPreviewScreenState extends State<PrintPreviewScreen> {
  late SalesOrder salesOrderListModel;
  late PrintPreviewController printPreviewController;

  String? companyName;
  String? companyBranchName;

  @override
  void initState() {
    super.initState();
    getUserData();
    salesOrderListModel = Get.arguments as SalesOrder;
    printPreviewController = Get.put(PrintPreviewController());
    printPreviewController.getSalesOrderListCode(salesOrderListModel.tranNo);
  }

  calculation() {}
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrintPreviewController>(builder: (logic) {
      if (logic.status.isLoading == true ||
          logic.status.isLoadingMore == true) {
        return Container(
          color: MyColors.white,
          child: Center(
            child: CustomGradient(child: CircularProgressIndicator()),
          ),
        );
      }
      return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leading: GestureDetector(
              onTap: () {
                Get.offAndToNamed(AppRoutes.salesOrderList);
              },
              child: Image.asset(
                IconAssets.leftIcon,
                color: MyColors.white,
                scale: 1.3,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: IconButton(
                  icon:
                      const Icon(Icons.print, color: MyColors.white, size: 30),
                  onPressed: () {},
                ),
              ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       Get.back();
              //     });
              //   },
              //   child: Image.asset(
              //     IconAssets.backArrow,
              //     scale: 2,
              //     fit: BoxFit.fill,
              //   ),
              // ),
            ],
            title: const Text('Sales Order'),
            titleTextStyle: TextStyle(
                fontFamily: MyFont.myFont2,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.white),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: CustomGradient(
                    child: Text(companyName ?? "",
                        // "JAY & B TRADING PTE LTD",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: MyColors.mainTheme)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8),
                  child: CustomGradient(
                    child: Text(companyBranchName ?? "",
                        // "JNB lINK POSITION",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: MyColors.mainTheme)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width(context) / 3.5,
                                child: CustomGradient(
                                  child: Text(
                                    "SalesOrder No",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontFamily: MyFont.myFont2,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        color: MyColors.mainTheme),
                                  ),
                                ),
                              ),
                              CustomGradient(
                                child: Text(
                                  " :  ",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: MyFont.myFont2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                      color: MyColors.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width(context) / 2,
                            child: Text(
                              salesOrderListModel.tranNo ?? "",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                  color: MyColors.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width(context) / 3.5,
                                child: CustomGradient(
                                  child: Text(
                                    "SalesOrder Date",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontFamily: MyFont.myFont2,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        color: MyColors.mainTheme),
                                  ),
                                ),
                              ),
                              CustomGradient(
                                child: Text(
                                  " :  ",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: MyFont.myFont2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                      color: MyColors.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width(context) / 2,
                            child: Text(
                              formatDate(
                                salesOrderListModel.tranDate
                                        ?.substring(0, 10) ??
                                    "",
                              ),
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                letterSpacing: 0.5,
                                color: MyColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width(context) / 3.5,
                                child: CustomGradient(
                                  child: Text(
                                    "Customer Code",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontFamily: MyFont.myFont2,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        color: MyColors.mainTheme),
                                  ),
                                ),
                              ),
                              CustomGradient(
                                child: Text(
                                  " :  ",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: MyFont.myFont2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                      color: MyColors.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width(context) / 2,
                            child: Text(
                              salesOrderListModel.customerId ?? "",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                  color: MyColors.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width(context) / 3.5,
                                child: CustomGradient(
                                  child: Text(
                                    "Customer Name",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontFamily: MyFont.myFont2,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: 0.5,
                                        color: MyColors.mainTheme),
                                  ),
                                ),
                              ),
                              CustomGradient(
                                child: Text(
                                  " :  ",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: MyFont.myFont2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                      color: MyColors.black),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width(context) / 2,
                            child: Text(
                              salesOrderListModel.customerName ?? "",
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  letterSpacing: 0.5,
                                  color: MyColors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      MyColors.gradient1,
                      MyColors.gradient2,
                      MyColors.gradient3,
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(0.5),
                          1: FlexColumnWidth(0.8),
                          2: FlexColumnWidth(0.5),
                          3: FlexColumnWidth(0.5),
                          4: FlexColumnWidth(0.5),
                          5: FlexColumnWidth(0.5),
                          6: FlexColumnWidth(0.5),
                        },
                        children: [
                          TableRow(children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'SlNo.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: MyFont.myFont2),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Description',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: MyFont.myFont2),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'CQty',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: MyFont.myFont2),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'LQty',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: MyFont.myFont2),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Qty',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: MyFont.myFont2),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'CPrice',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: MyFont.myFont2),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'LPrice',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: MyFont.myFont2),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                productDetailsList(),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width(context) / 5,
                                    child: CustomGradient(
                                      child: Text(
                                        "Sub Total",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily: MyFont.myFont2,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            letterSpacing: 0.5,
                                            color: MyColors.mainTheme),
                                      ),
                                    ),
                                  ),
                                  CustomGradient(
                                    child: Text(
                                      " :  ",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontFamily: MyFont.myFont2,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          letterSpacing: 0.5,
                                          color: MyColors.black),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: width(context) / 4,
                                child: Text(
                                  "\$ ${salesOrderListModel.subTotal?.toStringAsFixed(2) ?? ""}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: MyFont.myFont2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                      color: MyColors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width(context) / 5,
                                    child: CustomGradient(
                                      child: Text(
                                        "Tax",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily: MyFont.myFont2,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            letterSpacing: 0.5,
                                            color: MyColors.mainTheme),
                                      ),
                                    ),
                                  ),
                                  CustomGradient(
                                    child: Text(
                                      " :  ",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontFamily: MyFont.myFont2,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          letterSpacing: 0.5,
                                          color: MyColors.black),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: width(context) / 4,
                                child: Text(
                                  "\$ ${salesOrderListModel.tax?.toStringAsFixed(2) ?? ""}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: MyFont.myFont2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                      color: MyColors.black),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width(context) / 5,
                                    child: CustomGradient(
                                      child: Text(
                                        "Net Total ",
                                        style: TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily: MyFont.myFont2,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            letterSpacing: 0.5,
                                            color: MyColors.mainTheme),
                                      ),
                                    ),
                                  ),
                                  CustomGradient(
                                    child: Text(
                                      " :  ",
                                      style: TextStyle(
                                          decoration: TextDecoration.none,
                                          fontFamily: MyFont.myFont2,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          letterSpacing: 0.5,
                                          color: MyColors.black),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: width(context) / 4,
                                child: Text(
                                  "\$ ${salesOrderListModel.netTotal?.toStringAsFixed(2) ?? ""}",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      fontFamily: MyFont.myFont2,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      letterSpacing: 0.5,
                                      color: MyColors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width(context) / 5,
                            child: CustomGradient(
                              child: Text(
                                "Remarks",
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: MyFont.myFont2,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                    color: MyColors.mainTheme),
                              ),
                            ),
                          ),
                          Text(
                            " :     ",
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                letterSpacing: 0.5,
                                color: MyColors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: width(context) / 1.7,
                        child: Text(
                          " ${salesOrderListModel.remarks ?? ""}",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              color: MyColors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ));
    });
  }

  productDetailsList() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: printPreviewController
            .salesOrderListCodeModel.value?.first.salesOrderDetail?.length,
        itemBuilder: (context, index) {
          var qty = printPreviewController.salesOrderListCodeModel.value?.first
              .salesOrderDetail?[index].boxQty;
          return Container(
            color: MyColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(0.5),
                    1: FlexColumnWidth(0.8),
                    2: FlexColumnWidth(0.5),
                    3: FlexColumnWidth(0.5),
                    4: FlexColumnWidth(0.5),
                    5: FlexColumnWidth(0.5),
                    6: FlexColumnWidth(0.5),
                  },
                  children: [
                    TableRow(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${printPreviewController.salesOrderListCodeModel.value?.first.salesOrderDetail?[index].slNo ?? ""}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          printPreviewController
                                  .salesOrderListCodeModel
                                  .value
                                  ?.first
                                  .salesOrderDetail?[index]
                                  .productName ??
                              "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${printPreviewController.salesOrderListCodeModel.value?.first.salesOrderDetail?[index].boxQty ?? ""}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${printPreviewController.salesOrderListCodeModel.value?.first.salesOrderDetail?[index].pcsQty ?? ""}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${printPreviewController.salesOrderListCodeModel.value?.first.salesOrderDetail?[index].qty ?? ""}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          printPreviewController.salesOrderListCodeModel.value
                                  ?.first.salesOrderDetail?[index].boxPrice
                                  ?.toStringAsFixed(2) ??
                              "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          printPreviewController.salesOrderListCodeModel.value
                                  ?.first.salesOrderDetail?[index].price
                                  ?.toStringAsFixed(2) ??
                              "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: MyFont.myFont2),
                        ),
                      ),
                    ]),
                  ],
                ),
                const Divider(
                  thickness: 0.5,
                  color: MyColors.greyText,
                )
              ],
            ),
          );
        });
  }

  getUserData() async {
    await PreferenceHelper.getUserData().then((value) {
      companyName = value?.organisationName;
    });
    companyBranchName = await PreferenceHelper.getBranchNameString();
    print(companyBranchName);
    print("companyBranchName__________________________________");
  }
}
