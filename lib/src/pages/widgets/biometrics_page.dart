import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:lottie_practice/src/core/constants/lotties.dart';

class FlyingPlanePage extends StatefulWidget {
  const FlyingPlanePage({
    Key? key,
    this.customPaintSize = 200.0,
  }) : super(key: key);

  final double customPaintSize;

  @override
  State<FlyingPlanePage> createState() => _FlyingPlanePageState();
}

class _FlyingPlanePageState extends State<FlyingPlanePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          flyingPlane,
          width: 250,
          height: 250,
          frameRate: FrameRate(60),
          repeat: false,
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward().whenComplete(() => Navigator.pop(context));
          },
        ),
      ),
    );
  }
}
