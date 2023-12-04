import 'package:erp/Helper/colors.dart';
import 'package:flutter/material.dart';

class PaidScreen extends StatefulWidget {
  const PaidScreen({super.key});

  @override
  State<PaidScreen> createState() => _PaidScreenState();
}

class _PaidScreenState extends State<PaidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: MyColors.green,
    ));
  }
}
