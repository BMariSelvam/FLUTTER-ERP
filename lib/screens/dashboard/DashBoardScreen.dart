import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/Helper/size.dart';
import 'package:erp/screens/catalogue/catalogue_screen.dart';
import 'package:erp/screens/dashboard/dashboard_controller.dart';
import 'package:erp/screens/invoice/AllScreen.dart';
import 'package:erp/screens/masters/Customer/customer_list.dart';
import 'package:erp/screens/masters/bank/bank_list.dart';
import 'package:erp/screens/masters/company_screen.dart';
import 'package:erp/screens/masters/paymode/paymode_list.dart';
import 'package:erp/screens/masters/supplier/supplier_list.dart';
import 'package:erp/screens/masters/tax/tax_list.dart';
import 'package:erp/screens/product/brand/brand_list.dart';
import 'package:erp/screens/product/category/category_list.dart';
import 'package:erp/screens/product/productStock/product_stock_list.dart';
import 'package:erp/screens/product/uom/uom_list.dart';
import 'package:erp/screens/purchase/goodsReceive/goods_receive_list.dart';
import 'package:erp/screens/purchase/payment/payment_list.dart';
import 'package:erp/screens/purchase/purchaseOrder/purchase_order_list.dart';
import 'package:erp/screens/purchase/purchaseReturn/purchase_return_list.dart';
import 'package:erp/screens/purchase/stockInDo/stock_in_do_list.dart';
import 'package:erp/screens/sales/salesorder/sales_invoice_tabbar.dart';
import 'package:erp/widgets/BottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/preferenceHelper.dart';
import '../../Model/LoginUserModel.dart';

class DashBoardScreen extends StatefulWidget {
  bool fabSelected = false;
  DashBoardScreen({required this.fabSelected, super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  late DashboardController controller;
  int selectedTabId = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int? orgId;

  LoginUserModel? userDetail;

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
    _tabController = TabController(length: 3, vsync: this);
    controller = Get.put(DashboardController());
    controller.organizationListGet();
    controller.getOrderList();
    controller.getAllInvoice();
    controller.getAllStock();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  bool isOrder = true;
  bool isInvoice = false;
  bool isLowStock = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (logic) {
      if (logic.isLoading.value == true) {
        return const Scaffold(
          body: Center(
            child: CustomGradient(child: CircularProgressIndicator()),
          ),
        );
      }
      return Scaffold(
        drawer: getDrawer(context),
        key: _scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 80,
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
          leading: GestureDetector(
            onTap: () {
              widget.fabSelected = false;
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Image.asset(
              Assets.icon1,
              scale: 1,
            ),
          ),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  userDetail?.organisationName ?? '',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 0.5,
                      color: MyColors.white),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: (userDetail?.itemImage != null)
                      ? Image.asset(
                          userDetail?.itemImage ?? "",
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          Assets.placeholder,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: height(context) / 40,
              ),
              salesWidget(),
              SizedBox(
                height: height(context) / 40,
              ),
              purchaseWidget(),
              SizedBox(
                height: height(context) / 150,
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: 18, right: 18, top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Items",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          letterSpacing: 0.5,
                          color: MyColors.heading354038),
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: CustomGradient(
                    //     child: Text(
                    //       "View All",
                    //       style: TextStyle(
                    //           decoration: TextDecoration.none,
                    //           fontFamily: MyFont.myFont2,
                    //           fontWeight: FontWeight.w600,
                    //           fontSize: 11,
                    //           letterSpacing: 0.5,
                    //           color: MyColors.mainTheme),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: height(context) / 150),
              recentItemsButton(),
              isOrder
                  ? tapBarWidget(
                      context: context,
                      heading1: "ID",
                      heading2: "Customer",
                      heading3: "Amount",
                    )
                  : Container(),
              isInvoice
                  ? tapBarWidget(
                      context: context,
                      heading1: "ID",
                      heading2: "Customer",
                      heading3: "Amount",
                    )
                  : Container(),
              isLowStock
                  ? tapBarWidget(
                      context: context,
                      heading1: "Name",
                      heading2: "Product",
                      heading3: "Quantity",
                    )
                  : Container(),
              isOrder
                  ? Column(children: [
                      recentOrderListview(),
                      controller.getSalesOrderList.length != null
                          ? (controller.getSalesOrderList.length >= 5)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 30, top: 5),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SalesInvoicesTabBarScreen(),
                                            ));
                                      },
                                      child: CustomGradient(
                                        child: Text(
                                          'View All',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyFont.myFont,
                                              fontSize: 12,
                                              color: MyColors.mainTheme),
                                        ),
                                      )),
                                )
                              : Container()
                          : Container(),
                    ])
                  : Container(),
              isInvoice
                  ? Column(children: [
                      recentInvoiceListview(),
                      controller.getAllInvoiceList.value?.length != null
                          ? (controller.getAllInvoiceList.value!.length >= 5)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 30, top: 5),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const AllScreen(),
                                            ));
                                      },
                                      child: CustomGradient(
                                        child: Text(
                                          'View All',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyFont.myFont,
                                              fontSize: 12,
                                              color: MyColors.mainTheme),
                                        ),
                                      )),
                                )
                              : Container()
                          : Container(),
                    ])
                  : Container(),
              isLowStock
                  ? Column(children: [
                      lowStockListview(),
                      controller.getAllStockQtyList.value?.length != null
                          ? (controller.getAllStockQtyList.value!.length >= 5)
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 30, top: 5),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SalesInvoicesTabBarScreen(),
                                            ));
                                      },
                                      child: CustomGradient(
                                        child: Text(
                                          'View All',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: MyFont.myFont,
                                              fontSize: 12,
                                              color: MyColors.mainTheme),
                                        ),
                                      )),
                                )
                              : Container()
                          : Container(),
                    ])
                  : Container(),
            ],
          ),
        ),
      );
    });
  }

  recentItemsButton() {
    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, bottom: 15),
      child: GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3.5,
          crossAxisSpacing: 8,
        ),
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                widget.fabSelected = false;
                isOrder = true;
                isInvoice = false;
                isLowStock = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  gradient: isOrder
                      ? const LinearGradient(
                          colors: [
                              MyColors.gradient1,
                              MyColors.gradient2,
                              MyColors.gradient3,
                            ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)
                      : const LinearGradient(
                          colors: [Colors.transparent, Colors.transparent]),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: MyColors.greyIcon)),
              child: Align(
                alignment: Alignment.center,
                child: Text('Recent order',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: MyFont.myFont2,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isOrder ? MyColors.white : MyColors.greyText)),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.fabSelected = false;
                isInvoice = true;
                isOrder = false;
                isLowStock = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  gradient: isInvoice
                      ? const LinearGradient(
                          colors: [
                              MyColors.gradient1,
                              MyColors.gradient2,
                              MyColors.gradient3,
                            ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)
                      : const LinearGradient(
                          colors: [Colors.transparent, Colors.transparent]),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: MyColors.greyIcon)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Recent Invoice',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: MyFont.myFont2,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isInvoice ? MyColors.white : MyColors.greyText),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.fabSelected = false;
                isLowStock = true;
                isOrder = false;
                isInvoice = false;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  gradient: isLowStock
                      ? const LinearGradient(
                          colors: [
                              MyColors.gradient1,
                              MyColors.gradient2,
                              MyColors.gradient3,
                            ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)
                      : const LinearGradient(
                          colors: [Colors.transparent, Colors.transparent]),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: MyColors.greyIcon)),
              child: Align(
                alignment: Alignment.center,
                child: Text('Low Stock',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: MyFont.myFont2,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color:
                            isLowStock ? MyColors.white : MyColors.greyText)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  recentOrderListview() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.getSalesOrderList.length != null
          ? (controller.getSalesOrderList.length > 5)
              ? 5
              : controller.getSalesOrderList.length
          : controller.getSalesOrderList.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 18, right: 18),
          decoration: BoxDecoration(
              color: index.isEven ? MyColors.white : hexStringToColor('F4F4F4'),
              border: Border.all(color: MyColors.greyBackground)),
          child: Table(
            children: [
              TableRow(children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tran No: ",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: MyColors.black),
                      ),
                      SizedBox(
                        height: height(context) / 180,
                      ),
                      Text(
                        controller.getSalesOrderList[index].tranNo ?? '',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: MyColors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: controller
                                  .getSalesOrderList[index].customerName ??
                              '',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: MyColors.black),
                        ),
                        // TextSpan(
                        //   text: 'hdhdh',
                        //   style: TextStyle(
                        //       wordSpacing: 10,
                        //       decoration: TextDecoration.none,
                        //       fontFamily: MyFont.myFont,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 12,
                        //       color: MyColors.black),
                        // ),
                        const WidgetSpan(
                          child: SizedBox(height: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      controller.getSalesOrderList[index].tranDate
                              ?.substring(0, 10) ??
                          'N/A',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: MyColors.black),
                    ),
                    SizedBox(
                      height: height(context) / 180,
                    ),
                    Text(
                      "\$${controller.getSalesOrderList[index].netTotal.toString() ?? ''}",
                      style: TextStyle(
                          overflow: TextOverflow.fade,
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: MyColors.green),
                    )
                  ],
                ),
              ]),
            ],
          ),
        );
      },
    );
  }

  recentInvoiceListview() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.getAllInvoiceList.value?.length != null
          ? (controller.getAllInvoiceList.value!.length > 5)
              ? 5
              : controller.getAllInvoiceList.value?.length
          : 0,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 18, right: 18),
          decoration: BoxDecoration(
              color: index.isEven ? MyColors.white : hexStringToColor('F4F4F4'),
              border: Border.all(color: MyColors.greyBackground)),
          child: Table(
            children: [
              TableRow(children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tran No: ",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: MyColors.black),
                      ),
                      SizedBox(
                        height: height(context) / 180,
                      ),
                      Text(
                        controller.getAllInvoiceList.value?[index].tranNo ??
                            'N/A',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: MyColors.black),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: controller.getAllInvoiceList.value?[index]
                                  .customerName ??
                              '',
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: MyColors.black),
                        ),
                        // TextSpan(
                        //   text: 'hdhdh',
                        //   style: TextStyle(
                        //       wordSpacing: 10,
                        //       decoration: TextDecoration.none,
                        //       fontFamily: MyFont.myFont,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 12,
                        //       color: MyColors.black),
                        // ),
                        const WidgetSpan(
                          child: SizedBox(height: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      formatDate(controller
                              .getAllInvoiceList.value?[index].tranDate
                              ?.substring(0, 10) ??
                          'N/A'),
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: MyColors.black),
                    ),
                    SizedBox(
                      height: height(context) / 180,
                    ),
                    Text(
                      '\$ ${controller.getAllInvoiceList.value?[index].netTotal ?? 'N/A'}',
                      style: TextStyle(
                          overflow: TextOverflow.fade,
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                          color: MyColors.green),
                    )
                  ],
                ),
              ]),
            ],
          ),
        );
      },
    );
  }

  lowStockListview() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.getAllStockQtyList.value?.length != null
          ? (controller.getAllStockQtyList.value!.length > 5)
              ? 5
              : controller.getAllInvoiceList.value?.length
          : 0,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(left: 18, right: 18),
          decoration: BoxDecoration(
              color: index.isEven ? MyColors.white : hexStringToColor('F4F4F4'),
              border: Border.all(color: MyColors.greyBackground)),
          child: Table(
            children: [
              TableRow(children: [
                Container(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 5, left: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${controller.getAllStockQtyList.value?[index].name}",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: MyColors.black),
                      ),
                      SizedBox(
                        height: height(context) / 180,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 5, left: 10),
                  child: Text(
                    "${controller.getAllStockQtyList.value?[index].code}",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: MyColors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, top: 5, right: 5, bottom: 5),
                  child: Text(
                    "${controller.getAllStockQtyList.value?[index].stockQty}",
                    style: TextStyle(
                        overflow: TextOverflow.fade,
                        decoration: TextDecoration.none,
                        fontFamily: MyFont.myFont,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: MyColors.red),
                  ),
                ),
              ]),
            ],
          ),
        );
      },
    );
  }

//   tapBarWidget(
//       {required BuildContext context,
//       required String heading1,
//       required String heading2,
//       required String heading3}) {
//     return Container(
//       padding: const EdgeInsets.only(left: 30, right: 18, top: 8, bottom: 8),
//       margin: const EdgeInsets.only(left: 18, right: 18),
//       decoration: BoxDecoration(
//           gradient: LinearGradient(colors: [
//             hexStringToColor("18CEEE"),
//             hexStringToColor("2F87D7"),
//             hexStringToColor("473DC0")
//           ],
//               begin: Alignment.topCenter,end: Alignment.bottomCenter),
//         borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(15), topRight: Radius.circular(15)),
//       ),
//       child: Table(
//         children: [
//           TableRow(children: [
//             Text(
//               heading1,
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                   decoration: TextDecoration.none,
//                   fontFamily: MyFont.myFont2,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 color: hexStringToColor('FFFFFF')
//                   ),
//             ),
//             Text(
//               heading2,
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                   decoration: TextDecoration.none,
//                   fontFamily: MyFont.myFont2,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                   color: hexStringToColor('FFFFFF')
//                  ),
//             ),
//             Text(
//               heading3,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   decoration: TextDecoration.none,
//                   fontFamily: MyFont.myFont2,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                   color: hexStringToColor('FFFFFF')
//                   ),
//             ),
//           ]),
//         ],
//       ),
//     );
//   }
// }

  salesWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.greyIcon)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sales",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: 0.5,
                    color: MyColors.heading354038),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: hexStringToColor('E9E9E9'))),
                child: Row(
                  children: [
                    Image.asset(
                      IconAssets.leftIcon,
                      scale: 1.5,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    CustomGradient(
                      child: Text(
                        "Today",
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: MyColors.mainTheme),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Image.asset(
                      IconAssets.rightIcon,
                      scale: 1.5,
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: hexStringToColor('F2F2F2'), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.asset(
                        Assets.totalSalesIcon,
                        scale: 1.8,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Sales",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont3,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              color: MyColors.drakgreyText),
                        ),
                        Text(
                          "\$20.00",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont3,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              letterSpacing: 0.5,
                              color: MyColors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: hexStringToColor('F2F2F2'), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.asset(
                        Assets.totalCollectionsIcon,
                        scale: 1.8,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Collections",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont3,
                              fontWeight: FontWeight.w900,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              color: MyColors.drakgreyText),
                        ),
                        Text(
                          "\$20.00",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont3,
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              letterSpacing: 0.5,
                              color: MyColors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            decoration: BoxDecoration(
              color: hexStringToColor('EDE3EE'),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                  margin: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: MyColors.white, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Image.asset(
                    Assets.purchaseOutstanding,
                    scale: 1.7,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Sales Outstanding : ",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      letterSpacing: 0.5,
                      color: MyColors.drakgreyText),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "\$20000.00",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont3,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            letterSpacing: 0.5,
                            color: MyColors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  purchaseWidget() {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: MyColors.greyIcon)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Purchase",
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontFamily: MyFont.myFont2,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    letterSpacing: 0.5,
                    color: MyColors.heading354038),
              ),
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: MyColors.greyBackground)),
                child: Row(
                  children: [
                    Image.asset(
                      IconAssets.leftIcon,
                      scale: 1.5,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    CustomGradient(
                      child: Text(
                        "Today",
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: MyFont.myFont2,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Image.asset(
                      IconAssets.rightIcon,
                      scale: 1.5,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: hexStringToColor('F2F2F2'), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.asset(
                        Assets.totalSalesIcon,
                        scale: 1.8,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Purchase",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              color: MyColors.drakgreyText),
                        ),
                        Text(
                          "\$20.00",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont3,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              letterSpacing: 0.5,
                              color: MyColors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: hexStringToColor('F2F2F2'), width: 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Image.asset(
                        Assets.totalCollectionsIcon,
                        scale: 1.8,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Collections",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont3,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.5,
                              color: MyColors.drakgreyText),
                        ),
                        Text(
                          "\$20.00",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontFamily: MyFont.myFont3,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              letterSpacing: 0.5,
                              color: MyColors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 8,
            ),
            decoration: BoxDecoration(
              color: hexStringToColor('EDE3EE'),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                  margin: const EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: MyColors.white, width: 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Image.asset(
                    Assets.purchaseOutstanding,
                    scale: 1.7,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Purchase Outstanding : ",
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontFamily: MyFont.myFont2,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      letterSpacing: 0.5,
                      color: MyColors.drakgreyText),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "\$20000.00",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontFamily: MyFont.myFont3,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            letterSpacing: 0.5,
                            color: MyColors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// class ResendOrder extends StatefulWidget {
//   final String title;
//   final bool isSeleted;
//   final Function()? ontap;
//   const ResendOrder(
//       {super.key, required this.title, this.ontap, required this.isSeleted});
//
//   @override
//   State<ResendOrder> createState() => _ResendOrderState();
// }
//
// class _ResendOrderState extends State<ResendOrder> {
//   bool isSeleted1 = true;
//   bool isSeleted2 = false;
//   bool isSeleted3 = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.ontap,
//       child: Container(
//         padding: const EdgeInsets.all(10),
//         margin: const EdgeInsets.only(left: 18, right: 18, bottom: 10),
//         decoration: BoxDecoration(
//             color: widget.isSeleted ? MyColors.green : MyColors.mainTheme,
//             borderRadius: BorderRadius.circular(5),
//             border: Border.all(color: MyColors.greyBackground)),
//         child: Text(
//           widget.title,
//           style: TextStyle(
//               decoration: TextDecoration.none,
//               fontFamily: MyFont.myFont,
//               fontWeight: FontWeight.bold,
//               fontSize: 10,
//               color: widget.isSeleted == true
//                   ? MyColors.mainTheme
//                   : MyColors.white),
//         ),
//       ),
//     );
//   }
// }
  getDrawer(context) {
    return Drawer(
      width: width(context) / 1.2,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: MyColors.greyBackground)),
        child: Column(
          children: [
            DrawerHeader(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(60.0),
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: (userDetail?.itemImage != null)
                            ? Image.asset(
                                userDetail?.itemImage ?? "",
                                fit: BoxFit.fill,
                              )
                            : Image.asset(
                                Assets.placeholder,
                                fit: BoxFit.fill,
                              ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          widget.fabSelected = false;
                          Get.back();
                        },
                        child: Image.asset(
                          IconAssets.frwdArw,
                          scale: 1.8,
                        )),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  userDetail?.organisationName ?? '',
                  style: TextStyle(
                      fontFamily: MyFont.myFont2,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: MyColors.black),
                ),
                // Text('Information Technology Company',
                //     style: TextStyle(
                //         fontFamily: MyFont.myFont2,
                //         fontSize: 12,
                //         fontWeight: FontWeight.w500,
                //         color: MyColors.black)),
              ],
            )),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    listTile(Image.asset(IconAssets.dashBoard, scale: 1.8),
                        'Dashboard', () {
                      widget.fabSelected = false;
                      Get.to(const BottomNavBar());
                    }),
                    listTile(
                        const CustomGradient(
                          child: Icon(
                            Icons.category_rounded,
                            color: MyColors.white,
                            size: 28,
                          ),
                        ),
                        'Catalogue', () {
                      Get.to(const CatalogueScreen());
                    }),
                    expansionTile(
                        'Masters',
                        Image.asset(IconAssets.masters, scale: 1.8),
                        const EdgeInsets.only(
                          left: 60,
                        ),
                        [
                          listTile2(
                              '-Company', () => Get.to(const CompanyScreen())),
                          listTile2(
                              '-Customer', () => Get.to(const CustomerList())),
                          listTile2(
                              '-Supplier', () => Get.to(const SupplierList())),
                          listTile2('-Tax', () => Get.to(const TaxList())),
                          listTile2('-Bank', () => Get.to(const BankList())),
                          listTile2(
                              '-Paymode', () => Get.to(const PayModeList())),
                        ]),
                    expansionTile(
                        'Product',
                        Image.asset(IconAssets.product, scale: 1.8),
                        const EdgeInsets.only(
                          left: 60,
                        ),
                        [
                          listTile2('-Product',
                              () => Get.toNamed(AppRoutes.productList)),
                          listTile2('-Brand', () => Get.to(const BrandList())),
                          listTile2(
                              '-Category', () => Get.to(const CategoryList())),
                          listTile2('-Sub Category',
                              () => Get.toNamed(AppRoutes.subCategoryList)),
                          listTile2('-UOM', () => Get.to(const UomList())),
                          listTile2('-Product Stock',
                              () => Get.to(const ProductStockList())),
                        ]),
                    expansionTile(
                        'Purchase',
                        Image.asset(IconAssets.purchase, scale: 1.8),
                        const EdgeInsets.only(
                          left: 60,
                        ),
                        [
                          listTile2('-Purchase Order',
                              () => Get.to(const PurchaseOrderList())),
                          listTile2('-Stock In Do',
                              () => Get.to(const StockInDoList())),
                          listTile2('-Goods receive',
                              () => Get.to(const GoodsReceiveList())),
                          listTile2('-Purchase Return',
                              () => Get.to(const PurchaseReturnList())),
                          listTile2(
                              '-Payment', () => Get.to(const PaymentList())),
                        ]),
                    expansionTile(
                        'Sales',
                        Image.asset(IconAssets.sales, scale: 1.8),
                        const EdgeInsets.only(
                          left: 60,
                        ),
                        [
                          listTile2('-Sales Order', () {
                            Get.toNamed(AppRoutes.salesInvoicesTabBarScreen);
                          }),
                          listTile2('-Delivery Order', () {
                            Get.toNamed(AppRoutes.deliveryOrderList);
                          }),
                          // listTile2(
                          //     '-Invoice',
                          //     () => Get.toNamed(
                          //         AppRoutes.salesInvoicesTabBarScreen)),
                          listTile2('-Sales Return',
                              () => Get.toNamed(AppRoutes.salesReturnList)),
                          listTile2('-Receipt',
                              () => Get.toNamed(AppRoutes.receiptList)),
                        ]),
                    expansionTile(
                        'Stock',
                        Image.asset(IconAssets.stock, scale: 1.8),
                        const EdgeInsets.only(
                          left: 60,
                        ),
                        [
                          listTile2('-Product Stock',
                              () => Get.toNamed(AppRoutes.stockProductList)),
                          listTile2('-Stock Adjustment',
                              () => Get.toNamed(AppRoutes.stockAdjustmentList)),
                          listTile2('-Stock Take',
                              () => Get.toNamed(AppRoutes.stockTakeList)),
                          listTile2('-Stock Transfer',
                              () => Get.toNamed(AppRoutes.stockTransferList)),
                        ]),
                    listTile(Image.asset(IconAssets.account, scale: 1.8),
                        'Account', () => null),
                    listTile(
                        Image.asset(IconAssets.settlement, scale: 1.8),
                        'Settlement',
                        () => Get.toNamed(AppRoutes.settlementList)),
                  ],
                ),
              ),
            ),
            const Divider(),
            listTile(Image.asset(IconAssets.logout, scale: 1.8), 'Logout',
                () => Get.toNamed(AppRoutes.loginScreen)),
          ],
        ),
      ),
    );
  }

  ListTile listTile(Widget leading, String name, Function()? onTap) {
    bool isSelected = false;
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        name,
        style: TextStyle(
            fontFamily: MyFont.myFont2,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? MyColors.lightgrey : MyColors.black5F5F5F),
      ),
    );
  }

  GestureDetector listTile2(String name, Function()? onTap) {
    bool isSelected = true;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Text(
          name,
          // textAlign: TextAlign.start,
          style: TextStyle(
              fontFamily: MyFont.myFont2,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: hexStringToColor('202020')),
        ),
      ),
    );
  }

  ExpansionTile expansionTile(String title, Widget leading,
      EdgeInsetsGeometry childrenPadding, List<Widget> children) {
    bool isSelected = false;
    return ExpansionTile(
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      expandedAlignment: Alignment.bottomLeft,
      title: Text(
        title,
        style: TextStyle(
            fontFamily: MyFont.myFont2,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: MyColors.black5F5F5F),
      ),
      leading: leading,
      childrenPadding: childrenPadding,
      children: children,
    );
  }

  tapBarWidget(
      {required BuildContext context,
      required String heading1,
      required String heading2,
      required String heading3}) {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 18, top: 8, bottom: 8),
      margin: const EdgeInsets.only(left: 18, right: 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          MyColors.gradient1,
          MyColors.gradient2,
          MyColors.gradient3,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
      ),
      child: Table(
        children: [
          TableRow(children: [
            Text(
              heading1,
              textAlign: TextAlign.start,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: MyFont.myFont2,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: MyColors.white),
            ),
            Text(
              heading2,
              textAlign: TextAlign.start,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: MyFont.myFont2,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: MyColors.white),
            ),
            Text(
              heading3,
              textAlign: TextAlign.center,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: MyFont.myFont2,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: MyColors.white),
            ),
          ]),
        ],
      ),
    );
  }
}
