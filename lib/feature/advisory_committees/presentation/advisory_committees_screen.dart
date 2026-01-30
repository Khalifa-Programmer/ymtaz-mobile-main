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
import 'package:yamtaz/feature/advisory_committees/logic/advisory_committees_cubit.dart';
import 'package:yamtaz/feature/advisory_committees/logic/advisory_committees_state.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/spacing.dart';
import '../data/model/advisory_committees_response.dart';

class AdvisoryCommitteesScreen extends StatelessWidget {
  const AdvisoryCommitteesScreen({Key? key});

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
            appBar: AppBar(
              centerTitle: true,
              title: Text('هيئة المستشارين',
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
            ),
            body:
            Animate(
                effects: [FadeEffect(delay: 200.ms)],child: _buildBody(state)),
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
          getit<AdvisoryCommitteesCubit>().loadAdvisoryCommittees();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 10.0.h),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1.7,
              crossAxisCount: 2,
              crossAxisSpacing: 8.0.w,
              mainAxisSpacing: 12.0.h,
            ),
            itemCount: data!.data!.categories!.length,
            itemBuilder: (context, index) {
              CategoryAdvisorCommitte category = data.data!.categories![index];
              return _buildCategoryItem(category, context, index);
            },
          ),
        ),
      );
    } else {
      return const Center(
        child: CupertinoActivityIndicator(),
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
                    CupertinoIcons.person_3_fill,
                    size: 30.sp,
                    color: appColors.primaryColorYellow,
                  ),
                  verticalSpace(4.h),
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
                        color: appColors.primaryColorYellow
                            .withOpacity(0.5)),
                    child: Text("${category.advisorsAvailableCounts}",
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
