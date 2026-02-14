import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final Gradient initialGradient;
  final Gradient expandedGradient;
  final EdgeInsetsGeometry padding;

  const CustomExpansionTile({
    super.key,
    required this.title,
    required this.children,
    required this.initialGradient,
    required this.expandedGradient,
    this.padding = const EdgeInsets.all(10.0),
  });

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header (Click to expand/collapse)
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 500),
            tween: Tween<double>(begin: 0.0, end: _isExpanded ? 1.0 : 0.0),
            builder: (context, value, child) {
              final interpolatedColors = [
                Color.lerp(
                  (widget.initialGradient as LinearGradient).colors[0],
                  (widget.expandedGradient as LinearGradient).colors[0],
                  value,
                )!,
                Color.lerp(
                  (widget.initialGradient as LinearGradient).colors[1],
                  (widget.expandedGradient as LinearGradient).colors[1],
                  value,
                )!,
              ];

              // Adding borderRadius animation
              final borderRadius = BorderRadius.only(
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
                bottomLeft: Radius.circular(25.r - (value * 25)),
                // animate to 0
                bottomRight:
                    Radius.circular(25.r - (value * 25)), // animate to 0
              );

              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: interpolatedColors,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: borderRadius,
                ),
                padding: widget.padding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: Colors.white,
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // Content (Visible when expanded)
        AnimatedCrossFade(
          duration: Duration(milliseconds: 500),
          crossFadeState: _isExpanded
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Container(
            decoration: BoxDecoration(
              color: appColors.grey3,
              border: Border.fromBorderSide(
                BorderSide(color: appColors.grey2),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.r),
                bottomRight: Radius.circular(25.r),
              ),
            ),
            child: Column(
              children: widget.children,
            ),
          ),
          secondChild: SizedBox.shrink(),
        ),
      ],
    );
  }
}
