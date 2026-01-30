import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/digital_guide/data/model/digital_guide_response.dart';
import 'package:yamtaz/feature/digital_guide/logic/digital_guide_cubit.dart';
import 'package:yamtaz/feature/digital_guide/logic/digital_guide_state.dart';

import '../../../core/constants/colors.dart';
import '../../../l10n/locale_keys.g.dart';

class DigetalScreen extends StatelessWidget {
  const DigetalScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<DigitalGuideCubit>()..loadDigitalGuide(),
      child: BlocConsumer<DigitalGuideCubit, DigitalGuideState>(
        listener: (context, state) {
          state.whenOrNull(
            errorGetDigi: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                ),
              );
            },
          );
        },
        listenWhen: (previous, current) =>
            current is LoadingGetDigi ||
            current is LoadingGetDigi ||
            current is ErrorGetDigi,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      context.pushNamed(Routes.fastSearch);
                    },
                    icon: const Icon(CupertinoIcons.search)),
              ],
              centerTitle: true,
              titleSpacing: 0,
              backgroundColor: Colors.white,
              title: Text(
                LocaleKeys.digitalGuide.tr(),
                style: TextStyles.cairo_16_bold.copyWith(
                  color: appColors.black,
                ),
              ),
            ),
            body: Animate(
                effects: [FadeEffect(delay: 200.ms)],
                child: _buildBody(state, context)),
          );
        },
      ),
    );
  }

  Widget _buildBody(DigitalGuideState state, BuildContext context) {
    return ConditionalBuilder(
      condition: getit<DigitalGuideCubit>().digitalGuideResponse != null,
      builder: (BuildContext context) {
        return RefreshIndicator(
          color: appColors.primaryColorYellow,
          onRefresh: () async {
            getit<DigitalGuideCubit>().getDigitalGuide();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Column(
                children: [
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.71,
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0.w,
                      mainAxisSpacing: 8.0.h,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                    itemCount: getit<DigitalGuideCubit>()
                        .digitalGuideResponse!
                        .data!
                        .categories!
                        .length,
                    itemBuilder: (context, index) {
                      Category category = getit<DigitalGuideCubit>()
                          .digitalGuideResponse!
                          .data!
                          .categories![index];
                      return _buildCategoryItem(category, context, index);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      fallback: (BuildContext context) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }

  Widget _buildCategoryItem(
      Category category, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.digitalGuideSearch, arguments: category);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.04),
              // Shadow color
              spreadRadius: 3,
              // Spread radius
              blurRadius: 10,
              // Blur radius
              offset: const Offset(0, 3), // Offset in x and y direction
            ),
          ],
          shape: RoundedRectangleBorder(
            // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),

            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: double.infinity,
              width: 4.h,
              decoration: BoxDecoration(
                color: index % 4 < 2
                    ? appColors.primaryColorYellow
                    : appColors.blue90,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r)),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(
                    CupertinoIcons.person_2_square_stack_fill,
                    size: 24.sp,
                    color: appColors.primaryColorYellow,
                  ),
                  verticalSpace(8.h),
                  Text(category.title ?? '',
                      style: TextStyles.cairo_12_bold.copyWith(
                        color: appColors.blue100,
                      )),
                  verticalSpace(8.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 13.0.w, vertical: 2.0.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: appColors.primaryColorYellow.withOpacity(0.5)),
                    child: Text("${category.lawyersCount}",
                        style: TextStyles.cairo_12_semiBold.copyWith(
                          color: appColors.blue90,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              height: double.infinity,
              width: 4.h,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
