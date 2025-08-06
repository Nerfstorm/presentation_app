import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';

/// Use this widget in place of your old buildTechStack(...)
class TechMarquee extends StatefulWidget {
  const TechMarquee({super.key});

  @override
  State<TechMarquee> createState() => _TechMarqueeState();
}

class _TechMarqueeState extends State<TechMarquee> {
  final ScrollController _controller1 = ScrollController();
  final ScrollController _controller2 = ScrollController();
  late final Timer _timer1;
  late final Timer _timer2;

  // Your list of icons
  static const _icons = [
    SimpleIcons.linux,
    SimpleIcons.pytorch,
    SimpleIcons.python,
    SimpleIcons.flutter,
    SimpleIcons.flask,
    SimpleIcons.jetpackcompose,
    SimpleIcons.qgis, // GIS-style icon
    SimpleIcons.unity,
    SimpleIcons.dotnet, // .NET / C#
    SimpleIcons.react,
    SimpleIcons.minio, // MiniIO
  ];

  @override
  void initState() {
    super.initState();
    // Starts a periodic timer to auto-scroll each frame
    _timer1 = Timer.periodic(
      const Duration(milliseconds: 30),
      (_) => _autoScroll(_controller1, forward: true),
    );
    _timer2 = Timer.periodic(
      const Duration(milliseconds: 30),
      (_) => _autoScroll(_controller2, forward: false),
    );
  }

  void _autoScroll(ScrollController ctrl, {required bool forward}) {
    if (!ctrl.hasClients) return;
    final max = ctrl.position.maxScrollExtent;
    var next = ctrl.offset + (forward ? 1 : -1);
    if (next >= max) {
      // jump back to start
      ctrl.jumpTo(0);
    } else if (next <= 0) {
      // jump to end
      ctrl.jumpTo(max);
    } else {
      ctrl.jumpTo(next);
    }
  }

  @override
  void dispose() {
    _timer1.cancel();
    _timer2.cancel();
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Widget _buildLine(ScrollController ctrl) {
    // We'll repeat the icon list 20× so it feels “infinite”
    return ListView.builder(
      controller: ctrl,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, idx) {
        final icon = _icons[idx % _icons.length];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Icon(icon, size: 32),
        );
      },
      itemCount: _icons.length * 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60, child: _buildLine(_controller1)),
        const SizedBox(height: 12),
        SizedBox(height: 60, child: _buildLine(_controller2)),
      ],
    );
  }
}
