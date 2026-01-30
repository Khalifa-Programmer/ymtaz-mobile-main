import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/advisory_committees/data/model/advisory_committees_lawyers_response.dart';
import 'package:yamtaz/feature/advisory_committees/data/model/advisory_committees_response.dart';
import 'package:yamtaz/feature/advisory_committees/logic/advisory_committees_cubit.dart';
import 'package:yamtaz/feature/advisory_committees/logic/advisory_committees_state.dart';
import 'package:yamtaz/feature/advisory_committees/presentation/advisor_screen.dart';
import 'package:yamtaz/feature/layout/account/presentation/guest_screen.dart';

import '../../../core/network/local/cache_helper.dart';

class AdvisoryCommitteeSearchScreen extends StatelessWidget {
  const AdvisoryCommitteeSearchScreen({super.key, required this.cat});

  final CategoryAdvisorCommitte cat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat.title!,
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: BlocProvider.value(
        value: getit<AdvisoryCommitteesCubit>()
          ..loadLawyers(cat.id!.toString()),
        child: BlocConsumer<AdvisoryCommitteesCubit, AdvisoryCommitteesState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(AdvisoryCommitteesState state) {
    if (getit<AdvisoryCommitteesCubit>().advisoryCommitteesLawyersResponse !=
        null) {
      return RefreshIndicator(
        color: appColors.primaryColorYellow,
        onRefresh: () async {
          getit<AdvisoryCommitteesCubit>().loadLawyers(cat.id!.toString());
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0.w),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 10.0.h),
            itemCount: getit<AdvisoryCommitteesCubit>()
                .advisoryCommitteesLawyersResponse!
                .data!
                .advisors
                ?.length ??
                0,
            itemBuilder: (context, index) {
              Advisor category = getit<AdvisoryCommitteesCubit>()
                  .advisoryCommitteesLawyersResponse!
                  .data!
                  .advisors![index];
              return _buildCategoryItem(category, context, index);
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: const Divider(thickness: 0.5,),
              );
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

  Widget _buildCategoryItem(Advisor lawyer, BuildContext context, int index) {
    return GestureDetector(
        onTap: ()
    {
      var userType = CacheHelper.getData(key: 'userType');
      if (userType == "client" || userType == "provider") {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AdvisorScreen(
                    lawyer: lawyer,
                  ),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
              const GestScreen(
              ),
            ));
        // context.pushNamed(Routes.advisoryScreen, arguments: lawyer);
      }
    },
      child:
      Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    lawyer.photo ?? "https://api.ymtaz.sa/uploads/person.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.0.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${lawyer.firstName} ${lawyer.secondName} ${lawyer
                  .fourthName}",
                  style: TextStyles.cairo_12_bold.copyWith(
                    color: appColors.blue100,
                  )),
              horizontalSpace(3.0.w),
              lawyer.digitalGuideSubscription == 1
                  ? const Icon(
                Icons.verified,
                color: CupertinoColors.activeBlue,
                size: 15,
              )
                  : const SizedBox(),
              verticalSpace(4.h),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.location_solid,
                    color: appColors.primaryColorYellow,
                    size: 20.sp,
                  ),
                  horizontalSpace(0.w),
                  Text(lawyer.country!.name ?? "",
                      style: TextStyles.cairo_12_semiBold),
                ],
              )
            ],
          ),
          const Spacer(),
          Container(
            height: 30.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
                color: appColors.lightYellow10,
                borderRadius: BorderRadius.circular(4)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    lawyer.ratesAvg ?? "0",
                    style: TextStyles.cairo_12_bold.copyWith(),
                  ),
                  horizontalSpace(4.w),
                  Icon(
                    CupertinoIcons.star_fill,
                    color: appColors.primaryColorYellow,
                    size: 15.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    ,
    );
  }
  }
