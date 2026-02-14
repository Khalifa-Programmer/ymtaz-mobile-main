import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/feature/advisory_committees/logic/advisory_committees_cubit.dart';
import 'package:yamtaz/feature/advisory_committees/logic/advisory_committees_state.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/spacing.dart';
import '../data/model/advisory_committees_response.dart';

class AdvisoryCommitteesScreen extends StatelessWidget {
  const AdvisoryCommitteesScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: getit<AdvisoryCommitteesCubit>()..loadAdvisoryCommitteesData(),
      child: BlocConsumer<AdvisoryCommitteesCubit, AdvisoryCommitteesState>(
        listener: (context, state) {
          state.whenOrNull(
            errorCommittees: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                ),
              );
            },
          );
        },
        listenWhen: (previous, current) =>
            current is LoadedCommittees ||
            current is LoadingCommittees ||
            current is ErrorCommittees,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              iconTheme: IconThemeData(color: appColors.black),
              centerTitle: true,
              title: Text('هيئة المستشارين',
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
            ),

            body: Animate(
                effects: [FadeEffect(delay: 200.ms)], child: _buildBody(state)),
          );
        },
      ),
    );
  }

  Widget _buildBody(AdvisoryCommitteesState state) {
    if (getit<AdvisoryCommitteesCubit>().advisoryCommitteesResponse != null) {
      AdvisoryCommitteesResponse? data =
          getit<AdvisoryCommitteesCubit>().advisoryCommitteesResponse;
      return RefreshIndicator(
        color: appColors.primaryColorYellow,
        onRefresh: () async {
          getit<AdvisoryCommitteesCubit>().loadAdvisoryCommitteesData();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 10.0.h, bottom: 50.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.2,
              crossAxisCount: 2,
              crossAxisSpacing: 12.0.w,
              mainAxisSpacing: 12.0.h,
            ),
            itemCount: data?.data?.categories?.length ?? 0,
            itemBuilder: (context, index) {
              CategoryAdvisorCommitte category = data!.data!.categories![index];

              return _buildCategoryItem(category, context, index);
            },
          ),
        ),
      );
    } else {
      return Center(
        child: CupertinoActivityIndicator(color: appColors.primaryColorYellow),
      );
    }

  }

  Widget _buildCategoryItem(
      CategoryAdvisorCommitte category, BuildContext con, int index) {
    return GestureDetector(
      onTap: () {
        con.pushNamed(Routes.advisoryCommitteeLawyersScreen,
            arguments: category);
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
                    child:
                        (category.image != null && category.image!.isNotEmpty)
                            ? CachedNetworkImage(
                                imageUrl: category.image!,
                                fit: BoxFit.contain,
                                placeholder: (context, url) => Icon(
                                  FontAwesomeIcons.briefcase,
                                  color: index % 4 < 2
                                      ? appColors.primaryColorYellow
                                      : appColors.blue90,
                                  size: 30.sp,
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  FontAwesomeIcons.briefcase,
                                  color: index % 4 < 2
                                      ? appColors.primaryColorYellow
                                      : appColors.blue90,
                                  size: 30.sp,
                                ),
                              )
                            : Icon(
                                FontAwesomeIcons.briefcase,
                                color: index % 4 < 2
                                    ? appColors.primaryColorYellow
                                    : appColors.blue90,
                                size: 30.sp,
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
                      "${category.advisorsAvailableCounts} مستشار",
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
