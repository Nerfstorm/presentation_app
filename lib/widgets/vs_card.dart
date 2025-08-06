import 'package:flutter/material.dart';

class VsCard extends StatelessWidget {
  final Widget child;
  const VsCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewX(-0.1),
      child: Card(
        elevation: 4,
        child: Transform(
          transform: Matrix4.skewX(0.1),
          child: child,
        ),
      ),
    );
  }
}
