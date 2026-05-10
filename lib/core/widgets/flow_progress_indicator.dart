import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

class FlowProgressIndicator extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const FlowProgressIndicator({
    super.key,
    required this.currentStep,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[100]!, width: 1),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(steps.length, (index) {
              bool isLast = index == steps.length - 1;
              bool isActive = index <= currentStep;
              bool isCompleted = index < currentStep;

              return Expanded(
                flex: isLast ? 0 : 1,
                child: Row(
                  children: [
                    // Step Point
                    Container(
                      width: 22.w,
                      height: 22.w,
                      decoration: BoxDecoration(
                        color: isActive ? appColors.primaryColorYellow : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isActive ? appColors.primaryColorYellow : Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: isCompleted 
                          ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                          : Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: isActive ? Colors.white : Colors.grey[400],
                              ),
                            ),
                      ),
                    ),
                    
                    // Connected Line with Separator
                    if (!isLast) 
                      Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 2.h,
                              color: isCompleted ? appColors.primaryColorYellow : Colors.grey[200],
                            ),
                            // Separator mark
                            Container(
                              width: 1.5.w,
                              height: 6.h,
                              color: isCompleted ? appColors.primaryColorYellow : Colors.grey[300],
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
          verticalSpace(8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(steps.length, (index) {
              bool isActive = index <= currentStep;
              return Expanded(
                child: Text(
                  steps[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                    color: isActive ? appColors.blue100 : Colors.grey[400],
                    fontFamily: 'Cairo',
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
