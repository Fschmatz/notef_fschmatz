import 'package:flutter/material.dart';

import 'segmented_widget_list.dart';

class SectionSegmentedWidgetList extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry titlePadding;
  final TextStyle? titleStyle;
  final Color? titleColor;
  final double largeRadius;
  final double smallRadius;
  final double gap;
  final Color? cardColor;
  final double elevation;

  const SectionSegmentedWidgetList({
    super.key,
    required this.title,
    required this.children,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    this.titlePadding = const EdgeInsets.fromLTRB(16, 0, 16, 16),
    this.titleStyle,
    this.titleColor,
    this.largeRadius = 16.0,
    this.smallRadius = 4.0,
    this.gap = 2.0,
    this.cardColor,
    this.elevation = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTitleStyle = titleStyle ??
        Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: titleColor ?? Theme.of(context).colorScheme.primary,
            );

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: titlePadding,
            child: Text(
              title,
              style: effectiveTitleStyle,
            ),
          ),
          SegmentedWidgetList(
            largeRadius: largeRadius,
            smallRadius: smallRadius,
            gap: gap,
            color: cardColor,
            elevation: elevation,
            children: children,
          ),
        ],
      ),
    );
  }
}
