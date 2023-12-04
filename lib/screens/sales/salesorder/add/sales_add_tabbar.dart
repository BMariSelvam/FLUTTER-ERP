import 'package:erp/Helper/fonts.dart';
import 'package:erp/screens/sales/salesorder/add/AddSalesProduct/productsales.dart';
import 'package:erp/screens/sales/salesorder/add/AddSalesSummary/summary_sales.dart';
import 'package:erp/screens/sales/salesorder/add/AddSalesSummary/summary_sales_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../Helper/colors.dart';
import '../../../../Helper/custom_gradient.dart';
import 'AddSalesCustomer/customersales.dart';
import 'AddSalesCustomer/customersalescontroller.dart';
import 'AddSalesProduct/productsalescontroller.dart';

class SalesAddTabBar extends StatefulWidget {
  const SalesAddTabBar({super.key});

  @override
  _SalesAddTabBarState createState() => _SalesAddTabBarState();
}

class _SalesAddTabBarState extends State<SalesAddTabBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late CustomerSalesController cusController;
  late SalesProductController proController;
  late SummarySalesController sumController;

  List<Widget> tabs = [
    const CustomGradient(child: Tab(text: 'Customer')),
    const CustomGradient(child: Tab(text: 'Product')),
    const CustomGradient(child: Tab(text: 'Summary')),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    cusController = Get.put(CustomerSalesController());
    proController = Get.put(SalesProductController());
    sumController = Get.put(SummarySalesController());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side:
                        const BorderSide(color: MyColors.mainTheme, width: 2)),
                surfaceTintColor: MyColors.white,
                title: const Text('Are you sure to exit Sales Order Create ?'),
                actionsAlignment: MainAxisAlignment.spaceAround,
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      'No',
                      style: TextStyle(
                          fontFamily: MyFont.myFont2,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: MyColors.red),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context, true);
                      });
                    },
                    child: CustomGradient(
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          fontFamily: MyFont.myFont2,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        },
        child: DefaultTabController(
          length: tabs.length,
          child: Scaffold(
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
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: MyColors.white,
                  size: 18,
                ),
                onPressed: () async {
                  proController.productList?.clear();
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                                color: MyColors.mainTheme, width: 2)),
                        surfaceTintColor: MyColors.white,
                        title: const Text(
                            'Are you sure to exit Sales Order Create ?'),
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              'No',
                              style: TextStyle(
                                  fontFamily: MyFont.myFont2,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.red),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                // Navigator.pop(context, true);
                                Get.close(2);
                              });
                            },
                            child: CustomGradient(
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                  fontFamily: MyFont.myFont2,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  return;
                },
              ),
              titleTextStyle: TextStyle(
                  fontFamily: MyFont.myFont2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.white),
              titleSpacing: -10,
              title: const Text("SalesOrder Create"),
              bottom: PreferredSize(
                  preferredSize: tabBar.preferredSize,
                  child: Material(
                    color: MyColors.white,
                    child: tabBar,
                  )),
            ),
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                CustomerSales(),
                ProductSales(),
                SummarySales(),
              ],
            ),
          ),
        ));
  }

  TabBar get tabBar => TabBar(
        controller: tabController,
        tabs: tabs,
        onTap: (index) {
          setState(() {
            _updateTabs();
          });
        },
      );

  /// Currently Working code

  void _updateTabs() {
    if (cusController.isCusSelected) {
      tabController.index;
    } else {
      tabController.animateTo(0);
      Fluttertoast.showToast(msg: "Please Select Customer");
    }
  }
}
