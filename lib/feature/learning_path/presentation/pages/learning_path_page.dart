import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_path_items_response.dart';
import 'package:yamtaz/feature/learning_path/data/repos/learning_path_repo.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_cubit.dart';
import 'package:yamtaz/feature/learning_path/presentation/pages/view_law_details.dart';
import 'package:yamtaz/feature/learning_path/logic/favourite_items_cubit.dart';
import 'package:yamtaz/feature/learning_path/presentation/pages/favourites_page.dart';

import '../../logic/learning_path_state.dart';
import 'book_details_page.dart';

class LearningPathPage extends StatefulWidget {
  final int pathId;

  const LearningPathPage({
    super.key,
    required this.pathId,
  });

  @override
  State<LearningPathPage> createState() => _LearningPathPageState();
}

class _LearningPathPageState extends State<LearningPathPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<LearningPathCubit>().getPathItems(widget.pathId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مسار التعلم', style: TextStyles.cairo_15_bold),
        centerTitle: true,
        backgroundColor: appColors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: appColors.primaryColorYellow),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => FavouriteItemsCubit(getit<LearningPathRepo>()),
                    child: FavouritesPage(pathId: widget.pathId),
                  ),
                ),
              ).then((value) {
                if (value == true) {
                  _loadData();
                }
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<LearningPathCubit, LearningPathState>(
        buildWhen: (previous, current) => 
          current is LearningPathItemsLoading || 
          current is LearningPathItemsLoaded,
        builder: (context, state) {
          if (state is LearningPathItemsLoading) {
            return _buildLoadingShimmer();
          }

          if (state is LearningPathItemsLoaded) {
            if (state.error != null) {
              return _buildErrorState(state.error!);
            }
            return _buildContent(state.items, state.analytics);
          }

          return const SizedBox();
        },
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
      highlightColor: appColors.grey3,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        height: 100.h,
        decoration: BoxDecoration(
          color: appColors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    );
  }

  Widget _buildProgressCard({required PathAnalytics analytics}) {
    final totalItems = analytics.totalItems;
    final completedItems = analytics.readItems;
    final remainingItems = analytics.notDoneItems;
    final totalFavourites = analytics.totalFavourite;

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: appColors.grey10.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'التقدم في المسار',
                style: TextStyles.cairo_14_bold,
              ),
              Text(
                totalItems > 0 ? '$completedItems/$totalItems' : '-',
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.primaryColorYellow,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(2.r),
            child: LinearProgressIndicator(
              value: totalItems > 0 ? completedItems / totalItems : 0,
              backgroundColor: appColors.grey1,
              valueColor: AlwaysStoppedAnimation<Color>(appColors.primaryColorYellow),
              minHeight: 4.h,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStatItem(
                label: 'تمت القراءة',
                value: completedItems,
                total: totalItems,
                color: appColors.green,
              ),
              SizedBox(width: 32.w),
              _buildStatItem(
                label: 'متبقي',
                value: remainingItems,
                total: totalItems,
                color: appColors.red,
              ),
              SizedBox(width: 32.w),
              _buildStatItem(
                label: 'المفضلة',
                value: totalFavourites,
                total: totalItems,
                color: appColors.primaryColorYellow,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required int value,
    required int total,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyles.cairo_12_medium.copyWith(
            color: appColors.grey10,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          total > 0 ? value.toString() : '-',
          style: TextStyles.cairo_14_bold.copyWith(
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildPathSection({
    required String title,
    required List<PathItem> items,
    required IconData icon,
  }) {
    final totalItems = items.fold<int>(
      0,
      (sum, item) => sum + item.items.length,
    );
    final completedItems = items.fold<int>(
      0,
      (sum, item) => sum + item.items.where((subItem) => subItem.alreadyDone).length,
    );

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          color: appColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: appColors.grey10.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ExpansionTile(
          backgroundColor: appColors.white,
          collapsedBackgroundColor: appColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          leading: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: appColors.primaryColorYellow.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              icon,
              color: appColors.primaryColorYellow,
              size: 20.sp,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.cairo_14_bold,
              ),
              if (completedItems > 0) ...[
                Text(
                  'تم إكمال $completedItems من $totalItems',
                  style: TextStyles.cairo_12_regular.copyWith(
                    color: appColors.grey10,
                  ),
                ),
              ],
            ],
          ),
          trailing: RotatingArrowIcon(
            isExpanded: false,
          ),
          children: [
            Container(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 26.w,
                    child: Container(
                      width: 3,
                      color: appColors.grey3,
                    ),
                  ),
                  Column(
                    children: items.expand((item) =>
                      item.items.asMap().entries.map((entry) {
                        final index = entry.key;
                        final subItem = entry.value;
                        final isLast = index == item.items.length - 1;

                        return _buildSubItem(
                          type: item.type,
                          item: subItem,
                          index: index,
                          isLast: isLast, items: item.items,
                        );
                      })
                    ).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubItem({
    required String type,
    required ItemDetails item,
    required int index,
    required bool isLast, required List<ItemDetails> items,
  }) {
    return InkWell(
      onTap: () => _onItemTap(type, item, index, items),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 23.w,
                  height: 23.w,
                  decoration: BoxDecoration(
                    color: item.alreadyDone ? appColors.primaryColorYellow : appColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: item.alreadyDone ? Colors.transparent : appColors.grey3,
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: item.alreadyDone
                        ? Icon(
                            Icons.check,
                            color: appColors.white,
                            size: 16.sp,
                          )
                        : SizedBox(),
                  ),
                ),
                if (!isLast)
                  Positioned(
                    top: 32.w,
                    right: 15.w,
                    child: Container(
                      width: 2,
                      height: 24.h,
                      color: appColors.grey3,
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h , horizontal: 16.w),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: appColors.grey10.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: appColors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: item.alreadyDone ? Colors.transparent : appColors.grey3,
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyles.cairo_14_semiBold.copyWith(
                        color: item.alreadyDone ? appColors.grey10 : appColors.blue100,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTap(String type, ItemDetails item, int index, List<ItemDetails> items) {
    if (item.locked) {
      _showLockedItemDialog();
      return;
    }

    if (type == 'law-guide') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewLawDetails(
            currentIndex: index,
            items: items,
            pathId: widget.pathId,
          ),
        ),
      );
    } else if (type == 'book-guide') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetailsPage(
            currentIndex: index,
            items: items,
            pathId: widget.pathId,
          ),
        ),
      );
      // Navigator.pushNamed(
      //   context,
      //   Routes.bookDetails,
      //   arguments: {
      //     'sectionId': item.id,
      //     'learningPathItemId': item.learningPathItemId,
      //     'isRead': item.alreadyDone,
      //   },
      // ).then((value) {
      //   if (value == true) {
      //     _loadData();
      //   }
      // });
    }
  }

  void _showLockedItemDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'هذا العنصر مقفل',
          style: TextStyles.cairo_14_bold,
        ),
        content: Text(
          'يجب عليك إكمال العناصر السابقة أولاً',
          style: TextStyles.cairo_13_regular,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
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
            'لا توجد عناصر في هذا المسار',
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

  Widget _buildContent(List<PathItem> items, PathAnalytics analytics) {
    final groupedItems = <String, List<PathItem>>{};
    for (var item in items) {
      final categoryName = item.subcategory.name;
      if (!groupedItems.containsKey(categoryName)) {
        groupedItems[categoryName] = [];
      }
      groupedItems[categoryName]!.add(item);
    }

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<LearningPathCubit>().getPathItems(widget.pathId);
      },
      child: CustomScrollView(
        slivers: [
          if (analytics != null)
            SliverToBoxAdapter(
              child: _buildProgressCard(analytics: analytics),
            ),
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ...groupedItems.entries.map((entry) {
                  final categoryName = entry.key;
                  final items = entry.value;
                  return Column(
                    children: [
                      _buildPathSection(
                        title: categoryName,
                        items: items,
                        icon: items.first.type == 'law-guide' 
                            ? Icons.gavel 
                            : Icons.menu_book,
                      ),
                      SizedBox(height: 16.h),
                    ],
                  );
                }).toList(),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class RotatingArrowIcon extends StatefulWidget {
  final bool isExpanded;

  const RotatingArrowIcon({
    Key? key,
    required this.isExpanded,
  }) : super(key: key);

  @override
  State<RotatingArrowIcon> createState() => _RotatingArrowIconState();
}

class _RotatingArrowIconState extends State<RotatingArrowIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didUpdateWidget(RotatingArrowIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        color: appColors.primaryColorYellow.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value * 2 * 3.14,
            child: Icon(
              Icons.keyboard_arrow_down,
              color: appColors.primaryColorYellow,
              size: 20.sp,
            ),
          );
        },
      ),
    );
  }
}
