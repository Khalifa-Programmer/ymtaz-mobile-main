import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_requirements_response.dart';

class CustomCheckSelectLevelServices extends StatefulWidget {
  final List<YmtazLevelsPrice> items;
  final Function(YmtazLevelsPrice) onChanged;
  final int? selectedId;

  const CustomCheckSelectLevelServices({
    super.key,
    required this.items,
    required this.onChanged,
    this.selectedId,
  });

  @override
  _CustomCheckSelectLevelServicesState createState() =>
      _CustomCheckSelectLevelServicesState();
}

class _CustomCheckSelectLevelServicesState
    extends State<CustomCheckSelectLevelServices> {
  int? selectedId;

  @override
  void initState() {
    super.initState();
    selectedId = widget.selectedId;
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(
          duration: 1000.ms,
        )
      ],
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          final item = widget.items[index];
          final bool isSelected = selectedId == item.id;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedId = item.id;
              });
              widget.onChanged(item);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
              decoration: ShapeDecoration(
                color: appColors.white,
                shape: RoundedRectangleBorder(
                  // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(
                    color: isSelected
                        ? appColors.primaryColorYellow
                        : Colors.grey.shade300,
                    width: 1.w,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        isSelected ? Icons.check_circle : Icons.circle,
                        color: isSelected
                            ? appColors.primaryColorYellow
                            : appColors.grey1w5,
                      ),
                    ],
                  ),
                  horizontalSpace(10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.level!.name!,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? appColors.primaryColorYellow
                              : Colors.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${item.id!} يوم للرد على الخدمه',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
