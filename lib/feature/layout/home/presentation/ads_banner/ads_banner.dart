import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/constants/colors.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

class AdsBanner extends StatelessWidget {
  const AdsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // You can handle additional actions based on state here if needed
      },
      builder: (context, state) {
        if (state is HomeStateLoading) {
          // Show skeleton loader while banners are loading
          return Skeletonizer(
            enabled: true,
            child: SizedBox(
              height: 150.h,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0.r),
                  color: Colors.grey.shade300, // Placeholder color for skeleton
                ),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0.r),
                      color: Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (state is HomeStateBannersLoaded &&
            state.banners.isNotEmpty) {
          // Display banners once they are loaded
          return Animate(
            effects: [
              FadeEffect(
                duration: const Duration(milliseconds: 1),
              )
            ],
            child: SizedBox(
              height: 150.h,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.0.r),
                    child: CachedNetworkImage(
                      imageUrl: state.banners[index].image ??
                          "https://bestlawyeruae.com/wp-content/uploads/2022/02/%D8%A7%D8%B3%D8%AA%D8%B4%D8%A7%D8%B1%D8%A7%D8%AA-%D9%82%D8%A7%D9%86%D9%88%D9%86%D9%8A%D8%A9-%D8%A7%D8%B3%D8%B1%D9%8A%D8%A9-%D9%85%D8%AC%D8%A7%D9%86%D9%8A%D8%A9-%D8%A7%D9%84%D8%A7%D9%85%D8%A7%D8%B1%D8%A7%D8%AA.webp",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey
                            .shade300, // Optional placeholder color or widget
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error), // In case of an error
                    ),
                  );
                },
                itemCount: state.banners.length,
                autoplay: true,
                duration: 2000,
                pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                    color: appColors.white,
                    activeColor: appColors.blue100,
                  ),
                ),
                physics: const BouncingScrollPhysics(),
                scale: 0.5,
                viewportFraction: 0.9,
              ),
            ),
          );
        } else if (state is HomeStateBannersLoaded && state.banners.isEmpty) {
          // If banners are loaded but the list is empty, return an empty widget
          return const SizedBox();
        } else {
          // Default return in case of any unexpected state (e.g., error)
          return const SizedBox();
        }
      },
    );
  }
}
