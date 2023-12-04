import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/screens/invoice/CreateInvoice/InvoiceCustomer/customercontroller.dart';
import 'package:erp/screens/invoice/CreateInvoice/InvoiceCustomer/customerscreen.dart';
import 'package:erp/screens/invoice/CreateInvoice/InvoiceProduct/productscreen.dart';
import 'package:erp/screens/invoice/CreateInvoice/InvoiceSummary/summary.dart';
import 'package:erp/screens/invoice/CreateInvoice/InvoiceSummary/summary_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Helper/colors.dart';
import 'InvoiceProduct/product_controller.dart';

class AddTabBarScreen extends StatefulWidget {
  const AddTabBarScreen({super.key});

  @override
  _AddTabBarScreenState createState() => _AddTabBarScreenState();
}

class _AddTabBarScreenState extends State<AddTabBarScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late CustomerController cusController;
  late ProductController proController;
  late SummaryController sumController;

  List<Widget> tabs = [
    const CustomGradient(child: Tab(text: 'Customer')),
    const CustomGradient(child: Tab(text: 'Product')),
    const CustomGradient(child: Tab(text: 'Summary')),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
    cusController = Get.put(CustomerController());
    proController = Get.put(ProductController());
    sumController = Get.put(SummaryController());
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
                  side: const BorderSide(color: MyColors.mainTheme, width: 2)),
              surfaceTintColor: MyColors.white,
              title: const Text('Are you sure to exit Invoice Create ?'),
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
        length: 3,
        child: Scaffold(
          appBar: AppBar(
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
                size: 18,
                color: MyColors.white,
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
                      title:
                          const Text('Are you sure to exit Invoice Create ?'),
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
            title: Text(
              'Invoice Create',
              style: TextStyle(
                  fontFamily: MyFont.myFont2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.white),
            ),
            titleSpacing: -10,
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
              CustomerScreen(),
              ProductScreen(),
              SummaryScreen(),
            ],
          ),
        ),
      ),
    );
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
