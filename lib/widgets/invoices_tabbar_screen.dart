import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/screens/Outstanding.dart';
import 'package:erp/screens/invoice/AllScreen.dart';
import 'package:erp/screens/invoice/all_screen_controller.dart';
import 'package:erp/screens/paid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Helper/colors.dart';

class InvoicesTabBarScreen extends StatefulWidget {
  const InvoicesTabBarScreen({super.key});

  @override
  _InvoicesTabBarScreenState createState() => _InvoicesTabBarScreenState();
}

class _InvoicesTabBarScreenState extends State<InvoicesTabBarScreen>
    with SingleTickerProviderStateMixin {
  late AllScreenController listController;

  @override
  void initState() {
    super.initState();
    listController = Get.put(AllScreenController());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            AllScreen(tabBar: tabBar),
            const PaidScreen(),
            const Outstanding(),
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
        CustomGradient(child: Tab(text: 'All')),
        CustomGradient(child: Tab(text: 'Paid')),
        CustomGradient(child: Tab(text: 'Outstanding')),
      ],
    );
