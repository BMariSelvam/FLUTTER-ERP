import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/extension.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/preferenceHelper.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/GetAllBankModel.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/GetAllPaymodeModel.dart';
import 'package:erp/Model/LoginUserModel.dart';
import 'package:erp/Model/RequestModel/CreateReceiptModel.dart';
import 'package:erp/Model/RequestModel/ReceiptDetails.dart';
import 'package:erp/Model/RequestModel/TranDetail.dart';
import 'package:erp/screens/sales/receipt/add_receipt_controller.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:erp/widgets/search_dropdown_textfield2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddReceipt extends StatefulWidget {
  const AddReceipt({Key? key}) : super(key: key);

  @override
  State<AddReceipt> createState() => _AddReceiptState();
}

class _AddReceiptState extends State<AddReceipt> {
  late AddReceiptController addReceiptController;

  int? orgId;
  String? branchCode;
  LoginUserModel? userDetail;

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

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
    addReceiptController = Get.put(AddReceiptController());
    addReceiptController.paymodeListGet();
    addReceiptController.customerListGet();
    addReceiptController.dateController.text =
        formatDate(addReceiptController.selectedDate.toString());
    addReceiptController.isCheckedSelectAll = false;
    addReceiptController.getCustomerModel = null;

    addReceiptController.getTranDetail.value = [];

    if (addReceiptController.differenceController.text.isEmpty) {
      addReceiptController.differenceController.text == "0,00";
    }
    if (addReceiptController.selectedAmtController.text.isEmpty) {
      addReceiptController.selectedAmtController.text == "0,00";
    }
    if (addReceiptController.writeOffController.text.isEmpty) {
      addReceiptController.writeOffController.text == "0,00";
    }
    if (addReceiptController.totalPaidController.text.isEmpty) {
      addReceiptController.totalPaidController.text == "0,00";
    }
    // if (addReceiptController.differenceController.text.isEmpty &&
    //     addReceiptController.selectedAmtController.text.isEmpty &&
    //     addReceiptController.writeOffController.text.isEmpty &&
    //     addReceiptController.totalPaidController.text.isEmpty) {
    //   addReceiptController.differenceController.text == "0,00";
    //   addReceiptController.selectedAmtController.text == "0,00";
    //   addReceiptController.writeOffController.text == "0,00";
    //   addReceiptController.totalPaidController.text == "0,00";
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddReceiptController>(
      builder: (logic) {
        if (logic.status.isLoading == true) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Form(
          key: addReceiptController.addReceiptKey,
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
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                      icon: const Icon(
                        Icons.save_sharp,
                        color: MyColors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        if (addReceiptController.addReceiptKey.currentState!
                            .validate()) {
                          if (addReceiptController
                                  .totalPaidController.text.isNotEmpty &&
                              addReceiptController
                                  .selectedAmtController.text.isNotEmpty) {
                            addReceiptController.addReceiptKey.currentState!
                                .save();
                            addReceiptController.createReceiptModel = Receipt(
                              orgId: orgId,
                              customerName: '${addReceiptController.customer}',
                              tranNo: '',
                              netTotal: addReceiptController
                                      .totalPaidController.text.isNotEmpty
                                  ? double.parse(addReceiptController
                                      .totalPaidController.text)
                                  : 0.00,
                              isActive: true,
                              createdOn: currentDate,
                              createdBy: 'ad',
                              changedOn: currentDate,
                              changedBy: 'ad',
                              branchCode: branchCode,
                              customerCode: addReceiptController.customerCode,
                              tranType: 'IN',
                              remarks:
                                  addReceiptController.remarkController.text ??
                                      '',
                              accountNo: '',
                              address:
                                  addReceiptController.customerAddress ?? '',
                              advancePayment: 0,
                              bank: addReceiptController.bank ?? '',
                              bankInDate: addReceiptController
                                      .bankInDateController.text ??
                                  '',
                              bankInDateString: addReceiptController
                                      .bankInDateController.text ??
                                  '',
                              chequeDate:
                                  addReceiptController.chqDateController.text ??
                                      '',
                              chequeDatestring:
                                  addReceiptController.chqDateController.text ??
                                      '',
                              chequeNo:
                                  addReceiptController.chqNoController.text ??
                                      '',
                              chequeStatus: 1,
                              creditAmount: addReceiptController.creditAmt,
                              currencyCode: addReceiptController.currency ?? '',
                              currencyRate: 1,
                              currencyValue: 1,
                              debitAmount: 0,
                              deliveryId: 0,
                              diff: double.parse(addReceiptController
                                      .differenceController.text ??
                                  ''),
                              fAdvancePayment: 0,
                              fCreditAmount: addReceiptController.creditAmt,
                              fDebitAmount: 0,
                              fNetTotal: addReceiptController
                                      .totalPaidController.text.isNotEmpty
                                  ? double.parse(addReceiptController
                                      .totalPaidController.text)
                                  : 0.00,
                              fPaidAmount: addReceiptController
                                      .totalPaidController.text.isNotEmpty
                                  ? double.parse(addReceiptController
                                      .totalPaidController.text)
                                  : 0.00,
                              invoiceNo: '',
                              isUpdate: true,
                              moduleName: '',
                              paidAmount: addReceiptController
                                      .totalPaidController.text.isNotEmpty
                                  ? double.parse(addReceiptController
                                      .totalPaidController.text)
                                  : 0.00,
                              payMode: addReceiptController.paymode ?? '',
                              paymodeName: addReceiptController.paymode ?? '',
                              receiptDetails: addReceiptController.selectedItems
                                  .map((e) => ReceiptDetails(
                                      orgId: orgId,
                                      tranNo: '',
                                      changedOn: currentDate,
                                      changedBy: 'ad',
                                      createdOn: currentDate,
                                      createdBy: 'ad',
                                      paidAmount: e
                                              .paidController.text.isNotEmpty
                                          ? double.parse(e.paidController.text)
                                          : 0.00,
                                      netTotal: e.netTotal,
                                      advancePayment: e.advancePayment,
                                      badDebit: 0,
                                      balaceAmount: e.balanceAmount,
                                      carryDays: e.carryDays,
                                      creditAmount:
                                          e.creditController.text.isNotEmpty
                                              ? double.parse(
                                                  e.creditController.text)
                                              : 0.00,
                                      creditNote: 0,
                                      currencyCode: e.currencyCode,
                                      currencyRate: e.currencyRate,
                                      currencyValue: 1,
                                      debitAmount: e.debitAmount,
                                      discount: e
                                              .creditController.text.isNotEmpty
                                          ? double.parse(
                                              e.creditController.text)
                                          : 0.00,
                                      fAdvancePayment: e.advancePayment,
                                      fBalanceAmount: e.balanceAmount,
                                      fCreditAmount: e.creditAmount,
                                      fDebitAmount: e.debitAmount,
                                      fNetTotal: e.netTotal,
                                      fPaidAmount: e.paidAmount,
                                      invoiceDate: e.tranDate,
                                      invoiceDateString: e.tranDate,
                                      invoiceNo: e.tranNo,
                                      tranType: e.tranType))
                                  .toList(),
                              tranDate: currentDate,
                              tranDatestring: currentDate,
                              tranDetail: addReceiptController.selectedItems
                                  .map((e) => TranDetail(
                                      orgId: orgId,
                                      tranNo: '',
                                      changedOn: currentDate,
                                      changedBy: 'ad',
                                      createdOn: currentDate,
                                      createdBy: 'ad',
                                      paidAmount: e
                                              .paidController.text.isNotEmpty
                                          ? double.parse(e.paidController.text)
                                          : 0.00,
                                      netTotal: e.netTotal,
                                      advancePayment: e.advancePayment,
                                      badDebit: 0,
                                      balaceAmount: e.balanceAmount,
                                      carryDays: e.carryDays,
                                      creditAmount:
                                          e.creditController.text.isNotEmpty
                                              ? double.parse(
                                                  e.creditController.text)
                                              : 0.00,
                                      creditNote: 0,
                                      currencyCode: e.currencyCode,
                                      currencyRate: e.currencyRate,
                                      currencyValue: 1,
                                      debitAmount: e.debitAmount,
                                      discount: e
                                              .creditController.text.isNotEmpty
                                          ? double.parse(
                                              e.creditController.text)
                                          : 0.00,
                                      fAdvancePayment: e.advancePayment,
                                      fBalanceAmount: e.balanceAmount,
                                      fCreditAmount: e.creditAmount,
                                      fDebitAmount: e.debitAmount,
                                      fNetTotal: e.netTotal,
                                      fPaidAmount: e.paidAmount,
                                      invoiceDate: e.tranDate,
                                      invoiceDateString: e.tranDate,
                                      invoiceNo: e.tranNo,
                                      tranType: e.tranType))
                                  .toList(),
                              writeOff: addReceiptController
                                      .writeOffController.text.isNotEmpty
                                  ? double.parse(addReceiptController
                                      .writeOffController.text)
                                  : 0.00,
                            );
                            addReceiptController.receiptApi(context);
                          } else {
                            FocusScope.of(context).requestFocus(FocusNode());
                            Get.showSnackbar(const GetSnackBar(
                              title: 'Error',
                              backgroundColor: MyColors.red,
                              icon: Icon(
                                Icons.error,
                                color: MyColors.white,
                              ),
                              borderRadius: 15,
                              margin: EdgeInsets.all(20),
                              snackPosition: SnackPosition.TOP,
                              duration: Duration(seconds: 4),
                              messageText: Text(
                                "Total Paid is Mandatory",
                                style: TextStyle(
                                  color: MyColors.white,
                                ),
                              ),
                            ));
                          }
                        }
                      },
                      // => Get.to(const SuccessfullyMsgScreen(
                      //  name: 'Receipt Saved Successfully..!',
                      //   filename: AppRoutes.stockProductList)),
                    ))
              ],
              titleSpacing: -15,
              title: Text(
                "Receipt",
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
                          'Receipt',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              color: MyColors.heading354038),
                        ),
                        // SizedBox(width: MediaQuery.of(context).size.width * 0.4,),
                        // FlutterSwitch(
                        //     width: 100,
                        //     activeText: 'Active',
                        //     activeColor: Colors.green,
                        //     activeTextColor: MyColors.white,
                        //     showOnOff: true,
                        //     inactiveText: 'Inactive',
                        //     inactiveTextColor: Colors.white70,
                        //     value: addReceiptController.selected,
                        //     onToggle: (val) {
                        //       setState(() {
                        //         addReceiptController.selected = val;
                        //       });
                        //     })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Obx(() {
                      return SearchDropdownTextField2<GetCustomerModel>(
                          labelText: 'Select Customer',
                          hintText: 'Select atleast one Customer',
                          errorMessage: 'Select Customer',
                          suffixIcon: Icon(
                            Icons.expand_circle_down_outlined,
                            color: MyColors.black.withOpacity(0.4),
                          ),
                          items: addReceiptController.getCustomerList.value,
                          color: Colors.black54,
                          selectedItem: addReceiptController.getCustomerModel,
                          isValidator: true,
                          onAddPressed: () {
                            setState(() {
                              addReceiptController.customer = "";
                              addReceiptController.getCustomerModel = null;
                            });
                          },
                          onChanged: (value) async {
                            FocusScope.of(context).unfocus();
                            addReceiptController.getCustomerModel = value;
                            addReceiptController.customer = value.name;

                            setState(() {
                              addReceiptController.customer = value.name;
                              addReceiptController.customerCode = value.code;
                              addReceiptController.currency = value.currencyId;
                              addReceiptController.customerAddress =
                                  '${value.addressLine1}${value.addressLine2}${value.addressLine3}';

                              addReceiptController.valueController.text =
                                  value.currencyValue ?? '';
                              addReceiptController.rateController.text =
                                  value.currencyRate ?? '';
                              addReceiptController.receiptInvoiceListGet(
                                  customerCode:
                                      addReceiptController.customerCode ?? "");
                              addReceiptController.selectedAmtController
                                  .clear();
                              addReceiptController.totalPaidController.clear();
                              addReceiptController.differenceController.clear();
                              addReceiptController.writeOffController.clear();
                            });
                          });
                    }),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField2(
                          readOnly: true,
                          inputBorder: const OutlineInputBorder(),
                          labelText: "Receipt Date",
                          suffixIcon: const Icon(Icons.date_range,
                              color: MyColors.greyIcon),
                          controller: addReceiptController.dateController,
                          onTap: () async {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1800),
                                    lastDate: DateTime.now())
                                .then((value) {
                              setState(() {
                                addReceiptController.selectedDate =
                                    value ?? addReceiptController.selectedDate;
                                addReceiptController.dateController.text =
                                    '${addReceiptController.selectedDate.day}-${addReceiptController.selectedDate.month}-${addReceiptController.selectedDate.year}';
                                '${addReceiptController.selectedDate.year}-${addReceiptController.selectedDate.month}-${addReceiptController.selectedDate.day}';
                                addReceiptController.date =
                                    '${addReceiptController.selectedDate.year}-${addReceiptController.selectedDate.month}-${addReceiptController.selectedDate.day}';
                              });
                            });
                          },
                        ),
                      ),
                      // Expanded(
                      //   child: CustomTextField2(
                      //     readOnly: true,
                      //     inputBorder: const OutlineInputBorder(),
                      //     controller: addReceiptController.recNoController,
                      //     keyboardType: TextInputType.datetime,
                      //     labelText: "Receipt No",
                      //     // hintText: '8738236',
                      //     // suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded,
                      //     //     color: MyColors.greyIcon),
                      //   ),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Obx(() {
                      return SearchDropdownTextField2<GetPaymodeModel>(
                          labelText: 'Paymode',
                          suffixIcon: Icon(
                            Icons.expand_circle_down_outlined,
                            color: MyColors.black.withOpacity(0.4),
                          ),
                          items: addReceiptController.getPaymodeList.value,
                          color: Colors.black54,
                          selectedItem: addReceiptController.getPaymodeModel,
                          isValidator: true,
                          errorMessage: 'Select Paymode',
                          onAddPressed: () {
                            setState(() {
                              addReceiptController.paymode = "";
                              addReceiptController.getPaymodeModel = null;
                            });
                          },
                          onChanged: (value) async {
                            FocusScope.of(context).unfocus();
                            addReceiptController.getPaymodeModel = value;
                            addReceiptController.paymode = value.name;
                            addReceiptController.paymode == 'CHEQUE' ||
                                    addReceiptController.paymode == 'Cheque'
                                ? addReceiptController.isCheque = true
                                : addReceiptController.isCheque = false;
                            setState(() {
                              addReceiptController.paymode = value.name;
                              addReceiptController.isCheque == true
                                  ? addReceiptController.bankListGet()
                                  : [];
                            });
                            // print('addReceiptController.getPaymodeModel');
                            // print(addReceiptController.getPaymodeModel);
                            // print('addReceiptController.getPaymodeModel');
                            // print('addReceiptController.paymode');
                            // print(addReceiptController.paymode);
                            // print('addReceiptController.paymode');
                            // print('addReceiptController.isCheque');
                            // print(addReceiptController.isCheque);
                            // print('addReceiptController.isCheque');
                          });
                    }),
                  ),
                  addReceiptController.isCheque == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Obx(() {
                            return SearchDropdownTextField2<GetBankModel>(
                                labelText: 'Bank',
                                hintText: 'Select Bank',
                                suffixIcon: Icon(
                                  Icons.expand_circle_down_outlined,
                                  color: MyColors.black.withOpacity(0.4),
                                ),
                                items: addReceiptController.getBankList.value,
                                color: Colors.black54,
                                selectedItem: addReceiptController.getBankModel,
                                isValidator: true,
                                errorMessage: '*',
                                onAddPressed: () {
                                  setState(() {
                                    addReceiptController.bank = "";
                                    addReceiptController.getBankModel = null;
                                  });
                                },
                                onChanged: (value) async {
                                  FocusScope.of(context).unfocus();
                                  addReceiptController.getBankModel = value;
                                  addReceiptController.bank = value.name;

                                  setState(() {
                                    addReceiptController.bank = value.name;
                                  });
                                });
                          }),
                        )
                      : const SizedBox(),
                  addReceiptController.isCheque == true
                      ? CustomTextField2(
                          inputBorder: const OutlineInputBorder(),
                          controller: addReceiptController.chqNoController,
                          keyboardType: TextInputType.text,
                          labelText: "Cheque No",
                        )
                      : const SizedBox(),
                  addReceiptController.isCheque == true
                      ? Row(
                          children: [
                            Expanded(
                              child: CustomTextField2(
                                readOnly: true,
                                inputBorder: const OutlineInputBorder(),
                                labelText: "Cheque Date",
                                suffixIcon: const Icon(Icons.date_range,
                                    color: MyColors.greyIcon),
                                controller:
                                    addReceiptController.chqDateController,
                                onTap: () async {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1800),
                                          lastDate: DateTime(2100))
                                      .then((value) {
                                    setState(() {
                                      addReceiptController.selectedDate =
                                          value!;
                                      addReceiptController
                                              .chqDateController.text =
                                          '${addReceiptController.selectedDate.day}-${addReceiptController.selectedDate.month}-${addReceiptController.selectedDate.year}';
                                    });
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: CustomTextField2(
                                readOnly: true,
                                inputBorder: const OutlineInputBorder(),
                                labelText: "Bank In Date",
                                suffixIcon: const Icon(Icons.date_range,
                                    color: MyColors.greyIcon),
                                controller:
                                    addReceiptController.bankInDateController,
                                onTap: () async {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1800),
                                          lastDate: DateTime(2100))
                                      .then((value) {
                                    setState(() {
                                      addReceiptController.selectedDate =
                                          value!;
                                      addReceiptController
                                              .bankInDateController.text =
                                          '${addReceiptController.selectedDate.day}-${addReceiptController.selectedDate.month}-${addReceiptController.selectedDate.year}';
                                    });
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  CustomTextField2(
                    maxLines: 2,
                    inputBorder: const OutlineInputBorder(),
                    controller: addReceiptController.remarkController,
                    keyboardType: TextInputType.text,
                    labelText: "Remark",
                    hintText: "Text Here",
                    suffixIcon: const Icon(
                      Icons.edit,
                      size: 18,
                    ),
                  ),
                  listHeader(),
                  SizedBox(
                    height: addReceiptController.getTranDetail.value!.isNotEmpty
                        ? height(context) / 2
                        : height(context) / 10,
                    child: (addReceiptController
                                .getTranDetail.value!.isNotEmpty &&
                            addReceiptController.getTranDetail.value! != null)
                        ? list()
                        : Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'No Outstanding Invoice Found',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.black),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: 0,
                  )
                ],
              ),
            ),
            bottomNavigationBar: splitAmt(),
          ),
        );
      },
    );
  }

  list() {
    return ListView.builder(
      itemCount: addReceiptController.getTranDetail.value?.length,
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(0.5),
                1: FlexColumnWidth(0.6),
                2: FlexColumnWidth(0.7),
                3: FlexColumnWidth(0.5),
                4: FlexColumnWidth(0.5),
                5: FlexColumnWidth(0.5),
              },
              children: [
                TableRow(children: [
                  Align(
                    alignment: Alignment.center,
                    child: Checkbox(
                      value: addReceiptController
                          .getTranDetail.value![index].isChecked,
                      splashRadius: 2,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      fillColor: MaterialStateProperty.resolveWith(
                        (states) {
                          if (states.contains(MaterialState.selected)) {
                            return MyColors.mainTheme;
                          }
                          return null;
                        },
                      ),
                      onChanged: (value) {
                        setState(
                          () {
                            addReceiptController
                                .getTranDetail.value![index].isChecked = value!;

                            var chk = addReceiptController.getTranDetail.value!
                                .every((element) => element.isChecked == true);
                            if (chk == false) {
                              addReceiptController.isCheckedSelectAll = false;
                            } else {
                              addReceiptController.isCheckedSelectAll = true;
                            }

                            if (value == true) {
                              /// add the selected invoice in list
                              addReceiptController.selectedItems.add(
                                  addReceiptController
                                      .getTranDetail.value![index]);

                              /// selected checkbox value on payable...
                              addReceiptController.getTranDetail.value![index]
                                  .paidController.text = addReceiptController
                                      .getTranDetail.value?[index].balanceAmount
                                      ?.toStringAsFixed(2) ??
                                  '';

                              /// calculate the total of payable...
                              addReceiptController.selectedAmt = 0.00;
                              for (var item in addReceiptController
                                  .getTranDetail.value!) {
                                addReceiptController.selectedAmt +=
                                    (item.paidController.text.isNotEmpty)
                                        ? double.parse(item.paidController.text)
                                        : 0.00;
                              }
                              addReceiptController.selectedAmtController.text =
                                  addReceiptController.selectedAmt
                                      .toStringAsFixed(2);
                            } else {
                              addReceiptController.selectedItems.remove(
                                  addReceiptController
                                      .getTranDetail.value![index]);
                              addReceiptController
                                  .getTranDetail.value![index].paidController
                                  .clear();
                              addReceiptController.selectedAmt = 0.00;
                              for (var item in addReceiptController
                                  .getTranDetail.value!) {
                                addReceiptController.selectedAmt +=
                                    (item.paidController.text.isNotEmpty)
                                        ? double.parse(item.paidController.text)
                                        : 0.00;
                              }
                              addReceiptController.selectedAmtController.text =
                                  addReceiptController.selectedAmt
                                      .toStringAsFixed(2);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      child: Text(
                        addReceiptController
                                .getTranDetail.value?[index].tranNo ??
                            '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            color: MyColors.heading354038),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      child: Text(
                        formatDate(addReceiptController
                            .getTranDetail.value?[index].tranDate),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            color: MyColors.heading354038),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      child: Text(
                        "\$ ${addReceiptController.getTranDetail.value?[index].netTotal?.toStringAsFixed(2) ?? ''}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            color: MyColors.heading354038),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      child: Text(
                        "\$ ${addReceiptController.getTranDetail.value?[index].paidAmount?.toStringAsFixed(2) ?? ''}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            color: MyColors.heading354038),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      child: Text(
                        "\$ ${addReceiptController.getTranDetail.value?[index].balanceAmount?.toStringAsFixed(2) ?? ''}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: MyFont.myFont2,
                            fontWeight: FontWeight.bold,
                            color: MyColors.heading354038),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(0.5),
                1: FlexColumnWidth(0.5),
              },
              children: [
                TableRow(children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 55,
                      child: CustomTextField2(
                        controller: addReceiptController
                            .getTranDetail.value![index].paidController,
                        contentPadding: const EdgeInsets.only(left: 12, top: 7),
                        inputBorder: const OutlineInputBorder(),
                        inputFormatters: [NumericInputFormatter()],
                        keyboardType: TextInputType.number,
                        labelText: "payable",
                        onChanged: (value) {
                          setState(() {
                            addReceiptController.selectedAmt = 0.00;
                            for (var item
                                in addReceiptController.getTranDetail.value!) {
                              addReceiptController.selectedAmt +=
                                  (item.paidController.text.isNotEmpty)
                                      ? double.parse(item.paidController.text)
                                      : 0.00;
                            }
                            addReceiptController.selectedAmtController.text =
                                addReceiptController.selectedAmt
                                    .toStringAsFixed(2);
                            payAndCredit(index);
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    child: CustomTextField2(
                      controller: addReceiptController
                          .getTranDetail.value![index].creditController,
                      contentPadding: const EdgeInsets.only(left: 12, top: 7),
                      inputBorder: const OutlineInputBorder(),
                      inputFormatters: [NumericInputFormatter()],
                      keyboardType: TextInputType.number,
                      labelText: "Credit",
                      onChanged: (value) {
                        setState(() {
                          addReceiptController.creditAmt = 0.00;
                          for (var item
                              in addReceiptController.getTranDetail.value!) {
                            addReceiptController.creditAmt +=
                                (item.creditController.text.isNotEmpty)
                                    ? double.parse(item.creditController.text)
                                    : 0.00;
                          }
                          payAndCredit(index);
                        });
                      },
                    ),
                  ),
                ]),
              ],
            ),
            const Divider(
              thickness: 1,
              color: MyColors.grey,
            ),
          ],
        );
      },
    );
  }

  listHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 10, top: 5, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Outstanding Invoice',
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.bold,
                    color: MyColors.heading354038),
              ),
              Row(
                children: [
                  Text(
                    'Select All',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: MyFont.myFont2,
                        fontWeight: FontWeight.bold,
                        color: MyColors.black),
                  ),
                  Checkbox(
                      value: addReceiptController.isCheckedSelectAll,
                      splashRadius: 2,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return MyColors.mainTheme;
                        }
                        return null;
                      }),
                      onChanged: (val) {
                        setState(() {
                          addReceiptController.isCheckedSelectAll = val!;
                          if (val == true) {
                            addReceiptController.getTranDetail.value
                                ?.forEach((element) {
                              element.isChecked = true;
                              addReceiptController.selectedItems.add(element);
                            });
                            addReceiptController.getTranDetail.value
                                ?.forEach((element) {
                              element.paidController.text =
                                  element.balanceAmount?.toStringAsFixed(2) ??
                                      '';
                              addReceiptController.selectedAmt = 0.00;
                              for (var item in addReceiptController
                                  .getTranDetail.value!) {
                                addReceiptController.selectedAmt +=
                                    (item.paidController.text.isNotEmpty)
                                        ? double.parse(item.paidController.text)
                                        : 0.00;
                              }
                              addReceiptController.selectedAmtController.text =
                                  addReceiptController.selectedAmt
                                      .toStringAsFixed(2);
                            });
                          } else {
                            addReceiptController.getTranDetail.value
                                ?.forEach((element) {
                              element.isChecked = false;
                              addReceiptController.selectedItems
                                  .remove(element);
                            });
                            addReceiptController.getTranDetail.value
                                ?.forEach((element) {
                              element.paidController.clear();
                            });
                            addReceiptController.selectedAmt = 0.00;
                            for (var item
                                in addReceiptController.getTranDetail.value!) {
                              addReceiptController.selectedAmt +=
                                  (item.paidController.text.isNotEmpty)
                                      ? double.parse(item.paidController.text)
                                      : 0.00;
                            }
                            addReceiptController.selectedAmtController.text =
                                addReceiptController.selectedAmt
                                    .toStringAsFixed(2);
                            addReceiptController.totalPaidController.clear();
                            addReceiptController.selectedAmtController.clear();
                          }
                        });
                      }),
                ],
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                MyColors.gradient1,
                MyColors.gradient2,
                MyColors.gradient3,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(0.5),
                    1: FlexColumnWidth(0.6),
                    2: FlexColumnWidth(0.7),
                    3: FlexColumnWidth(0.5),
                    4: FlexColumnWidth(0.5),
                    5: FlexColumnWidth(0.5),
                  },
                  children: [
                    TableRow(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Select',
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
                          'Net Total',
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
                          'paid',
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
                    ]),
                  ],
                ),
                const Divider(
                  thickness: 1,
                  color: MyColors.grey,
                ),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(0.5),
                    1: FlexColumnWidth(0.5),
                  },
                  children: [
                    TableRow(children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          'payable',
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
                    ]),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  splitAmt() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField2(
                readOnly: false,
                inputBorder: const OutlineInputBorder(),
                labelText: "Total Paid",
                keyboardType: TextInputType.number,
                controller: addReceiptController.totalPaidController,
                onChanged: (p0) {
                  setState(() {
                    if (addReceiptController
                        .totalPaidController.text.isNotEmpty) {
                      differ();
                    } else {
                      return addReceiptController.differenceController.clear();
                    }
                  });
                },
                onTapOutside: (s) {
                  setState(() {
                    if (addReceiptController
                            .totalPaidController.text.isNotEmpty &&
                        addReceiptController
                            .selectedAmtController.text.isNotEmpty) {
                      if ((addReceiptController
                                      .totalPaidController.text.isNotEmpty
                                  ? double.parse(addReceiptController
                                      .totalPaidController.text)
                                  : 0.00) <
                              addReceiptController.selectedAmt ||
                          (addReceiptController
                                      .totalPaidController.text.isNotEmpty
                                  ? double.parse(addReceiptController
                                      .totalPaidController.text)
                                  : 0.00) >
                              addReceiptController.selectedAmt) {
                        Get.showSnackbar(const GetSnackBar(
                          title: 'Error',
                          backgroundColor: MyColors.red,
                          icon: Icon(
                            Icons.error,
                            color: MyColors.white,
                          ),
                          borderRadius: 15,
                          margin: EdgeInsets.all(20),
                          snackPosition: SnackPosition.TOP,
                          duration: Duration(seconds: 4),
                          messageText: Text(
                            "Total Paid Amount Should be Equal to the Selected Amount !",
                            style: TextStyle(
                              color: MyColors.white,
                            ),
                          ),
                        ));
                        addReceiptController.totalPaidController.clear();
                        addReceiptController.differenceController.clear();
                      }
                    }
                  });
                },
              ),
            ),
            Expanded(
              child: CustomTextField2(
                readOnly: true,
                enabled: false,
                inputBorder: const OutlineInputBorder(),
                controller: addReceiptController.selectedAmtController,
                keyboardType: TextInputType.number,
                labelText: "Selected Amount",
                filledColor: MyColors.greyIcon,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextField2(
                readOnly: true,
                enabled: false,
                inputBorder: const OutlineInputBorder(),
                labelText: "Difference",
                keyboardType: TextInputType.number,
                controller: addReceiptController.differenceController,
              ),
            ),
            Expanded(
              child: CustomTextField2(
                readOnly: false,
                inputBorder: const OutlineInputBorder(),
                labelText: "Write Off",
                keyboardType: TextInputType.number,
                controller: addReceiptController.writeOffController,
              ),
            ),
          ],
        ),
        // InkWell(
        //   onTap: () {},
        //   child: Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 15),
        //     decoration: BoxDecoration(
        //         gradient: const LinearGradient(colors: [
        //           MyColors.gradient1,
        //           MyColors.gradient2,
        //           MyColors.gradient3,
        //         ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        //         borderRadius: BorderRadius.circular(10)),
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
        //       child: Text(
        //         'SPLIT',
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //             fontFamily: MyFont.myFont2,
        //             fontSize: 18,
        //             fontWeight: FontWeight.bold,
        //             color: MyColors.white),
        //       ),
        //     ),
        //   ),
        // ),
        Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom)),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  payAndCredit(int index) {
    double z = ((addReceiptController.getTranDetail.value![index]
                    .creditController.text.isNotEmpty
                ? double.parse(addReceiptController
                    .getTranDetail.value![index].creditController.text)
                : 0.00) +
            (addReceiptController
                    .getTranDetail.value![index].paidController.text.isNotEmpty
                ? double.parse(addReceiptController
                    .getTranDetail.value![index].paidController.text)
                : 0.00))
        .toDouble();
    if (z > addReceiptController.getTranDetail.value![index].balanceAmount!) {
      Get.showSnackbar(const GetSnackBar(
        title: 'Error',
        backgroundColor: MyColors.red,
        icon: Icon(
          Icons.error,
          color: MyColors.white,
        ),
        borderRadius: 15,
        margin: EdgeInsets.all(20),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 4),
        messageText: Text(
          " Sum of Credit Amount and Paid Amount must be less than Balance Amount!",
          style: TextStyle(
            color: MyColors.white,
          ),
        ),
      ));
      addReceiptController.getTranDetail.value![index].paidController.clear();
      addReceiptController.getTranDetail.value![index].creditController.clear();
    }
  }

  containerText(String val) {
    return Text(
      val,
      style: TextStyle(
          fontFamily: MyFont.myFont2,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: hexStringToColor('666666')),
    );
  }

  differ() {
    addReceiptController.differenceController.text = ((addReceiptController
                    .totalPaidController.text.isNotEmpty
                ? double.parse(addReceiptController.totalPaidController.text)
                : 0.00) -
            (addReceiptController.selectedAmtController.text.isNotEmpty
                ? double.parse(addReceiptController.selectedAmtController.text)
                : 0.00))
        .toStringAsFixed(2);
    if (addReceiptController.selectedAmtController.text ==
        addReceiptController.differenceController.text) {
      addReceiptController.differenceController.clear();
    }
  }
}

// Container(
//   margin: const EdgeInsets.symmetric(
//       horizontal: 14, vertical: 15),
//   decoration: BoxDecoration(
//       gradient: const LinearGradient(
//           colors: [
//             MyColors.gradient1,
//             MyColors.gradient2,
//             MyColors.gradient3,
//           ],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter),
//       borderRadius: BorderRadius.circular(8)),
//   child: Container(
//     decoration: BoxDecoration(
//         color: hexStringToColor('F2F1FF'),
//         borderRadius: BorderRadius.circular(8)),
//     margin: const EdgeInsets.symmetric(
//         horizontal: 1, vertical: 1),
//     child: Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(
//               top: 20, bottom: 10, left: 15, right: 15),
//           child: Row(
//             mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween,
//             children: [
//               containerText('Item Discount'),
//               containerText('0.00')
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(
//               top: 5, bottom: 10, left: 15, right: 10),
//           child: Row(
//             mainAxisAlignment:
//                 MainAxisAlignment.spaceBetween,
//             children: [
//               containerText('Bill Discount'),
//               Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     gradient: const LinearGradient(
//                         colors: [
//                           MyColors.gradient1,
//                           MyColors.gradient2,
//                           MyColors.gradient3,
//                         ],
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter),
//                   ),
//                   child: Text(
//                     '0%',
//                     style: TextStyle(
//                         fontFamily: MyFont.myFont2,
//                         fontSize: 14,
//                         fontWeight: FontWeight.normal,
//                         color: MyColors.white),
//                   ))
//             ],
//           ),
//         ),
//         const CustomGradient(child: Divider()),
//         Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 15, vertical: 10),
//               child: Row(
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                 children: [
//                   containerText('Sub Total'),
//                   containerText('0.00')
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 15, vertical: 10),
//               child: Row(
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                 children: [
//                   containerText('Tax'),
//                   containerText('0.00')
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                   horizontal: 15, vertical: 10),
//               child: Row(
//                 mainAxisAlignment:
//                     MainAxisAlignment.spaceBetween,
//                 children: [
//                   containerText('NetTotal'),
//                   containerText('0.00')
//                 ],
//               ),
//             )
//           ],
//         )
//       ],
//     ),
//   ),
// ),
