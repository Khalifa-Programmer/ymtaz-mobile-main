import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_cubit.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_state.dart';

class LearningPathVideoPage extends StatefulWidget {
  final int pathId;

  const LearningPathVideoPage({super.key, required this.pathId});

  @override
  State<LearningPathVideoPage> createState() => _LearningPathVideoPageState();
}

class _LearningPathVideoPageState extends State<LearningPathVideoPage> {
  // Placeholder for a video controller index or currently playing item
  int _currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    getit<LearningPathCubit>().getPathItems(widget.pathId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<LearningPathCubit>(),
      child: Scaffold(
        backgroundColor: appColors.white,
        appBar: AppBar(
          title: Text('دورة تدريبية', style: TextStyles.cairo_15_bold),
          centerTitle: true,
          backgroundColor: appColors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: appColors.blue100, size: 20.sp),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.print_outlined, color: appColors.blue100, size: 20.sp),
              onPressed: () {},
            )
          ],
        ),
        body: Column(
          children: [
            _buildVideoPlayerPlaceholder(),
            Expanded(
              child: _buildCourseContentTree(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayerPlaceholder() {
    return Container(
      width: double.infinity,
      height: 220.h,
      color: Colors.black87,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.play_circle_fill, color: appColors.white, size: 60.sp),
          Positioned(
            bottom: 10.h,
            left: 15.w,
            right: 15.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '00:00 / 15:30',
                  style: TextStyles.cairo_10_bold.copyWith(color: appColors.white),
                ),
                Icon(Icons.fullscreen, color: appColors.white, size: 20.sp),
              ],
            ),
          ),
          Positioned(
            bottom: 5.h,
            left: 0,
            right: 0,
            child: LinearProgressIndicator(
              value: 0.3,
              backgroundColor: appColors.grey1.withOpacity(0.5),
              valueColor: const AlwaysStoppedAnimation<Color>(appColors.primaryColorYellow),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCourseContentTree() {
    return BlocBuilder<LearningPathCubit, LearningPathState>(
      builder: (context, state) {
        if (state is LearningPathItemsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LearningPathItemsLoaded) {
          final items = state.items;
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('محتوى الدورة', style: TextStyles.cairo_14_bold.copyWith(color: appColors.blue100)),
                    Text(
                      '${items.length} دروس',
                      style: TextStyles.cairo_12_regular.copyWith(color: appColors.grey10),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                ...List.generate(items.length, (index) {
                  final item = items[index];
                  // Let's assume the first item is playing, second is unlocked but not playing, rest are locked or completed
                  bool isPlaying = index == _currentVideoIndex;
                  bool isCompleted = index < _currentVideoIndex; // Dummy logic
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: isPlaying ? appColors.lightYellow10 : appColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: isPlaying ? appColors.primaryColorYellow : appColors.grey1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Icon based on status
                        Icon(
                          isCompleted
                              ? Icons.check_circle
                              : isPlaying
                                  ? Icons.play_circle_fill
                                  : Icons.lock_outline,
                          color: isCompleted
                              ? Colors.green
                              : isPlaying
                                  ? appColors.primaryColorYellow
                                  : appColors.grey10,
                          size: 24.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.subcategory.name,
                                style: TextStyles.cairo_13_bold.copyWith(
                                  color: isPlaying ? appColors.primaryColorYellow : appColors.blue100,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'مدة الدرس ${index * 5 + 10} دقيقة',
                                style: TextStyles.cairo_11_regular.copyWith(color: appColors.grey10),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                
                SizedBox(height: 20.h),
                // Evaluation Button
                CustomButton(
                  title: 'تقييم الدورة',
                  onPress: () {
                    _showReviewSheet(context);
                  },
                ),
              ],
            ),
          );
        }

        return const Center(child: Text('لا توجد بيانات متاحة حاليا'));
      },
    );
  }

  void _showReviewSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('تقييم الدورة', style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100)),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) => Icon(Icons.star_outline, size: 40.sp, color: appColors.grey1)),
              ),
              SizedBox(height: 20.h),
              TextField(
                decoration: InputDecoration(
                  hintText: 'اكتب تقييمك...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                  fillColor: appColors.grey1.withOpacity(0.3),
                  filled: true,
                ),
                maxLines: 4,
              ),
              SizedBox(height: 20.h),
              CustomButton(
                title: 'إرسال التقييم',
                onPress: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
