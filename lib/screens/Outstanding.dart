import 'package:erp/Helper/colors.dart';
import 'package:flutter/material.dart';

class Outstanding extends StatefulWidget {
  const Outstanding({super.key});

  @override
  State<Outstanding> createState() => _OutstandingState();
}

class _OutstandingState extends State<Outstanding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: MyColors.red,
    ));
  }
}
