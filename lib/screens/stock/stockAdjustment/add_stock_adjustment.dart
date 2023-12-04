import 'package:erp/widgets/stock_tabbar_screen.dart';
import 'package:flutter/material.dart';

class AddStockAdjustment extends StatefulWidget {
  const AddStockAdjustment({Key? key}) : super(key: key);

  @override
  State<AddStockAdjustment> createState() => _AddStockAdjustmentState();
}

bool isSelectedFilter = false;

class _AddStockAdjustmentState extends State<AddStockAdjustment> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: StockTabBarScreen(),
    );
  }
}
