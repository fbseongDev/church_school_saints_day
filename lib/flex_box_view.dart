import 'package:flutter/material.dart';

typedef FlexBoxAlignment = WrapAlignment;

class FlexBoxView extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final FlexBoxAlignment alignment;
  final double spacing;
  final double runSpacing;

  const FlexBoxView({
    required this.children,
    this.padding,
    this.alignment = FlexBoxAlignment.start,
    this.spacing = 0,
    this.runSpacing = 0,
  });

  factory FlexBoxView.builder({
    required int itemCount,
    required Function(BuildContext context, int index) itemBuilder,

    EdgeInsets? padding,
    FlexBoxAlignment alignment = FlexBoxAlignment.start,
    double spacing = 0,
    double runSpacing = 0,
  }) {
    return FlexBoxView(
      padding: padding,
      alignment: alignment,
      spacing: spacing,
      runSpacing: runSpacing,
      children: List.generate(itemCount, (index) {
        return Builder(builder: (context) => itemBuilder(context, index));
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Wrap(
        alignment: alignment,
        children: children,
        spacing: spacing,
        runSpacing: runSpacing,
      ),
    );
  }
}
