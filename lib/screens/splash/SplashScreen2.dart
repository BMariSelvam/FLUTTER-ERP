import 'dart:async';
import 'dart:math';

import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2>
    with TickerProviderStateMixin {
  double _width = 100;
  double _height = 100;
  final Color _color = MyColors.white;
  late AnimationController _controller;
  late Animation _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.white,
        body: Stack(
          children: [
            Container(
              height: height(context),
              width: width(context),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                MyColors.gradient1,
                MyColors.gradient2,
                MyColors.gradient3,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            Center(
                child: AnimatedBuilder(
              animation: _controller,
              child: Container(
                width: 10,
                height: 10,
                color: Colors.transparent,
                child: Center(
                  child: Image.asset(
                    Assets.logo,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.scale(
                  scale: _animation.value,
                  child: child,
                );
              },
            )),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animation = Tween<double>(
      begin: 0,
      end: 15,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    _controller.forward();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3),
          () => Get.offAllNamed(AppRoutes.loginScreen));
    });
  }
}
