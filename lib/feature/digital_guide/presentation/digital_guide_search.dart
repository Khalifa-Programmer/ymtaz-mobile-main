import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/digital_guide/data/model/digital_guide_response.dart';
import 'package:yamtaz/feature/digital_guide/data/model/digital_search_response_model.dart';
import 'package:yamtaz/feature/digital_guide/logic/digital_guide_cubit.dart';
import 'package:yamtaz/feature/digital_guide/logic/digital_guide_state.dart';
import 'package:yamtaz/feature/digital_guide/presentation/digetal_providers_screen.dart';

import '../../../config/themes/styles.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/network/local/cache_helper.dart';
import '../../layout/account/presentation/guest_screen.dart';
import '../../layout/services/presentation/widgets/no_data_services.dart';

class DigitalGuideSearch extends StatelessWidget {
  const DigitalGuideSearch({super.key, required this.cat});

  final Category cat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: appColors.black),

        title: Text(cat.title!,
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: BlocProvider.value(
        value: getit<DigitalGuideCubit>()
          ..getSearchDigitalGuide(FormData.fromMap({'category_id': cat.id!})),
        child: BlocConsumer<DigitalGuideCubit, DigitalGuideState>(
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

  Widget _buildBody(DigitalGuideState state) {
    var data = getit<DigitalGuideCubit>().digitalSearchResponseModel;

    if (data != null && data.data!.lawyers != null) {
      var lawyers = data.data!.lawyers!;
      if (lawyers.isNotEmpty) {
        return RefreshIndicator(
          color: appColors.primaryColorYellow,
          onRefresh: () async {
            getit<DigitalGuideCubit>().getSearchDigitalGuide(
                FormData.fromMap({'category_id': cat.id!}));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0.w),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 10.0.h),
              itemCount: lawyers.length,
              itemBuilder: (context, index) {
                Lawyer category = lawyers[index];
                return _buildCategoryItem(category, context, index);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: const Divider(thickness: 0.5),
                );
              },
            ),
          ),
        );
      } else {
        return const Center(child: NoProducts(text: 'لا يوجد محاميين في هذه الفئة',));
      }
    } else {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    }
  }

  Widget _buildCategoryItem(Lawyer lawyer, BuildContext context, int index) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        var userType = CacheHelper.getData(key: "userType");
        if (userType == "client" || userType == "provider") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DigitalProvidersScreen(
                idLawyer: lawyer.id!.toString(),
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GestScreen(),
            ),
          );
        }
      },
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: _buildLawyerImage(lawyer),
          ),
          SizedBox(width: 10.0.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    lawyer.name ?? "بدون اسم",

                    style: TextStyles.cairo_12_bold.copyWith(
                      color: appColors.blue100,
                    ),
                  ),
                  horizontalSpace(3.0.w),
                  lawyer.digitalGuideSubscription == 1
                      ? const Icon(
                    Icons.verified,
                    color: CupertinoColors.activeBlue,
                    size: 15,
                  )
                      : const SizedBox(),
                ],
              ),
              verticalSpace(4.h),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.location_solid,
                    color: appColors.primaryColorYellow,
                    size: 20.sp,
                  ),
                  horizontalSpace(0.w),
                  Text(lawyer.city?.title ?? "",
                      style: TextStyles.cairo_12_semiBold),
                ],
              )
            ],
          ),
          const Spacer(),
          // Container(
          //   height: 30.h,
          //   padding: EdgeInsets.symmetric(horizontal: 10.w),
          //   decoration: BoxDecoration(
          //     color: appColors.lightYellow10,
          //     borderRadius: BorderRadius.circular(4),
          //   ),
          //   child: Center(
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           "0",
          //           style: TextStyles.cairo_12_bold.copyWith(),
          //         ),
          //         horizontalSpace(4.w),
          //         Icon(
          //           CupertinoIcons.star_fill,
          //           color: appColors.primaryColorYellow,
          //           size: 15.sp,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );

  }

  Widget _buildLawyerImage(Lawyer lawyer) {
    final imageUrl = lawyer.image ?? lawyer.photo ?? lawyer.logo;
    final isFemale = lawyer.gender == 'female';
    final defaultAvatar = isFemale ? AppAssets.Female : AppAssets.Male;

    if (imageUrl == null || imageUrl.isEmpty || imageUrl == "https://api.ymtaz.sa/uploads/person.png") {
      return SvgPicture.asset(
        defaultAvatar,
        width: 50.w,
        height: 50.h,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: 50.w,
      height: 50.h,
      placeholder: (context, url) => SvgPicture.asset(
        defaultAvatar,
        width: 50.w,
        height: 50.h,
      ),
      errorWidget: (context, url, error) => SvgPicture.asset(
        defaultAvatar,
        width: 50.w,
        height: 50.h,
      ),
    );
  }
}
