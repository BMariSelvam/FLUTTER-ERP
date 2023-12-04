import 'package:erp/Helper/colors.dart';
import 'package:flutter/material.dart';

class CustomGradient extends StatefulWidget {
  final Widget? child;

  const CustomGradient({Key? key, this.child}) : super(key: key);

  @override
  State<CustomGradient> createState() => _CustomGradientState();
}

class _CustomGradientState extends State<CustomGradient> {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (rect) => const LinearGradient(
        colors: [
          MyColors.gradient1,
          MyColors.gradient2,
          MyColors.gradient3,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect),
      child: widget.child,
    );
  }
}
