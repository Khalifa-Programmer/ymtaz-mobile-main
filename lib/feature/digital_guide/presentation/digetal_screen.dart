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
  const DigetalScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<DigitalGuideCubit>()..getDigitalGuide(),

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
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              iconTheme: IconThemeData(color: appColors.black),
              actions: [
                IconButton(
                    onPressed: () {
                      context.pushNamed(Routes.fastSearch);
                    },
                    icon: Icon(CupertinoIcons.search, color: appColors.black)),
              ],
              centerTitle: true,
              titleSpacing: 0,
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
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Column(
                children: [
                   GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.2,
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.0.w,
                      mainAxisSpacing: 12.0.h,
                    ),
                    padding: EdgeInsets.only(top: 10.h, bottom: 50.h),
                    itemCount: getit<DigitalGuideCubit>()
                        .digitalGuideResponse?.data?.categories?.length ?? 0,
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
        return Center(
          child: CupertinoActivityIndicator(color: appColors.primaryColorYellow),
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
        child: Row(
          children: [
            Container(
              width: 4.w,
              height: double.infinity,
              decoration: BoxDecoration(
                color: index % 4 < 2
                    ? appColors.primaryColorYellow
                    : appColors.blue90,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 35.w,
                    height: 35.h,
                    child: Image.network(
                      category.image ?? "",
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          FontAwesomeIcons.briefcase,
                          color: index % 4 < 2
                              ? appColors.primaryColorYellow
                              : appColors.blue90,
                          size: 30.sp,
                        );
                      },
                    ),
                  ),
                  verticalSpace(10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Text(
                      category.title ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: appColors.blue100,
                        fontSize: 12.sp,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  verticalSpace(5.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: appColors.primaryColorYellow.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${category.lawyersCount} محترف",
                      style: TextStyles.cairo_10_bold.copyWith(
                        color: appColors.primaryColorYellow,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
