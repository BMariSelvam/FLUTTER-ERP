import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/preferenceHelper.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/Model/GetAllCustomerModel.dart';
import 'package:erp/Model/RequestModel/invioce_model/Invoice.dart';
import 'package:erp/screens/invoice/all_screen_controller.dart';
import 'package:erp/widgets/Custom_TextField_2.dart';
import 'package:erp/widgets/search_dropdown_textfield2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AllScreen extends StatefulWidget {
  final Widget? tabBar;

  const AllScreen({
    super.key,
    this.tabBar,
  });

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  late AllScreenController listController;
  String? customerCode;
  String date = "";
  String toDate = "";

  String? name;
  String? branchName;

  String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    listController = Get.put(AllScreenController());
    listController.getOrderCustomerList();
    listController.getInvoiceCodeList(
        customerCode: "",
        searchFromDate: "",
        searchToDate: "",
        isSearch: false);
    listController.isSelectedFilter = true;
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    listController = Get.put(AllScreenController());
    listController.getOrderCustomerList();
    listController.getInvoiceCodeList(
        customerCode: "",
        searchFromDate: "",
        searchToDate: "",
        isSearch: false);
    listController.isSelectedFilter = true;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllScreenController>(
      builder: (logic) {
        if (logic.status.isLoading == true) {
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
                    listController.getInvoiceCodeList(
                        customerCode: "",
                        searchFromDate: currentDate,
                        searchToDate: currentDate,
                        isSearch: false);
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: IconButton(
                  icon: const Icon(Icons.add_circle_outline_sharp,
                      color: MyColors.white, size: 35),
                  onPressed: () {
                    Get.toNamed(AppRoutes.addTabBarScreen);
                  },
                ),
              ),
            ],
            title: const Text('Invoice'),
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
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  listController.isSelectedFilter
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Obx(() {
                                  return SearchDropdownTextField2<
                                          GetCustomerModel>(
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
                                            listController.getInvoiceCodeList(
                                                customerCode: "",
                                                searchFromDate: currentDate,
                                                searchToDate: currentDate,
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
                                      items: listController
                                          .customerListModel.value,
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
                                        listController.customerName =
                                            value.name;
                                        setState(() {
                                          listController.customerName =
                                              value.name;
                                          listController.customerCodecontroller
                                              .text = value.code ?? "";
                                          customerCode = value.code;
                                        });
                                      });
                                }),
                              ),
                              CustomTextField2(
                                inputBorder: const OutlineInputBorder(),
                                controller:
                                    listController.customerCodecontroller,
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
                                      controller:
                                          listController.fromDatecontroller,
                                      labelText: "From Date",
                                      hintText: "From Date",
                                      readOnly: true,
                                      inputFormatters: const [],
                                      suffixIcon: const Icon(
                                          Icons.calendar_month_outlined),
                                      onTap: () async {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now(),
                                        ).then((value) {
                                          setState(() {
                                            listController.selectedDate =
                                                value!;
                                            listController
                                                    .fromDatecontroller.text =
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
                                      controller:
                                          listController.toDatecontroller,
                                      labelText: "To Date",
                                      hintText: "To Date",
                                      readOnly: true,
                                      inputFormatters: const [],
                                      suffixIcon: const Icon(
                                          Icons.calendar_month_outlined),
                                      onTap: () async {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate:
                                                    listController.selectedDate,
                                                lastDate: DateTime.now())
                                            .then((value) {
                                          setState(() {
                                            listController.selectedToDate =
                                                value!;
                                            listController
                                                    .toDatecontroller.text =
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
                                    listController.getInvoiceCodeList(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            child:
                                                const CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.white,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(Colors.red)),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                  (listController.getAllInvoiceList.value != null &&
                          listController.getAllInvoiceList.value!.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: list(),
                        )
                      : Container(
                          height: listController.isSelectedFilter
                              ? height(context) / 1.3
                              : height(context) / 2,
                          alignment: Alignment.center,
                          child: Text(
                            "No Invoice",
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  list() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listController.getAllInvoiceList.value?.length,
        itemBuilder: (context, index) {
          String date =
              listController.getAllInvoiceList.value?[index].tranDate ?? 'N/A';
          return Container(
            margin: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        left: 18,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        listController
                                .getAllInvoiceList.value?[index].customerName ??
                            '',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            color: MyColors.black),
                      ),
                    ),
                    Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    "Edit",
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
                          invoiceEditMenu(context,
                              listController.getAllInvoiceList.value![index]),
                        ],
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
                      // TableRow(children: [
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Invoice Number:  ',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text('PO2023-00023  ',
                      //             style: TextStyle(
                      //                 decoration: TextDecoration.none,
                      //                 fontFamily: MyFont.myFont,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 12,
                      //                 color: MyColors.black)),
                      //       ],
                      //     ),
                      //   ),
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Date :   ',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text(
                      //           '13/02/2023',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 12,
                      //               color: MyColors.black),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Net Total',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text(
                      //           " \$32.00 ",
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.w900,
                      //               fontSize: 12,
                      //               color: MyColors.green),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Balance',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text(
                      //           " \$10.00 ",
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.w900,
                      //               fontSize: 12,
                      //               color: MyColors.red),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ]),
                      TableRow(children: [
                        Text(
                          'Invoice Number:',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: MyColors.greyText),
                        ),
                        Text('Date:',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.greyText)),
                        Text('Net Total',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.greyText)),
                        Text('Balance',
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
                                      .getAllInvoiceList.value?[index].tranNo ??
                                  'N/A',
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontFamily: MyFont.myFont2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: MyColors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 3),
                          child: Text(formatDate(date),
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
                            '\$ ${listController.getAllInvoiceList.value?[index].netTotal ?? 'N/A'}',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: MyColors.green),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 3),
                          child: Text(
                            '\$ ${listController.getAllInvoiceList.value?[index].balanceAmount ?? 'N/A'}',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                color: MyColors.red),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          );
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            margin: const EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                        left: 18,
                        right: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        listController
                                .getAllInvoiceList.value?[index].customerName ??
                            '',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            color: MyColors.black),
                      ),
                    ),
                    Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    "Edit",
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
                          // invoiceEditMenu(context,
                          //     listController.getAllInvoiceList.value![index]),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 15, top: 5, bottom: 10, right: 5),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.7),
                      1: FlexColumnWidth(1.4)
                    },
                    children: [
                      // TableRow(children: [
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Invoice Number:  ',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text('PO2023-00023  ',
                      //             style: TextStyle(
                      //                 decoration: TextDecoration.none,
                      //                 fontFamily: MyFont.myFont,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 12,
                      //                 color: MyColors.black)),
                      //       ],
                      //     ),
                      //   ),
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Date :   ',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text(
                      //           '13/02/2023',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 12,
                      //               color: MyColors.black),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Net Total',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text(
                      //           " \$32.00 ",
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.w900,
                      //               fontSize: 12,
                      //               color: MyColors.green),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      //   Container(
                      //     margin: const EdgeInsets.only(
                      //       left: 10,
                      //       right: 10,
                      //       bottom: 10,
                      //     ),
                      //     child: Column(
                      //       children: [
                      //         Text(
                      //           'Balance',
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 10,
                      //               color: MyColors.greyText),
                      //         ),
                      //         SizedBox(
                      //           height: height(context) / 180,
                      //         ),
                      //         Text(
                      //           " \$10.00 ",
                      //           style: TextStyle(
                      //               decoration: TextDecoration.none,
                      //               fontFamily: MyFont.myFont,
                      //               fontWeight: FontWeight.w900,
                      //               fontSize: 12,
                      //               color: MyColors.red),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ]),
                      TableRow(children: [
                        Text(
                          'Invoice Number:',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont2,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: MyColors.greyText),
                        ),
                        Text('Date:',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.greyText)),
                        Text('Net Total',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: MyColors.greyText)),
                        Text('Balance',
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
                                      .getAllInvoiceList.value?[index].tranNo ??
                                  'N/A',
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
                              listController.getAllInvoiceList.value?[index]
                                      .tranDate ??
                                  'N/A',
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
                            '\$ ${listController.getAllInvoiceList.value?[index].netTotal ?? 'N/A'}',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: MyColors.green),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 3, right: 3),
                          child: Text(
                            '\$ ${listController.getAllInvoiceList.value?[index].balanceAmount ?? 'N/A'}',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: MyFont.myFont2,
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                color: MyColors.red),
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

  invoiceEditMenu(BuildContext context, Invoice invoiceModel) {
    return SizedBox(
      height: 25,
      width: 28,
      child: PopupMenuButton(
        color: MyColors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 2, color: MyColors.primaryCustom)),
        iconSize: 25,
        padding: const EdgeInsets.all(0),
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
          color: MyColors.white,
        ),
        offset: const Offset(0, 30),
        itemBuilder: (_) => <PopupMenuEntry>[
          PopupMenuItem(
              onTap: () {
                Get.toNamed(AppRoutes.addTabBarScreen, arguments: invoiceModel);
              },
              height: 20,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image.asset(
                        IconAssets.editIcon,
                        scale: 1.1,
                      ),
                      SizedBox(
                        width: width(context) / 50,
                      ),
                      CustomGradient(
                        child: Text(
                          'Edit ',
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
              )),
          PopupMenuItem(
              onTap: () {
                Get.toNamed(AppRoutes.invoicePrintPreviewScreen,
                    arguments: invoiceModel);
              },
              height: 20,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5, left: 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image.asset(
                        IconAssets.product,
                        scale: 2,
                      ),
                      SizedBox(
                        width: width(context) / 50,
                      ),
                      CustomGradient(
                        child: Text(
                          'Print Preview ',
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
              )),
          // const PopupMenuDivider(),
          // PopupMenuItem(
          //     height: 20,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //           Image.asset(
          //             IconAssets.createOrder,
          //             scale: 1.1,
          //           ),
          //           SizedBox(
          //             width: width(context) / 50,
          //           ),
          //           CustomGradient(
          //             child: Text(
          //               'Create Order ',
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
          // PopupMenuItem(
          //     height: 20,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //           Image.asset(
          //             IconAssets.createInvoice,
          //           ),
          //           SizedBox(
          //             width: width(context) / 50,
          //           ),
          //           CustomGradient(
          //             child: Text(
          //               'Create Invoice',
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
          // PopupMenuItem(
          //     height: 20,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //           Image.asset(
          //             IconAssets.createReceipt,
          //             scale: 1.6,
          //           ),
          //           SizedBox(
          //             width: width(context) / 50,
          //           ),
          //           CustomGradient(
          //             child: Text(
          //               'Create Receipt',
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
          // PopupMenuItem(
          //     height: 20,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          //           Image.asset(
          //             IconAssets.viewLocation,
          //             scale: 1.2,
          //           ),
          //           SizedBox(
          //             width: width(context) / 50,
          //           ),
          //           CustomGradient(
          //             child: Text(
          //               'View Location',
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
          // PopupMenuItem(
          //   onTap: () {},
          //   height: 20,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           // crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Image.asset(
          //               IconAssets.delete,
          //               scale: 1.2,
          //             ),
          //             SizedBox(
          //               width: width(context) / 50,
          //             ),
          //             CustomGradient(
          //               child: Text(
          //                 'Delete',
          //                 style: TextStyle(
          //                     fontFamily: MyFont.myFont2,
          //                     fontWeight: FontWeight.w900,
          //                     fontSize: 15,
          //                     color: MyColors.mainTheme),
          //               ),
          //             ),
          //           ]),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class EditPopupMenuButton extends StatelessWidget {
  const EditPopupMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
          PopupMenuItem(
              onTap: () {},
              height: 20,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image.asset(
                        IconAssets.editIcon,
                        scale: 1.1,
                      ),
                      SizedBox(
                        width: width(context) / 50,
                      ),
                      CustomGradient(
                        child: Text(
                          'Edit ',
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
              )),
          PopupMenuItem(
              onTap: () {},
              height: 20,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 5, left: 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Image.asset(
                        IconAssets.product,
                        scale: 2,
                      ),
                      SizedBox(
                        width: width(context) / 50,
                      ),
                      CustomGradient(
                        child: Text(
                          'Print Preview ',
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
              )),
        ],
      ),
    );
  }
}

// class TooltipShape extends ShapeBorder {
//   const TooltipShape();

//   final BorderSide _side = BorderSide.none;
//   final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

//   @override
//   EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

//   @override
//   Path getInnerPath(
//     Rect rect, {
//     TextDirection? textDirection,
//   }) {
//     final Path path = Path();

//     path.addRRect(
//       _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
//     );

//     return path;
//   }

//   @override
//   Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
//     final Path path = Path();
//     final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

//     path.moveTo(0, 10);
//     path.quadraticBezierTo(0, 0, 10, 0);
//     path.lineTo(rrect.width - 30, 0);
//     path.lineTo(rrect.width - 20, -10);
//     path.lineTo(rrect.width - 10, 0);
//     path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
//     path.lineTo(rrect.width, rrect.height - 10);
//     path.quadraticBezierTo(
//         rrect.width, rrect.height, rrect.width - 10, rrect.height);
//     path.lineTo(10, rrect.height);
//     path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

//     return path;
//   }

//   @override
//   void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

//   @override
//   ShapeBorder scale(double t) => RoundedRectangleBorder(
//         side: _side.scale(t),
//         borderRadius: _borderRadius * t,
//       );
// }
