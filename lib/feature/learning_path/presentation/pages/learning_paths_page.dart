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
import '../widgets/learning_path_card.dart';

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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: appColors.white,
          appBar: AppBar(
            title: Text('مسارات التعلم', style: TextStyles.cairo_15_bold),
            centerTitle: true,
            backgroundColor: appColors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: appColors.blue100, size: 20.sp),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.print_outlined, color: appColors.blue100),
                onPressed: () {},
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: appColors.grey1,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: appColors.primaryColorYellow,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  labelColor: appColors.white,
                  unselectedLabelColor: appColors.grey10,
                  labelStyle: TextStyles.cairo_13_bold,
                  tabs: const [
                    Tab(text: 'مسارات التدريب'),
                    Tab(text: 'مساراتي'),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              _buildPathsList(cubit, false),
              _buildPathsList(cubit, true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPathsList(LearningPathCubit cubit, bool isMyPaths) {
    return BlocBuilder<LearningPathCubit, LearningPathState>(
      builder: (context, state) {
        final paths = cubit.paths;

        if (state is LearningPathsLoading && paths == null) {
          return _buildLoadingShimmer();
        } else if (paths != null) {
          // For now, filtering locally if we don't have separate APIs.
          // In a real scenario, we might call different methods in cubit.
          final displayedPaths = isMyPaths ? paths.where((p) => p.id % 2 == 0).toList() : paths;

          if (displayedPaths.isEmpty) {
            return _buildEmptyState(isMyPaths ? 'لا توجد مسارات ملتحق بها حالياً' : 'لا توجد مسارات تدريب متاحة');
          }
          return RefreshIndicator(
            onRefresh: () async => cubit.getLearningPaths(),
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: displayedPaths.length,
              itemBuilder: (context, index) {
                return LearningPathCard(
                  path: displayedPaths[index],
                  onTap: () {
                    if (isMyPaths) {
                      Navigator.pushNamed(
                        context,
                        Routes.learningPath,
                        arguments: displayedPaths[index].id,
                      );
                    } else {
                      Navigator.pushNamed(
                        context,
                        Routes.learningPathDetails,
                        arguments: displayedPaths[index].id,
                      );
                    }
                  },
                );
              },
            ),
          );
        } else if (state is LearningPathError) {
          return _buildErrorState(state.message);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: appColors.grey10, size: 48.r),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextStyles.cairo_14_medium.copyWith(color: appColors.grey10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        );
      },
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
            style: TextStyles.cairo_14_medium.copyWith(color: appColors.red),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => getit<LearningPathCubit>().getLearningPaths(),
            child: Text('إعادة المحاولة', style: TextStyles.cairo_12_regular),
          )
        ],
      ),
    );
  }
}
