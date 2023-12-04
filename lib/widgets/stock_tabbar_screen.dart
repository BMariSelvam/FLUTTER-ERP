import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/Helper/fonts.dart';
import 'package:erp/screens/stock/stockAdjustment/add/stock_product_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/colors.dart';
import '../screens/stock/stockAdjustment/add/stock_product_add.dart';

class StockTabBarScreen extends StatefulWidget {
  const StockTabBarScreen({super.key});

  @override
  _StockTabBarScreenState createState() => _StockTabBarScreenState();
}

class _StockTabBarScreenState extends State<StockTabBarScreen>
    with SingleTickerProviderStateMixin {
  bool isSelectedFilter = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
              preferredSize: tabBar.preferredSize,
              child: Material(
                color: MyColors.white,
                child: tabBar,
              )),
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
              padding: const EdgeInsets.only(right: 25),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelectedFilter = !isSelectedFilter;
                  });
                },
                child: Image.asset(
                  IconAssets.search,
                  scale: 1.8,
                ),
              ),
            )
          ],
          titleSpacing: -15,
          title: Text(
            "Stock",
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
        body: const TabBarView(
          children: [
            StockProductAdd(),
            StockProductSummaryList(),
          ],
        ),
      ),
    );
  }
}

TabBar get tabBar => const TabBar(
      indicatorColor: MyColors.primaryCustom,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: [
        CustomGradient(child: Tab(text: 'Product')),
        CustomGradient(child: Tab(text: 'Summary')),
      ],
    );
