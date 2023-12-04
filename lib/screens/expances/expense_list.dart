// import 'package:erp/Helper/appRoute.dart';
// import 'package:erp/Helper/assets.dart';
// import 'package:erp/Model/GetAllSupplierModel.dart';
// import 'package:erp/screens/expances/expense_list_controller.dart';
// import 'package:erp/widgets/Custom_TextField_2.dart';
// import 'package:erp/widgets/search_dropdown_textfield2.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../Helper/colors.dart';
// import '../../../../Helper/custom_gradient.dart';
// import '../../../../Helper/fonts.dart';
// import '../../../../Helper/size.dart';
//
// class ExpenseList extends StatefulWidget {
//   const ExpenseList({Key? key}) : super(key: key);
//
//   @override
//   State<ExpenseList> createState() => _ExpenseListState();
// }
//
// class _ExpenseListState extends State<ExpenseList> {
//   late ExpenseListController listController;
//   String? customerCode;
//   String date = "";
//   String toDate = "";
//
//   String? name;
//   String? branchName;
//
//   String currentDate =
//       DateFormat('yyyy-MM-dd').format(DateTime.now() );
//   @override
//   void initState() {
//     super.initState();
//     listController = Get.put(ExpenseListController());
//     listController.getOrderCustomerList("");
//     listController.getOrderCodeList(
//         customerCode: "",
//         searchFromDate: currentDate,
//         searchToDate: currentDate,
//         isSearch: false);
//     listController.isSelectedFilter = true;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ExpenseListController>(builder: (logic) {
//       // if (logic.status.isLoading == true) {
//       //   return const Scaffold(
//       //     body: Center(
//       //       child: CustomGradient(child: CircularProgressIndicator()),
//       //     ),
//       //   );
//       // }
//       if (logic.status.isLoading == true) {
//         return const Scaffold(
//           body: Center(
//             child: CustomGradient(child: CircularProgressIndicator()),
//           ),
//         );
//       }
//
//       return Scaffold(
//           appBar: AppBar(
//             toolbarHeight: 80,
//             leading: GestureDetector(
//               onTap: () {
//                 Get.toNamed(AppRoutes.bottomNavBarScreen);
//               },
//               child: Image.asset(
//                 IconAssets.leftIcon,
//                 color: MyColors.white,
//                 scale: 1.3,
//               ),
//             ),
//             actions: [
//               IconButton(
//                 icon: Icon(
//                   listController.isSelectedFilter
//                       ? Icons.filter_alt_outlined
//                       : Icons.filter_alt_off_outlined,
//                   color: MyColors.white,
//                   size: 35,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     listController.isSelectedFilter =
//                         !listController.isSelectedFilter;
//                   });
//                 },
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(0),
//                 child: IconButton(
//                   icon: const Icon(Icons.add_circle_outline_sharp,
//                       color: MyColors.white, size: 35),
//                   onPressed: () {
//                     Get.toNamed(AppRoutes.salesAddTabBar);
//                   },
//                 ),
//               ),
//             ],
//             title: const Text('Sales Order'),
//             titleTextStyle: TextStyle(
//                 fontFamily: MyFont.myFont2,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: MyColors.white),
//             backgroundColor: Colors.transparent,
//             shadowColor: Colors.transparent,
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(colors: [
//                   MyColors.gradient1,
//                   MyColors.gradient2,
//                   MyColors.gradient3,
//                 ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//               ),
//             ),
//           ),
//           backgroundColor: MyColors.white,
//           body: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 listController.isSelectedFilter
//                     ? Container()
//                     : Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Obx(() {
//                                 return SearchDropdownTextField2<
//                                         GetSupplierModel>(
//                                     hintText: 'Select Customer',
//                                     hintTextStyle: TextStyle(
//                                       fontFamily: MyFont.myFont2,
//                                       color: MyColors.black,
//                                       fontSize: 13,
//                                     ),
//                                     textStyle: TextStyle(
//                                       fontFamily: MyFont.myFont2,
//                                       color: MyColors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 13,
//                                     ),
//                                     // prefixIcon: const Icon(
//                                     //   Icons.search,
//                                     //   color: MyColors.red,
//                                     // ),
//                                     suffixIcon: InkWell(
//                                       onTap: () {
//                                         setState(() {
//                                           listController.clearData();
//                                         });
//                                       },
//                                       child: const Icon(
//                                         Icons.clear,
//                                         color: MyColors.red,
//                                       ),
//                                     ),
//                                     inputBorder: BorderSide.none,
//                                     filled: true,
//                                     border: const OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     items: listController.suppListModel.value,
//                                     color: Colors.black54,
//                                     selectedItem: listController.suppList,
//                                     isValidator: true,
//                                     onAddPressed: () {
//                                       setState(() {
//                                         listController.customerName = "";
//                                         listController.suppList = null;
//                                       });
//                                     },
//                                     onChanged: (value) {
//                                       FocusScope.of(context).unfocus();
//                                       listController.suppList = value;
//                                       listController.customerName = value.name;
//                                       setState(() {
//                                         listController.customerName =
//                                             value.name;
//                                         listController.customerCodecontroller
//                                             .text = value.code ?? "";
//                                         customerCode = value.code;
//                                       });
//                                     });
//                               }),
//                             ),
//                             CustomTextField2(
//                               inputBorder: const OutlineInputBorder(),
//                               controller: listController.customerCodecontroller,
//                               keyboardType: TextInputType.text,
//                               labelText: "Customer Code",
//                               hintText: 'Customer Code',
//                               filled: false,
//                               readOnly: true,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: CustomTextField2(
//                                     controller:
//                                         listController.fromDatecontroller,
//                                     labelText: "From Date",
//                                     hintText: "From Date",
//                                     readOnly: true,
//                                     inputFormatters: const [],
//                                     suffixIcon: const Icon(
//                                         Icons.calendar_month_outlined),
//                                     onTap: () async {
//                                       showDatePicker(
//                                         context: context,
//                                         initialDate: DateTime.now(),
//                                         firstDate: DateTime(2000),
//                                         lastDate: DateTime.now(),
//                                       ).then((value) {
//                                         setState(() {
//                                           listController.selectedDate = value!;
//                                           listController
//                                                   .fromDatecontroller.text =
//                                               '${listController.selectedDate.day}-${listController.selectedDate.month}-${listController.selectedDate.year}';
//
//                                           listController.date =
//                                               '${listController.selectedDate.year}-${listController.selectedDate.month}-${listController.selectedDate.day}';
//                                         });
//                                       });
//                                     },
//                                     obscureText: false,
//                                     filled: false,
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: CustomTextField2(
//                                     controller: listController.toDatecontroller,
//                                     labelText: "To Date",
//                                     hintText: "To Date",
//                                     readOnly: true,
//                                     inputFormatters: const [],
//                                     suffixIcon: const Icon(
//                                         Icons.calendar_month_outlined),
//                                     onTap: () async {
//                                       showDatePicker(
//                                               context: context,
//                                               initialDate: DateTime.now(),
//                                               firstDate:
//                                                   listController.selectedDate,
//                                               lastDate: DateTime.now())
//                                           .then((value) {
//                                         setState(() {
//                                           listController.selectedToDate =
//                                               value!;
//                                           listController.toDatecontroller.text =
//                                               '${listController.selectedToDate.day}-${listController.selectedToDate.month}-${listController.selectedToDate.year}';
//
//                                           listController.toDate =
//                                               '${listController.selectedToDate.year}-${listController.selectedToDate.month}-${listController.selectedToDate.day}';
//                                         });
//                                       });
//                                     },
//                                     obscureText: false,
//                                     filled: false,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 if (listController.suppListModel != null) {
//                                   listController.getOrderCodeList(
//                                       customerCode: customerCode ?? "",
//                                       searchFromDate: listController.date,
//                                       searchToDate: listController.toDate,
//                                       isSearch: true);
//                                 } else {
//                                   Get.showSnackbar(
//                                     const GetSnackBar(
//                                       margin: EdgeInsets.all(10),
//                                       borderRadius: 10,
//                                       backgroundColor: Colors.red,
//                                       snackPosition: SnackPosition.TOP,
//                                       message: "Select Customer Name",
//                                       icon: Icon(
//                                         Icons.error,
//                                         color: Colors.white,
//                                       ),
//                                       duration: Duration(seconds: 2),
//                                     ),
//                                   );
//                                 }
//                               },
//                               child: (listController.isSearchFilter == true)
//                                   ? Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Container(
//                                           margin: const EdgeInsets.only(
//                                             top: 21,
//                                             bottom: 21,
//                                             right: 10,
//                                             left: 10,
//                                           ),
//                                           height: height(context) / 28,
//                                           width: width(context) / 15,
//                                           color: MyColors.white,
//                                           child:
//                                               const CircularProgressIndicator(
//                                                   backgroundColor: Colors.white,
//                                                   valueColor:
//                                                       AlwaysStoppedAnimation<
//                                                           Color>(Colors.red)),
//                                         ),
//                                       ],
//                                     )
//                                   : Container(
//                                       alignment: Alignment.center,
//                                       width: double.infinity,
//                                       padding: const EdgeInsets.all(12),
//                                       margin: const EdgeInsets.only(
//                                         top: 10,
//                                         bottom: 10,
//                                         right: 10,
//                                         left: 10,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: MyColors.red,
//                                       ),
//                                       child: Text(
//                                         "Search",
//                                         style: TextStyle(
//                                             decoration: TextDecoration.none,
//                                             fontFamily: MyFont.myFont2,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16,
//                                             letterSpacing: 0.5,
//                                             color: MyColors.white),
//                                       ),
//                                     ),
//                             ),
//                             const Divider(
//                               thickness: 2,
//                               color: MyColors.greyText,
//                             ),
//                           ],
//                         ),
//                       ),
//                 list(),
//               ]));
//     });
//   }
//
//   list() {
//     return ListView.builder(
//         shrinkWrap: true,
//         itemCount: listController.getExpenseList.value?.length,
//         itemBuilder: (context, index) {
//           // DateTime dateTime = DateFormat("yyyy-MM-dd").parse(
//           //     listController.getExpenseList.value?[index].tranDate ?? "");
//           // String orderDate = DateFormat("dd-MM-yyyy").format(dateTime);
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(5),
//               boxShadow: [
//                 BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 2),
//               ],
//             ),
//             margin: const EdgeInsets.only(
//               top: 15,
//               left: 18,
//               right: 18,
//               bottom: 0,
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(
//                         top: 15,
//                         left: 5,
//                         right: 10,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Supplier Name',
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 fontFamily: MyFont.myFont2,
//                                 fontWeight: FontWeight.bold,
//                                 color: MyColors.black5F5F5F),
//                           ),
//                           SizedBox(
//                             width: width(context) / 1.7,
//                             child: CustomGradient(
//                               child: Text(
//                                 listController.getExpenseList.value?[index]
//                                         .customerName ??
//                                     '',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontFamily: MyFont.myFont2,
//                                     fontWeight: FontWeight.bold,
//                                     color: MyColors.black1D2226),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 15),
//                       child: Container(
//                         margin: const EdgeInsets.only(
//                           left: 1,
//                           right: 10,
//                         ),
//                         padding: const EdgeInsets.only(
//                           left: 1,
//                           right: 3,
//                         ),
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(
//                               colors: [
//                                 MyColors.gradient1,
//                                 MyColors.gradient2,
//                                 MyColors.gradient3,
//                               ],
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.only(
//                                   left: 5, right: 10, top: 3, bottom: 3),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(3),
//                               ),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   const CustomGradient(
//                                     child: Icon(
//                                       Icons.edit_document,
//                                       color: MyColors.mainTheme,
//                                       size: 15,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 2,
//                                   ),
//                                   CustomGradient(
//                                     child: Text(
//                                       "Option",
//                                       style: TextStyle(
//                                           fontFamily: MyFont.myFont,
//                                           fontWeight: FontWeight.w900,
//                                           fontSize: 9,
//                                           color: MyColors.mainTheme),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 2,
//                             ),
//                             expenseListEditMenu(context,
//                                 listController.getExpenseList.value![index]),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: Table(
//                     defaultVerticalAlignment: TableCellVerticalAlignment.top,
//                     columnWidths: const {
//                       0: FlexColumnWidth(1.2),
//                       2: FlexColumnWidth(0.6)
//                     },
//                     children: [
//                       TableRow(children: [
//                         Text(
//                           'Tran No',
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black5F5F5F),
//                         ),
//                         Text(
//                           'Tran Date',
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black5F5F5F),
//                         ),
//
//                       ]),
//                       TableRow(children: [
//                         Text(
//                           listController.getExpenseList.value?[index].tranNo ??
//                               '',
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black1D2226),
//                         ),
//                         Text(
//                           listController.getExpenseList.value?[index].tranDate
//                                   .toString()
//                                   .substring(0, 10) ??
//                               "",
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black1D2226),
//                         ),
//
//                       ])
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: Table(
//                     defaultVerticalAlignment: TableCellVerticalAlignment.top,
//                     columnWidths: const {
//                       0: FlexColumnWidth(1.2),
//                       1: FlexColumnWidth(0.6)
//                       2:
//                       FlexColumnWidth(1.2),
//                       3: FlexColumnWidth(0.6)
//                     },
//                     children: [
//                       TableRow(children: [
//                         Text(
//                           'Sub Total',
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black5F5F5F),
//                         ),
//                         Text(
//                           'Tax',
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black5F5F5F),
//                         ),
//                         Text(
//                           'Net Total',
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black5F5F5F),
//                         ),
//                         Text(
//                           'Balance Amt',
//                           style: TextStyle(
//                               fontSize: 13,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black5F5F5F),
//                         ),
//
//                       ]),
//                       TableRow(children: [
//                         Text(
//                           listController.getExpenseList.value?[index].tranNo ??
//                               '',
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black1D2226),
//                         ),
//                         Text(
//                           listController.getExpenseList.value?[index].tranDate
//                               .toString()
//                               .substring(0, 10) ??
//                               "",
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black1D2226),
//                         ),
//                         Text(
//                           listController.getExpenseList.value?[index].tranNo ??
//                               '',
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black1D2226),
//                         ),
//                         Text(
//                           listController.getExpenseList.value?[index].tranDate
//                               .toString()
//                               .substring(0, 10) ??
//                               "",
//                           style: TextStyle(
//                               fontSize: 14,
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.bold,
//                               color: MyColors.black1D2226),
//                         ),
//
//                       ])
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         });
//   }
//
//   expenseListEditMenu(BuildContext context, Expense expenseModel) {
//     return SizedBox(
//       height: 25,
//       width: 28,
//       child: PopupMenuButton(
//         color: MyColors.white,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//             side: const BorderSide(width: 2, color: MyColors.primaryCustom)),
//         iconSize: 25,
//         padding: const EdgeInsets.all(0),
//         icon: const Icon(
//           Icons.arrow_drop_down_rounded,
//           color: MyColors.white,
//         ),
//         offset: const Offset(0, 30),
//         itemBuilder: (_) => <PopupMenuEntry>[
//           PopupMenuItem(
//               onTap: () {
//                 Get.toNamed(AppRoutes.salesAddTabBar,
//                     arguments: expenseModel);
//               },
//               height: 20,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 5, left: 5),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//                       Image.asset(
//                         IconAssets.editIcon,
//                         scale: 1.1,
//                       ),
//                       SizedBox(
//                         width: width(context) / 50,
//                       ),
//                       CustomGradient(
//                         child: Text(
//                           'Edit ',
//                           style: TextStyle(
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.w900,
//                               fontSize: 15,
//                               color: MyColors.mainTheme),
//                         ),
//                       ),
//                     ]),
//                   ],
//                 ),
//               )),
//           PopupMenuItem(
//               onTap: () {
//                 Get.toNamed(AppRoutes.printPreviewScreen,
//                     arguments: expenseModel);
//               },
//               height: 20,
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 10, bottom: 5, left: 3),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//                       Image.asset(
//                         IconAssets.product,
//                         scale: 2,
//                       ),
//                       SizedBox(
//                         width: width(context) / 50,
//                       ),
//                       CustomGradient(
//                         child: Text(
//                           'Print Preview ',
//                           style: TextStyle(
//                               fontFamily: MyFont.myFont2,
//                               fontWeight: FontWeight.w900,
//                               fontSize: 15,
//                               color: MyColors.mainTheme),
//                         ),
//                       ),
//                     ]),
//                   ],
//                 ),
//               )),
//
//           // const PopupMenuDivider(),
//           // PopupMenuItem(
//           //     height: 20,
//           //     child: Column(
//           //       mainAxisSize: MainAxisSize.min,
//           //       children: [
//           //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//           //           Image.asset(
//           //             IconAssets.createOrder,
//           //             scale: 1.1,
//           //           ),
//           //           SizedBox(
//           //             width: width(context) / 50,
//           //           ),
//           //           CustomGradient(
//           //             child: Text(
//           //               'Create Order ',
//           //               style: TextStyle(
//           //                   fontFamily: MyFont.myFont2,
//           //                   fontWeight: FontWeight.w900,
//           //                   fontSize: 15,
//           //                   color: MyColors.mainTheme),
//           //             ),
//           //           ),
//           //         ]),
//           //       ],
//           //     )),
//           // const PopupMenuDivider(),
//           // PopupMenuItem(
//           //     height: 20,
//           //     child: Column(
//           //       mainAxisSize: MainAxisSize.min,
//           //       children: [
//           //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//           //           Image.asset(
//           //             IconAssets.createInvoice,
//           //           ),
//           //           SizedBox(
//           //             width: width(context) / 50,
//           //           ),
//           //           CustomGradient(
//           //             child: Text(
//           //               'Create Invoice',
//           //               style: TextStyle(
//           //                   fontFamily: MyFont.myFont2,
//           //                   fontWeight: FontWeight.w900,
//           //                   fontSize: 15,
//           //                   color: MyColors.mainTheme),
//           //             ),
//           //           ),
//           //         ]),
//           //       ],
//           //     )),
//           // const PopupMenuDivider(),
//           // PopupMenuItem(
//           //     height: 20,
//           //     child: Column(
//           //       mainAxisSize: MainAxisSize.min,
//           //       children: [
//           //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//           //           Image.asset(
//           //             IconAssets.createReceipt,
//           //             scale: 1.6,
//           //           ),
//           //           SizedBox(
//           //             width: width(context) / 50,
//           //           ),
//           //           CustomGradient(
//           //             child: Text(
//           //               'Create Receipt',
//           //               style: TextStyle(
//           //                   fontFamily: MyFont.myFont2,
//           //                   fontWeight: FontWeight.w900,
//           //                   fontSize: 15,
//           //                   color: MyColors.mainTheme),
//           //             ),
//           //           ),
//           //         ]),
//           //       ],
//           //     )),
//           // const PopupMenuDivider(),
//           // PopupMenuItem(
//           //     height: 20,
//           //     child: Column(
//           //       mainAxisSize: MainAxisSize.min,
//           //       children: [
//           //         Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//           //           Image.asset(
//           //             IconAssets.viewLocation,
//           //             scale: 1.2,
//           //           ),
//           //           SizedBox(
//           //             width: width(context) / 50,
//           //           ),
//           //           CustomGradient(
//           //             child: Text(
//           //               'View Location',
//           //               style: TextStyle(
//           //                   fontFamily: MyFont.myFont2,
//           //                   fontWeight: FontWeight.w900,
//           //                   fontSize: 15,
//           //                   color: MyColors.mainTheme),
//           //             ),
//           //           ),
//           //         ]),
//           //       ],
//           //     )),
//           // const PopupMenuDivider(),
//           // PopupMenuItem(
//           //   onTap: () {},
//           //   height: 20,
//           //   child: Column(
//           //     mainAxisAlignment: MainAxisAlignment.start,
//           //     mainAxisSize: MainAxisSize.min,
//           //     children: [
//           //       Row(
//           //           mainAxisAlignment: MainAxisAlignment.start,
//           //           // crossAxisAlignment: CrossAxisAlignment.start,
//           //           children: [
//           //             Image.asset(
//           //               IconAssets.delete,
//           //               scale: 1.2,
//           //             ),
//           //             SizedBox(
//           //               width: width(context) / 50,
//           //             ),
//           //             CustomGradient(
//           //               child: Text(
//           //                 'Delete',
//           //                 style: TextStyle(
//           //                     fontFamily: MyFont.myFont2,
//           //                     fontWeight: FontWeight.w900,
//           //                     fontSize: 15,
//           //                     color: MyColors.mainTheme),
//           //               ),
//           //             ),
//           //           ]),
//           //     ],
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
