import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/preferenceHelper.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/RequestModel/CreateReceiptModel.dart';
import 'package:erp/screens/sales/receipt/receipt_print_preview_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiptPrintPreviewScreen extends StatefulWidget {
  const ReceiptPrintPreviewScreen({
    super.key,
  });
  @override
  State<ReceiptPrintPreviewScreen> createState() =>
      _ReceiptPrintPreviewScreenState();
}

class _ReceiptPrintPreviewScreenState extends State<ReceiptPrintPreviewScreen> {
  late Receipt receiptListModel;
  late ReceiptPrintPreviewController printPreviewController;

  String? companyName;
  String? companyBranchName;

  @override
  void initState() {
    super.initState();
    getUserData();
    receiptListModel = Get.arguments as Receipt;
    printPreviewController = Get.put(ReceiptPrintPreviewController());
    printPreviewController.getReceiptListCode(receiptListModel.tranNo);
  }

  @override
  Widget build(BuildContext context) {
    double total = 0.00;
    double creditTotal = 0.00;
    double balanceTotal = 0.00;
    double debitTotal = 0.00;
    double netTotal = 0.00;
    for (var element in printPreviewController
            .receiptListCodeModel.value?.first.receiptDetails ??
        []) {
      netTotal += element.netTotal;
      creditTotal += element.creditAmount;
      balanceTotal += element.balaceAmount;
      debitTotal += element.debitAmount;
    }

    return GetBuilder<ReceiptPrintPreviewController>(builder: (logic) {
      if (logic.status.isLoading == true ||
          logic.status.isLoadingMore == true) {
        return Container(
          color: MyColors.white,
          child: const Center(
            child: CustomGradient(child: CircularProgressIndicator()),
          ),
        );
      }
      return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leading: GestureDetector(
              onTap: () {
                Get.offAndToNamed(AppRoutes.receiptList);
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
            title: const Text('Receipt'),
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
                                    "Receipt No",
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
                              receiptListModel.tranNo ?? "",
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
                                    "Receipt Date",
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
                                receiptListModel.tranDate?.substring(0, 10) ??
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
                              receiptListModel.customerName ?? "",
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
                                    "Customer Address",
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
                              receiptListModel.address ?? "No Address",
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
                          0: FlexColumnWidth(0.3),
                          1: FlexColumnWidth(0.5),
                          2: FlexColumnWidth(0.6),
                          3: FlexColumnWidth(0.5),
                          4: FlexColumnWidth(0.5),
                          5: FlexColumnWidth(0.5),
                          6: FlexColumnWidth(0.5),
                          7: FlexColumnWidth(0.5),
                        },
                        children: [
                          TableRow(children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'SlNo.',
                                textAlign: TextAlign.center,
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
                                'Invoice No',
                                textAlign: TextAlign.center,
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
                                'Invoice Date',
                                textAlign: TextAlign.center,
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
                                'Paid',
                                textAlign: TextAlign.center,
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
                                'Credit',
                                textAlign: TextAlign.center,
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
                                'Balance',
                                textAlign: TextAlign.center,
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
                                'Debit',
                                textAlign: TextAlign.center,
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
                                'Total',
                                textAlign: TextAlign.center,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(0.3),
                      1: FlexColumnWidth(0.5),
                      2: FlexColumnWidth(0.6),
                      3: FlexColumnWidth(0.5),
                      4: FlexColumnWidth(0.5),
                      5: FlexColumnWidth(0.5),
                      6: FlexColumnWidth(0.5),
                      7: FlexColumnWidth(0.5),
                    },
                    children: [
                      TableRow(children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '',
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
                            '',
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
                          child: CustomGradient(
                            child: Text(
                              'Total',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: MyFont.myFont2),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "\$ ${receiptListModel.paidAmount?.toStringAsFixed(2) ?? ""}",
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
                            "\$ ${creditTotal?.toStringAsFixed(2) ?? ""}",
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
                            "\$ ${balanceTotal?.toStringAsFixed(2) ?? ""}",
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
                            "\$ ${debitTotal?.toStringAsFixed(2) ?? ""}",
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
                            "\$ ${netTotal?.toStringAsFixed(2) ?? ""}",
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
                ),
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
                                "Paymode ",
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
                            ": ",
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
                          " ${receiptListModel.payMode ?? ""}",
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.all(10),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.start,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               SizedBox(
                //                 width: width(context) / 8,
                //                 child: CustomGradient(
                //                   child: Text(
                //                     "Total ",
                //                     style: TextStyle(
                //                         decoration: TextDecoration.none,
                //                         fontFamily: MyFont.myFont2,
                //                         fontWeight: FontWeight.w600,
                //                         fontSize: 12,
                //                         letterSpacing: 0.5,
                //                         color: MyColors.mainTheme),
                //                   ),
                //                 ),
                //               ),
                //               CustomGradient(
                //                 child: Text(
                //                   ": ",
                //                   style: TextStyle(
                //                       decoration: TextDecoration.none,
                //                       fontFamily: MyFont.myFont2,
                //                       fontWeight: FontWeight.w600,
                //                       fontSize: 12,
                //                       letterSpacing: 0.5,
                //                       color: MyColors.black),
                //                 ),
                //               ),
                //             ],
                //           ),
                //           SizedBox(
                //             width: width(context) / 4,
                //             child: Text(
                //               "\$ ${netTotal.toStringAsFixed(2) ?? ""}",
                //               textAlign: TextAlign.end,
                //               style: TextStyle(
                //                   decoration: TextDecoration.none,
                //                   fontFamily: MyFont.myFont2,
                //                   fontWeight: FontWeight.w600,
                //                   fontSize: 12,
                //                   letterSpacing: 0.5,
                //                   color: MyColors.black),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
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
                          " ${receiptListModel.remarks ?? ""}",
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
            .receiptListCodeModel.value?.first.receiptDetails?.length,
        itemBuilder: (context, index) {
          return Container(
            color: MyColors.white,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(0.3),
                    1: FlexColumnWidth(0.5),
                    2: FlexColumnWidth(0.6),
                    3: FlexColumnWidth(0.5),
                    4: FlexColumnWidth(0.5),
                    5: FlexColumnWidth(0.5),
                    6: FlexColumnWidth(0.5),
                    7: FlexColumnWidth(0.5),
                  },
                  children: [
                    TableRow(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "${index + 1}",
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
                          printPreviewController.receiptListCodeModel.value
                                  ?.first.receiptDetails?[index].invoiceNo ??
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
                          formatDate(printPreviewController.receiptListCodeModel
                              .value?.first.receiptDetails?[index].invoiceDate),
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
                          "\$ ${printPreviewController.receiptListCodeModel.value?.first.receiptDetails?[index].paidAmount?.toStringAsFixed(2) ?? ""}",
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
                          "\$ ${printPreviewController.receiptListCodeModel.value?.first.receiptDetails?[index].creditAmount?.toStringAsFixed(2) ?? ""}",
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
                          "\$ ${printPreviewController.receiptListCodeModel.value?.first.receiptDetails?[index].balaceAmount?.toStringAsFixed(2) ?? ""}",
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
                          "\$ ${printPreviewController.receiptListCodeModel.value?.first.receiptDetails?[index].debitAmount?.toStringAsFixed(2) ?? ""}",
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
                          "\$ ${printPreviewController.receiptListCodeModel.value?.first.receiptDetails?[index].netTotal?.toStringAsFixed(2) ?? ""}",
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
