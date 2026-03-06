import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_cubit.dart';
import 'package:shimmer/shimmer.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/router/routes.dart';
import '../../data/models/learning_paths_response.dart';
import '../../logic/learning_path_state.dart';

class LearningPathsPage extends StatefulWidget {
  const LearningPathsPage({super.key});

  @override
  State<LearningPathsPage> createState() => _LearningPathsPageState();
}

class _LearningPathsPageState extends State<LearningPathsPage> {
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (mounted) {
        _loadData();
      }
    });
  }

  void _loadData() {
    if (_isFirstLoad) {
      getit<LearningPathCubit>().getLearningPaths();
      _isFirstLoad = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = getit<LearningPathCubit>();
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.trainingTracks.tr(), style: TextStyles.cairo_15_bold),
          centerTitle: true,
          backgroundColor: appColors.white,
          elevation: 0,
        ),
        body: BlocBuilder<LearningPathCubit, LearningPathState>(
          builder: (context, state) {
            if (state is LearningPathsLoading) {
              return _buildLoadingShimmer();
            } else if (state is LearningPathsLoaded) {
              if (state.paths.isEmpty) {
                return Center(
                  child: Text('لا توجد مسارات تعلم حالياً', style: TextStyles.cairo_14_regular),
                );
              }
              return _buildContent(state.paths);
            } else if (state is LearningPathError) {
              return Center(
                child: Text('حدث خطأ: ${state.message}', style: TextStyles.cairo_14_regular),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 5,
      itemBuilder: (context, index) => _buildShimmerCard(),
    );
  }

  Widget _buildShimmerCard() {
    return Shimmer.fromColors(
      baseColor: appColors.grey1,
      highlightColor: appColors.grey8,
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        height: 100.h,
        decoration: BoxDecoration(
          color: appColors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  Widget _buildLearningPathItem(LearningPath path, int index) {
    return Container(
      margin: EdgeInsets.only(
        left: 0.w,
        right: 0.w,
        bottom: 8.h,
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.learningPath,
            arguments: path.id,
          );
        },
        child: Row(
          children: [
            Container(
              width: 4,
              height: 60.h,
              decoration: BoxDecoration(
                color: index.isEven ? appColors.primaryColorYellow : appColors.blue100,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
            ),
            SizedBox(width: 20.w),
            SvgPicture.asset(
              AppAssets.booksNew,
              width: 24.sp,
              height: 24.sp,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    path.title.trim(),
                    style: TextStyles.cairo_13_bold.copyWith(
                      color: appColors.blue100,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: appColors.grey10,
            ),
            SizedBox(width: 24.w),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: appColors.grey10, size: 48.r),
          SizedBox(height: 16.h),
          Text(
            'لا توجد مسارات تعلم متاحة حالياً',
            style: TextStyles.cairo_14_medium.copyWith(
              color: appColors.grey10,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: appColors.red, size: 48.r),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyles.cairo_14_medium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _loadData,
            style: ElevatedButton.styleFrom(
              backgroundColor: appColors.primaryColorYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(List<LearningPath> paths) {
    if (paths.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<LearningPathCubit>().getLearningPaths();
      },
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: paths.length,
        itemBuilder: (context, index) {
          return _buildLearningPathItem(paths[index], index);
        },
      ),
    );
  }
} 
