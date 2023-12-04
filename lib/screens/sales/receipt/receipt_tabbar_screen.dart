import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/custom_gradient.dart';
import 'package:erp/screens/sales/receipt/add_receipt.dart';
import 'package:erp/screens/sales/receipt/add_receipt_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiptTabBarScreen extends StatefulWidget {
  const ReceiptTabBarScreen({super.key});

  @override
  _ReceiptTabBarScreenState createState() => _ReceiptTabBarScreenState();
}

class _ReceiptTabBarScreenState extends State<ReceiptTabBarScreen>
    with SingleTickerProviderStateMixin {
  late AddReceiptController listController;

  @override
  void initState() {
    super.initState();
    listController = Get.put(AddReceiptController());
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: TabBarView(
          children: [AddReceipt(), AddReceipt()],
        ),
      ),
    );
  }
}

TabBar get tabBar => const TabBar(
      indicatorColor: MyColors.primaryCustom,
      indicatorSize: TabBarIndicatorSize.label,
      tabs: [
        CustomGradient(child: Tab(text: 'Customer')),
        CustomGradient(child: Tab(text: 'Summary')),
      ],
    );
