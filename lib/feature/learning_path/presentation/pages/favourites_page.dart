import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/learning_path/data/models/favourite_items_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_path_items_response.dart';
import 'package:yamtaz/feature/learning_path/data/repos/learning_path_repo.dart';
import 'package:yamtaz/feature/learning_path/logic/favourite_items_cubit.dart';
import 'package:yamtaz/feature/learning_path/logic/favourite_items_state.dart';
import 'package:yamtaz/feature/learning_path/logic/law_details_cubit.dart';
import 'package:yamtaz/feature/learning_path/presentation/pages/law_details_page.dart';
import 'package:yamtaz/feature/learning_path/presentation/pages/book_details_page.dart';
import 'package:yamtaz/feature/learning_path/presentation/pages/view_law_details.dart';

class FavouritesPage extends StatefulWidget {
  final int pathId;

  const FavouritesPage({
    super.key,
    required this.pathId,
  });

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<FavouriteItemsCubit>().getFavouriteItems(widget.pathId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المفضلة', style: TextStyles.cairo_15_bold),
        centerTitle: true,
        backgroundColor: appColors.white,
        elevation: 0,
      ),
      body: BlocBuilder<FavouriteItemsCubit, FavouriteItemsState>(
        builder: (context, state) {
          if (state is FavouriteItemsLoading) {
            return _buildLoadingShimmer();
          }

          if (state is FavouriteItemsLoaded) {
            if (state.error != null) {
              return _buildErrorState(state.error!);
            }
            
            if (state.items.isEmpty) {
              return _buildEmptyState();
            }
            
            return _buildContent(state.items);
          }

          if (state is FavouriteItemsError) {
            return _buildErrorState(state.message);
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, color: appColors.grey10, size: 48.r),
          SizedBox(height: 16.h),
          Text(
            'لا توجد عناصر في المفضلة',
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

  Widget _buildContent(List<FavouriteItem> items) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<FavouriteItemsCubit>().getFavouriteItems(widget.pathId);
      },
      child: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return _buildFavouriteItem(item);
        },
      ),
    );
  }

  Widget _buildFavouriteItem(FavouriteItem item) {
    final IconData typeIcon = item.type == 'law-guide' ? Icons.gavel : Icons.menu_book;
    
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: appColors.grey10.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _onItemTap(item),
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: appColors.primaryColorYellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  typeIcon,
                  color: appColors.primaryColorYellow,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyles.cairo_14_bold,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      item.subcategory.name,
                      style: TextStyles.cairo_12_regular.copyWith(
                        color: appColors.grey10,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: appColors.grey10,
                size: 16.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTap(FavouriteItem item) {
    if (item.type == 'law-guide') {
      final ItemDetails itemDetail = ItemDetails(
        id: item.learningPathItemId,
        name: item.name,
        locked: false,
        mandatory: 1,
        alreadyDone: true,
        learningPathItemId: item.learningPathItemId,
        order: 0,
        isFavourite: true,
      );
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewLawDetails(
            currentIndex: 0,
            items: [itemDetail],
            pathId: widget.pathId,
          ),
        ),
      ).then((value) {
        if (value == true) {
          context.read<FavouriteItemsCubit>().getFavouriteItems(widget.pathId);
        }
      });
    } else if (item.type == 'book-guide') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookDetailsPage(
            currentIndex: 0,
            items: [],
            pathId: widget.pathId,
          ),
        ),
      ).then((value) {
        if (value == true) {
          context.read<FavouriteItemsCubit>().getFavouriteItems(widget.pathId);
        }
      });
    }
  }
} 