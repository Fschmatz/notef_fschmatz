import 'package:flutter/material.dart';

export 'section_segmented_widget_list.dart';

class SegmentedWidgetList extends StatelessWidget {
  final List<Widget> children;
  final double largeRadius;
  final double smallRadius;
  final double gap;
  final Color? color;
  final double elevation;
  final EdgeInsetsGeometry? margin;

  const SegmentedWidgetList({
    super.key,
    required this.children,
    this.largeRadius = 16.0,
    this.smallRadius = 4.0,
    this.gap = 2.0,
    this.color,
    this.elevation = 0.0,
    this.margin,
  });

  BorderRadius _getBorderRadius(int index, int total) {
    if (total == 1) {
      return BorderRadius.circular(largeRadius);
    }

    if (index == 0) {
      return BorderRadius.vertical(
        top: Radius.circular(largeRadius),
        bottom: Radius.circular(smallRadius),
      );
    }

    if (index == total - 1) {
      return BorderRadius.vertical(
        top: Radius.circular(smallRadius),
        bottom: Radius.circular(largeRadius),
      );
    }

    return BorderRadius.all(Radius.circular(smallRadius));
  }

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    final cardColor = color ?? Theme.of(context).cardTheme.color ?? Theme.of(context).colorScheme.surfaceContainerHigh;

    final column = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(children.length, (index) {
        final isLast = index == children.length - 1;
        final borderRadius = _getBorderRadius(index, children.length);

        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0.0 : gap),
          child: Material(
            color: cardColor,
            elevation: elevation,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            child: children[index],
          ),
        );
      }),
    );

    if (margin != null) {
      return Padding(
        padding: margin!,
        child: column,
      );
    }

    return column;
  }
}
