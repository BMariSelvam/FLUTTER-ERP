import 'package:erp/Helper/colors.dart';
import 'package:flutter/material.dart';

class PaidSales extends StatefulWidget {
  const PaidSales({super.key});

  @override
  State<PaidSales> createState() => _PaidSalesState();
}

class _PaidSalesState extends State<PaidSales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: MyColors.greyText,
        ));
  }
}
