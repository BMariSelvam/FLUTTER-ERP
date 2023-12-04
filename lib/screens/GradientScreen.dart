import 'package:erp/Helper/size.dart';
import 'package:flutter/material.dart';

import '../Helper/colors.dart';

class GradientScreen extends StatelessWidget {
  const GradientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height(context),
        width: width(context),
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          MyColors.gradient1,
          MyColors.gradient2,
          MyColors.gradient3,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      ),
    );
  }
}
