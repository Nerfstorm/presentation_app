import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';

/// A horizontally‐scrolling, infinite carousel of `items`.
/// You just give it a `count` and an `itemBuilder(index)`,
/// and it’ll wrap automatically.
class LoopingCarousel extends StatelessWidget {
  final int count;
  final IndexedWidgetBuilder itemBuilder;
  final double itemSpacing;
  final double height;

  const LoopingCarousel({
    super.key,
    required this.count,
    required this.itemBuilder,
    this.itemSpacing = 12,
    this.height = 120,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: InfiniteListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          final realIndex = index % count;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: itemSpacing / 2),
            child: itemBuilder(ctx, realIndex),
          );
        },
      ),
    );
  }
}
