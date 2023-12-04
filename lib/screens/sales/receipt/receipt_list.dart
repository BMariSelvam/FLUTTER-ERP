import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/RequestModel/CreateReceiptModel.dart';
import 'package:erp/screens/sales/receipt/receipt_list_controller.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:erp/widgets/search_dropdown_textfield2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../Helper/preferencehelper.dart';

class ReceiptList extends StatefulWidget {
  const ReceiptList({Key? key}) : super(key: key);

  @override
  State<ReceiptList> createState() => _ReceiptListState();
}

class _ReceiptListState extends State<ReceiptList> {
  late ReceiptListController listController;
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? customerCode;
  String date = "";
  String toDate = "";

  @override
  void initState() {
    super.initState();
    listController = Get.put(ReceiptListController());
    listController.getReceiptCustomerList("");
    listController.receiptListGet(
        customerCode: "",
        searchFromDate: currentDate,
        searchToDate: currentDate,
        isSearch: false);
    listController.isSelectedFilter = true;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiptListController>(builder: (logic) {
      if (logic.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CustomGradient(child: CircularProgressIndicator()),
          ),
        );
      }
      return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leading: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.bottomNavBarScreen);
              },
              child: Image.asset(
                IconAssets.leftIcon,
                color: MyColors.white,
                scale: 1.3,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  listController.isSelectedFilter
                      ? Icons.filter_alt_outlined
                      : Icons.filter_alt_off_outlined,
                  color: MyColors.white,
                  size: 35,
                ),
                onPressed: () {
                  setState(() {
                    listController.isSelectedFilter =
                        !listController.isSelectedFilter;
                    listController.clearData();
                    listController.receiptListGet(
                        customerCode: "",
                        searchFromDate: currentDate,
                        searchToDate: currentDate,
                        isSearch: false);
                  });
                },
              ),
            ],
            titleSpacing: -15,
            title: Text(
              "Receipt ",
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
              child: Column(children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Receipt',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.bold,
                          color: MyColors.heading354038),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.addReceipt);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 4),
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
                                IconAssets.personAddIcon,
                                scale: 1.6,
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
                  ]),
            ),
            listController.isSelectedFilter
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Obx(() {
                            return SearchDropdownTextField2<GetCustomerModel>(
                                hintText: 'Select Customer',
                                hintTextStyle: TextStyle(
                                  fontFamily: MyFont.myFont2,
                                  color: MyColors.black,
                                  fontSize: 13,
                                ),
                                textStyle: TextStyle(
                                  fontFamily: MyFont.myFont2,
                                  color: MyColors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                                // prefixIcon: const Icon(
                                //   Icons.search,
                                //   color: MyColors.red,
                                // ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      listController.clearData();
                                      listController.receiptListGet(
                                          customerCode: "",
                                          searchFromDate: "",
                                          searchToDate: "",
                                          isSearch: false);
                                    });
                                  },
                                  child: const Icon(
                                    Icons.clear,
                                    color: MyColors.red,
                                  ),
                                ),
                                inputBorder: BorderSide.none,
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                items: listController.customerListModel.value,
                                color: Colors.black54,
                                selectedItem: listController.customerList,
                                isValidator: true,
                                onAddPressed: () {
                                  setState(() {
                                    listController.customerName = "";
                                    listController.customerList = null;
                                  });
                                },
                                onChanged: (value) {
                                  FocusScope.of(context).unfocus();
                                  listController.customerList = value;
                                  listController.customerName = value.name;
                                  setState(() {
                                    listController.customerName = value.name;
                                    listController.customerCodecontroller.text =
                                        value.code ?? "";
                                    customerCode = value.code;
                                  });
                                });
                          }),
                        ),
                        CustomTextField2(
                          inputBorder: const OutlineInputBorder(),
                          controller: listController.customerCodecontroller,
                          keyboardType: TextInputType.text,
                          labelText: "Customer Code",
                          hintText: 'Customer Code',
                          filled: false,
                          readOnly: true,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField2(
                                controller: listController.fromDatecontroller,
                                labelText: "From Date",
                                hintText: "From Date",
                                readOnly: true,
                                inputFormatters: const [],
                                suffixIcon:
                                    const Icon(Icons.calendar_month_outlined),
                                onTap: () async {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                  ).then((value) {
                                    setState(() {
                                      listController.selectedDate = value!;
                                      listController.fromDatecontroller.text =
                                          '${listController.selectedDate.day}-${listController.selectedDate.month}-${listController.selectedDate.year}';
                                      listController.date =
                                          '${listController.selectedDate.year}-${listController.selectedDate.month}-${listController.selectedDate.day}';
                                    });
                                  });
                                },
                                obscureText: false,
                                filled: false,
                              ),
                            ),
                            Expanded(
                              child: CustomTextField2(
                                controller: listController.toDatecontroller,
                                labelText: "To Date",
                                hintText: "To Date",
                                readOnly: true,
                                inputFormatters: const [],
                                suffixIcon:
                                    const Icon(Icons.calendar_month_outlined),
                                onTap: () async {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate:
                                              listController.selectedDate,
                                          lastDate: DateTime.now())
                                      .then((value) {
                                    setState(() {
                                      listController.selectedToDate = value!;
                                      listController.toDatecontroller.text =
                                          '${listController.selectedToDate.day}-${listController.selectedToDate.month}-${listController.selectedToDate.year}';

                                      listController.toDate =
                                          '${listController.selectedToDate.year}-${listController.selectedToDate.month}-${listController.selectedToDate.day}';
                                    });
                                  });
                                },
                                obscureText: false,
                                filled: false,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (listController.customerList != null) {
                              listController.receiptListGet(
                                  customerCode: customerCode ?? "",
                                  searchFromDate: listController.date,
                                  searchToDate: listController.toDate,
                                  isSearch: true);
                            } else {
                              Get.showSnackbar(
                                const GetSnackBar(
                                  margin: EdgeInsets.all(10),
                                  borderRadius: 10,
                                  backgroundColor: Colors.red,
                                  snackPosition: SnackPosition.TOP,
                                  message: "Select Customer Name",
                                  icon: Icon(
                                    Icons.error,
                                    color: Colors.white,
                                  ),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: (listController.isSearchFilter == true)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 21,
                                        bottom: 21,
                                        right: 10,
                                        left: 10,
                                      ),
                                      height: height(context) / 28,
                                      width: width(context) / 15,
                                      color: MyColors.white,
                                      child: const CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.red)),
                                    ),
                                  ],
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    right: 10,
                                    left: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.red,
                                  ),
                                  child: Text(
                                    "Search",
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontFamily: MyFont.myFont2,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        letterSpacing: 0.5,
                                        color: MyColors.white),
                                  ),
                                ),
                        ),
                        const Divider(
                          thickness: 2,
                          color: MyColors.greyText,
                        ),
                      ],
                    ),
                  ),
            (listController.getReceiptList.value != null &&
                    listController.getReceiptList.value!.isNotEmpty)
                ? list()
                : Container(
                    height: listController.isSelectedFilter
                        ? height(context) / 1.3
                        : height(context) / 2,
                    alignment: Alignment.center,
                    child: Text(
                      "No Receipt",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          letterSpacing: 0.5,
                          color: MyColors.mainTheme),
                    ),
                  ),
            const SizedBox(
              height: 18,
            )
          ])));
    });
  }

  list() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listController.getReceiptList.value?.length,
        itemBuilder: (context, index) {
          // DateTime dateTime = DateFormat("yyyy-MM-dd").parse(
          //     listController.getReceiptList.value?[index].tranDate ?? '');
          // String orderDate = DateFormat("dd-MM-yyyy").format(dateTime);

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 2),
              ],
            ),
            margin: const EdgeInsets.only(
              top: 15,
              left: 18,
              right: 18,
              bottom: 0,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 15,
                        left: 15,
                        right: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Receipt Name',
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                color: MyColors.black5F5F5F),
                          ),
                          SizedBox(
                            width: width(context) / 1.8,
                            child: CustomGradient(
                              child: Text(
                                listController.getReceiptList.value?[index]
                                        .customerName ??
                                    '',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: MyFont.myFont2,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.black1D2226),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 1,
                          right: 10,
                        ),
                        padding: const EdgeInsets.only(
                          left: 1,
                          right: 3,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                MyColors.gradient1,
                                MyColors.gradient2,
                                MyColors.gradient3,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 10, top: 3, bottom: 3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const CustomGradient(
                                    child: Icon(
                                      Icons.edit_document,
                                      color: MyColors.mainTheme,
                                      size: 15,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  CustomGradient(
                                    child: Text(
                                      "Select",
                                      style: TextStyle(
                                          fontFamily: MyFont.myFont,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 9,
                                          color: MyColors.mainTheme),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            receiptEdit(
                                listController.getReceiptList.value?[index]),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, top: 5, bottom: 10, right: 5),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.4),
                      1: FlexColumnWidth(1.4)
                    },
                    children: [
                      TableRow(children: [
                        Text(
                          'Receipt Number',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: MyColors.greyText),
                        ),
                        Text('Receipt Date',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.greyText)),
                        Text('Paid Amount',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.greyText)),
                        Text('PayMode',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.greyText)),
                      ]),
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 3),
                          child: Text(
                              listController
                                      .getReceiptList.value?[index].tranNo ??
                                  '',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: MyColors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 3),
                          child: Text(
                              formatDate(listController
                                  .getReceiptList.value?[index].tranDate),
                              // orderDate,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: MyColors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 3),
                          child: Text(
                            '\$ ${listController.getReceiptList.value?[index].paidAmount?.toStringAsFixed(2) ?? '0.00'}',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: MyColors.black),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 3),
                          child: Text(
                            listController
                                    .getReceiptList.value?[index].payMode ??
                                '',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                color: MyColors.black),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  receiptEdit(Receipt? receiptModel) {
    return SizedBox(
      height: 25,
      width: 28,
      child: PopupMenuButton(
        color: MyColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 2, color: Colors.black54)),
        iconSize: 25,
        padding: const EdgeInsets.all(1),
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
          color: MyColors.white,
        ),
        offset: const Offset(0, 30),
        itemBuilder: (_) => <PopupMenuEntry>[
          // PopupMenuItem(
          //     onTap: () {
          //       Get.toNamed(AppRoutes.editReceipt, arguments: receiptModel);
          //     },
          //     height: 20,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //           Image.asset(IconAssets.editIcon),
          //           SizedBox(
          //             width: width(context) / 50,
          //           ),
          //           CustomGradient(
          //             child: Text(
          //               'Edit ',
          //               style: TextStyle(
          //                   fontFamily: MyFont.myFont2,
          //                   fontWeight: FontWeight.w900,
          //                   fontSize: 15,
          //                   color: MyColors.mainTheme),
          //             ),
          //           ),
          //         ]),
          //       ],
          //     )),
          // const PopupMenuDivider(),
          PopupMenuItem(
            onTap: () async {
              await listController.getReceiptDeleteList(receiptModel?.tranNo);
            },
            height: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        IconAssets.delete,
                        scale: 1.2,
                      ),
                      SizedBox(
                        width: width(context) / 50,
                      ),
                      CustomGradient(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: MyColors.mainTheme),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            onTap: () {
              Get.toNamed(AppRoutes.receiptPrintPreviewScreen,
                  arguments: receiptModel);
            },
            height: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        IconAssets.product,
                        scale: 2,
                      ),
                      SizedBox(
                        width: width(context) / 50,
                      ),
                      CustomGradient(
                        child: Text(
                          'Print Preview',
                          style: TextStyle(
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: MyColors.mainTheme),
                        ),
                      ),
                    ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
