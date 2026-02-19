import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';
import 'package:yamtaz/feature/ymtaz_elite/presentation/widgets/item_card_widget.dart';

class EliteMainScreen extends StatefulWidget {
  const EliteMainScreen({super.key});

  @override
  State<EliteMainScreen> createState() => _EliteMainScreenState();
}

class _EliteMainScreenState extends State<EliteMainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<YmtazEliteCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBlurredAppBar(context, "هيئة المستشارين"),
      body: Animate(
        effects: [FadeEffect(duration: 500.ms)],
        child: BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
          builder: (context, state) {
            if (state is YmtazEliteLoading) {
              return _buildShimmerLoading();
            }

            final cubit = context.read<YmtazEliteCubit>();
            if (cubit.categories == null ||
                cubit.categories!.data!.categories!.isEmpty) {
              return Center(child: Text('لا توجد بيانات'));
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView.builder(
                itemCount: cubit.categories!.data!.categories!.length,
                itemBuilder: (context, index) {
                  final category = cubit.categories!.data!.categories![index];
                  return EliteItemCardWidget(
                    index: index,
                    name: category.name ?? '',
                    total: category.id.toString(),
                    id: category.id!,
                    onPressed: () {
                      cubit.selectCategory(category.id!);
                      Navigator.pushNamed(context, Routes.eliteRequestScreen);
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
            );
          },
        ),
      ),
    );
  }
}
