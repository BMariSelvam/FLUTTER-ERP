import 'package:erp/Helper/colors.dart';
import 'package:flutter/material.dart';

class SalesOutstanding extends StatefulWidget {
  const SalesOutstanding({super.key});

  @override
  State<SalesOutstanding> createState() => _SalesOutstandingState();
}

class _SalesOutstandingState extends State<SalesOutstanding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.orangeAccent,
        ));
  }
}
