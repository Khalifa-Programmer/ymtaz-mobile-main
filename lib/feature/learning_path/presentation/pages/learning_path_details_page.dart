import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_path_items_response.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_cubit.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_state.dart';

class LearningPathDetailsPage extends StatefulWidget {
  final int pathId;

  const LearningPathDetailsPage({super.key, required this.pathId});

  @override
  State<LearningPathDetailsPage> createState() => _LearningPathDetailsPageState();
}

class _LearningPathDetailsPageState extends State<LearningPathDetailsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getit<LearningPathCubit>().getPathItems(widget.pathId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<LearningPathCubit>(),
      child: Scaffold(
        backgroundColor: appColors.white,
        body: BlocBuilder<LearningPathCubit, LearningPathState>(
          builder: (context, state) {
            final cubit = getit<LearningPathCubit>();
            
            // For now, let's assume we have a way to get the path title
            final pathTitle = cubit.paths?.firstWhere((p) => p.id == widget.pathId).title ?? 'المسار التعليمي';

            return CustomScrollView(
              slivers: [
                _buildSliverAppBar(pathTitle),
                SliverFillRemaining(
                  child: Column(
                    children: [
                      _buildTabBar(),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildAboutTab(),
                            _buildContentTab(state),
                            _buildReviewsTab(),
                          ],
                        ),
                      ),
                      _buildBottomAction(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(String title) {
    return SliverAppBar(
      expandedHeight: 200.h,
      pinned: true,
      backgroundColor: appColors.blue100,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: appColors.white, size: 20.sp),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.share_outlined, color: appColors.white), onPressed: () {}),
        IconButton(icon: const Icon(Icons.favorite_border, color: appColors.white), onPressed: () {}),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Image placeholder
            Container(color: appColors.blue100),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
            Positioned(
              bottom: 16.h,
              right: 16.w,
              left: 16.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyles.cairo_18_bold.copyWith(color: appColors.white),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: appColors.primaryColorYellow,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          'محترف',
                          style: TextStyles.cairo_10_bold.copyWith(color: appColors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(Icons.star, color: appColors.primaryColorYellow, size: 14.sp),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text('4.6', style: TextStyles.cairo_12_bold.copyWith(color: appColors.white)),
                      const Spacer(),
                      const Icon(Icons.import_contacts, color: appColors.primaryColorYellow, size: 16),
                      SizedBox(width: 4.w),
                      Text('5 أنظمة', style: TextStyles.cairo_12_regular.copyWith(color: appColors.white)),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text('299 ريال', style: TextStyles.cairo_14_bold.copyWith(color: appColors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: appColors.grey1, width: 2)),
      ),
      child: TabBar(
        controller: _tabController,
        labelColor: appColors.primaryColorYellow,
        unselectedLabelColor: appColors.grey10,
        indicatorColor: appColors.primaryColorYellow,
        labelStyle: TextStyles.cairo_13_bold,
        tabs: const [
          Tab(text: 'عن المسار'),
          Tab(text: 'المحتوى'),
          Tab(text: 'التقييمات'),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'لوريم إيبسوم هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر.',
            style: TextStyles.cairo_13_regular.copyWith(color: appColors.blue100),
          ),
          SizedBox(height: 24.h),
          Text('مميزات المسار', style: TextStyles.cairo_14_bold.copyWith(color: appColors.primaryColorYellow)),
          SizedBox(height: 12.h),
          ...List.generate(
              4,
              (index) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_outline, color: appColors.primaryColorYellow, size: 18),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'لوريم إيبسوم هو ببساطة نص شكلي',
                            style: TextStyles.cairo_12_regular.copyWith(color: appColors.blue100),
                          ),
                        ),
                      ],
                    ),
                  )),
        ],
      ),
    );
  }

  Widget _buildContentTab(LearningPathState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Content Items List
          if (state is LearningPathItemsLoading)
            const Center(child: CircularProgressIndicator())
          else if (state is LearningPathItemsLoaded)
            ...state.items.map((item) => Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: appColors.lightYellow10,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: const Icon(Icons.menu_book, color: appColors.primaryColorYellow, size: 16),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          item.subcategory.name,
                          style: TextStyles.cairo_13_bold.copyWith(color: appColors.blue100),
                        ),
                      ),
                      Text('12 مادة', style: TextStyles.cairo_12_bold.copyWith(color: appColors.blue100)),
                    ],
                  ),
                ))
          else
            const Center(child: Text('لا يوجد محتوى متاح')),
            
          SizedBox(height: 24.h),
          
          // Suggestions Section
          Text('مقترح لك', style: TextStyles.cairo_14_bold.copyWith(color: appColors.blue100)),
          SizedBox(height: 12.h),
          ...List.generate(
            3,
            (index) => Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: appColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: appColors.lightYellow10, width: 1.5),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: index == 0,
                    onChanged: (v) {},
                    activeColor: appColors.primaryColorYellow,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          index == 0 ? 'أنظمة العمل والرعاية' : 'أنظمة السياحة والآثار',
                          style: TextStyles.cairo_12_bold.copyWith(color: appColors.blue100),
                        ),
                        // SizedBox(height: 4.h),
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(Icons.star, color: appColors.primaryColorYellow, size: 10.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('299 ريال', style: TextStyles.cairo_12_bold.copyWith(color: appColors.blue100)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: 3,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.only(bottom: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundColor: appColors.grey1, radius: 20.r),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('عمرو أحمد', style: TextStyles.cairo_13_bold.copyWith(color: appColors.blue100)),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(Icons.star, color: appColors.primaryColorYellow, size: 12.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'لوريم إيبسوم هو ببساطة نص شكلي (بمعنى أن الغاية هي الشكل وليس المحتوى) ويُستخدم في صناعات المطابع ودور النشر.',
              style: TextStyles.cairo_11_regular.copyWith(color: appColors.grey10),
            ),
            if (index < 2) const Divider(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: appColors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: CustomButton(
        title: 'تابع للدفع',
        onPress: () {
          Navigator.pushNamed(context, Routes.learningPathPayment);
        },
      ),
    );
  }
}
