// ignore_for_file: file_names

import 'dart:async';

import 'package:erp/Helper/appRoute.dart';
import 'package:erp/Helper/assets.dart';
import 'package:erp/Helper/colors.dart';
import 'package:erp/Helper/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1>
    with TickerProviderStateMixin {
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
                  child: Transform.rotate(
                    origin: Offset.zero,
                    angle: _controller.value * 8,
                    child: child,
                  ),
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
      begin: 500,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    _controller.forward();
    // Get.offAllNamed(AppRoutes.splashScreen2);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 1),
          () => Get.offAllNamed(AppRoutes.splashScreen2));
    });
  }
}
