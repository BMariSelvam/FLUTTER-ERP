import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/widgets/Class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Helper/colors.dart';
import '../../../Helper/fonts.dart';
import '../salesorderother/sales_order_list.dart';

class SalesInvoicesTabBarScreen extends StatefulWidget {
  const SalesInvoicesTabBarScreen({super.key});

  @override
  _SalesInvoicesTabBarScreenState createState() =>
      _SalesInvoicesTabBarScreenState();
}

class _SalesInvoicesTabBarScreenState extends State<SalesInvoicesTabBarScreen>
    with SingleTickerProviderStateMixin {
  late InvoiceControllers invoiceControllers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    invoiceControllers = Get.put(InvoiceControllers());
    // controllers = Get.find<Controllers>();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          // appBar: AppBar(
          //   toolbarHeight: 80,
          //   leading: GestureDetector(
          //     onTap: () {
          //       Get.toNamed(AppRoutes.bottomNavBarScreen);
          //     },
          //     child: Image.asset(
          //       IconAssets.leftIcon,
          //       color: MyColors.white,
          //       scale: 1.3,
          //     ),
          //   ),
          //   actions: [
          //     IconButton(
          //       icon: Icon(
          //         invoiceControllers.isSelectedFilter
          //             ? Icons.filter_alt_outlined
          //             : Icons.filter_alt_off_outlined,
          //         color: MyColors.white,
          //         size: 35,
          //       ),
          //       onPressed: () {
          //         setState(() {
          //           invoiceControllers.isSelectedFilter =
          //               !invoiceControllers.isSelectedFilter;
          //         });
          //       },
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(0),
          //       child: IconButton(
          //         icon: const Icon(Icons.add_circle_outline_sharp,
          //             color: MyColors.white, size: 35),
          //         onPressed: () => Get.toNamed(AppRoutes.salesAddTabBar),
          //       ),
          //     ),
          //     // GestureDetector(
          //     //   onTap: () {
          //     //     setState(() {
          //     //       Get.back();
          //     //     });
          //     //   },
          //     //   child: Image.asset(
          //     //     IconAssets.backArrow,
          //     //     scale: 2,
          //     //     fit: BoxFit.fill,
          //     //   ),
          //     // ),
          //   ],
          //   title: const Text('Sales Order'),
          //   titleTextStyle: TextStyle(
          //       fontFamily: MyFont.myFont2,
          //       fontSize: 18,
          //       fontWeight: FontWeight.bold,
          //       color: MyColors.white),
          //   backgroundColor: Colors.transparent,
          //   shadowColor: Colors.transparent,
          //   flexibleSpace: Container(
          //     decoration: const BoxDecoration(
          //       gradient: LinearGradient(colors: [
          //         MyColors.gradient1,
          //         MyColors.gradient2,
          //         MyColors.gradient3,
          //       ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          //     ),
          //   ),
          // ),
          body: const SalesOrderList()
          // const TabBarView(
          //   children: [
          //     AllSales(),
          //     PaidSales(),
          //     SalesOutstanding(),
          //   ],
          // ),
          ),
    );
  }
}

// TabBar get tabBar => const TabBar(
//       indicatorColor: MyColors.primaryCustom,
//       indicatorSize: TabBarIndicatorSize.label,
//       tabs: [
//         CustomGradient(child: Tab(text: 'All')),
//         CustomGradient(child: Tab(text: 'Paid')),
//         CustomGradient(child: Tab(text: 'Outstanding')),
//       ],
//     );
