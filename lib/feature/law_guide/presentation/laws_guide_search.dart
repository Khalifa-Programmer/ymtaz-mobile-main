import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/law_guide/data/model/law_guide_search_response.dart';
import 'package:yamtaz/feature/law_guide/presentation/search_law_data.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../layout/services/presentation/widgets/no_data_services.dart';
import '../logic/law_guide_cubit.dart';
import 'laws_from_sub.dart';

class LawGuideSearch extends StatelessWidget {
  LawGuideSearch({super.key, required this.title, required this.data});

  final String title;
  final Map<String, dynamic> data;
  bool initScreen = true;

  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<LawGuideCubit>(),
      child: PopScope(
        onPopInvoked: (didPop) {
          getit<LawGuideCubit>().clearsearch();
          focusNode.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(title,
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.black,
                )),
          ),
          body: BlocConsumer<LawGuideCubit, LawGuideState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0.w, vertical: 20.0.h),
                      child: CupertinoTextField(
                        controller: searchController,
                        focusNode: focusNode,
                        placeholder: 'قم بالبحث في دليل الأنظمة',
                        placeholderStyle: TextStyles.cairo_14_semiBold
                            .copyWith(color: appColors.grey15),
                        prefix: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.search,
                            color: appColors.grey15,
                          ),
                        ),
                        textInputAction: TextInputAction.search,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: appColors.grey15.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        clearButtonMode: OverlayVisibilityMode.editing,
                        clearButtonSemanticLabel: 'مسح',
                        onTap: () {},
                        onSubmitted: (value) {
                          focusNode.unfocus();
                        },
                        onEditingComplete: () {
                          data['searchTerm'] = searchController.text;

                          FormData formData = FormData.fromMap(data);

                          getit<LawGuideCubit>().searchLawGuide(formData);
                          initScreen = false;
                          focusNode.unfocus();
                        },
                      ),
                    ),
                    ConditionalBuilder(
                        condition:
                            getit<LawGuideCubit>().lawGuideSearchResponse ==
                                null,
                        builder: (context) {
                          return ConditionalBuilder(
                            condition: initScreen,
                            builder: (BuildContext context) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(AppAssets.notfound),
                                    verticalSpace(20.h),
                                    const Text("قم بالبحث ليظهر المحتوى")
                                  ],
                                ),
                              );
                            },
                            fallback: (BuildContext context) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            },
                          );
                        },
                        fallback: (context) {
                          return Column(children: [
                            _relatedGuideLaws(),
                            verticalSpace(10.h),
                            _subData(),
                            verticalSpace(10.h),
                            _lawsData(),
                          ]);
                        }),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _relatedGuideLaws() {
    return ConditionalBuilder(
        condition: getit<LawGuideCubit>()
                .lawGuideSearchResponse!
                .data!
                .relatedLawGuides !=
            null,
        builder: (context) {
          var data = getit<LawGuideCubit>()
              .lawGuideSearchResponse!
              .data!
              .relatedLawGuides;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      "الأنظمة المرتبطة بالمو��د",
                      style: TextStyles.cairo_12_semiBold.copyWith(
                        color: appColors.grey15,
                      ),
                    ),
                    Spacer(),
                    Text(
                      " (${data?.total ?? 0}) نظام",
                      style: TextStyles.cairo_12_bold.copyWith(
                        color: appColors.primaryColorYellow,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(10.h),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LawsFromSub(
                                  title: data?.data?[index].name ?? "",
                                  subId: data?.data?[index].id.toString() ?? "",
                                  arPdfUrl: data?.data?[index].pdfFileAr,
                                  enPdfUrl: data?.data?[index].pdfFileEn,
                                  enwordUrl: data?.data?[index].wordFileEn,
                                  arwordUrl: data?.data?[index].wordFileAr,
                                ),
                              ));
                        },
                        child: Container(
                          height: 50.h,
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                                offset: const Offset(
                                    0, 3), // Offset in x and y direction
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: double.infinity,
                                width: 4.h,
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? appColors.primaryColorYellow
                                      : appColors.blue90,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.r),
                                      bottomRight: Radius.circular(10.r)),
                                ),
                              ),
                              horizontalSpace(20.w),
                              FaIcon(
                                Icons.local_library,
                                size: 24.sp,
                                color: appColors.primaryColorYellow,
                              ),
                              horizontalSpace(15.w),
                              Expanded(
                                flex: 4,
                                child: RichText(
                                  maxLines: 3,
                                  text: TextSpan(
                                    style: TextStyles.cairo_11_bold.copyWith(
                                      color: appColors.blue100,
                                    ),
                                    children: highlightOccurrences(
                                      data?.data?[index].name ?? "",
                                      searchController.text,
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13.0.w, vertical: 2.0.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: appColors.primaryColorYellow
                                        .withOpacity(0.5)),
                                child: Text("${data?.data?[index].count ?? 0}",
                                    style:
                                        TextStyles.cairo_12_semiBold.copyWith(
                                      color: appColors.blue90,
                                    )),
                              ),
                              horizontalSpace(20.w),
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => verticalSpace(10.h),
                  itemCount: data?.data?.length ?? 0),
            ],
          );
        },
        fallback: (context) {
          return const NodataFound();
        });
  }

  _subData() {
    return ConditionalBuilder(
        condition:
            getit<LawGuideCubit>().lawGuideSearchResponse!.data!.lawGuide !=
                null,
        builder: (context) {
          var data =
              getit<LawGuideCubit>().lawGuideSearchResponse!.data!.lawGuide;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      "مسميات الأنظمة",
                      style: TextStyles.cairo_12_semiBold.copyWith(
                        color: appColors.grey15,
                      ),
                    ),
                    Spacer(),
                    Text(
                      " (${data?.total ?? 0}) نظام",
                      style: TextStyles.cairo_12_bold.copyWith(
                        color: appColors.primaryColorYellow,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(10.h),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LawsFromSub(
                                  title: data?.data?[index].name ?? "",
                                  subId: data?.data?[index].id.toString() ?? "",
                                  arPdfUrl: data?.data?[index].pdfFileAr,
                                  enPdfUrl: data?.data?[index].pdfFileEn,
                                  enwordUrl: data?.data?[index].wordFileEn,
                                  arwordUrl: data?.data?[index].wordFileAr,
                                ),
                              ));
                        },
                        child: Container(
                          height: 50.h,
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                                offset: const Offset(
                                    0, 3), // Offset in x and y direction
                              ),
                            ],
                            shape: RoundedRectangleBorder(
                              // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: double.infinity,
                                width: 4.h,
                                decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? appColors.primaryColorYellow
                                      : appColors.blue90,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10.r),
                                      bottomRight: Radius.circular(10.r)),
                                ),
                              ),
                              horizontalSpace(20.w),
                              FaIcon(
                                Icons.local_library,
                                size: 24.sp,
                                color: appColors.primaryColorYellow,
                              ),
                              horizontalSpace(15.w),
                              RichText(
                                text: TextSpan(
                                  style: TextStyles.cairo_11_bold.copyWith(
                                    color: appColors.blue100,
                                  ),
                                  children: highlightOccurrences(
                                    data?.data?[index].name ?? "",
                                    searchController.text,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 13.0.w, vertical: 2.0.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: appColors.primaryColorYellow
                                        .withOpacity(0.5)),
                                child: Text(
                                    "${data?.data?[index].laws?.data?.length ?? 0}",
                                    style:
                                        TextStyles.cairo_12_semiBold.copyWith(
                                      color: appColors.blue90,
                                    )),
                              ),
                              horizontalSpace(20.w),
                            ],
                          ),
                        ),
                      ),
                  separatorBuilder: (context, index) => verticalSpace(10.h),
                  itemCount: data?.data?.length ?? 0),
            ],
          );
        },
        fallback: (context) {
          return const NodataFound();
        });
  }

  _lawsData() {
    return ConditionalBuilder(
        condition:
            getit<LawGuideCubit>().lawGuideSearchResponse!.data!.laws != null,
        builder: (context) {
          var data = getit<LawGuideCubit>().lawGuideSearchResponse!.data!.laws;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      "المواد",
                      style: TextStyles.cairo_12_semiBold.copyWith(
                        color: appColors.grey15,
                      ),
                    ),
                    Spacer(),
                    Text(
                      " (${data?.total ?? 0}) مادة",
                      style: TextStyles.cairo_12_bold.copyWith(
                        color: appColors.primaryColorYellow,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(10.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LawScreen(
                            data: data?.data?[index] ?? FluffyDatum(),
                            index: index,
                            title: data?.data?[index].lawGuide?.name ?? "",
                          ),
                        ));
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data?.data?[index].lawGuide?.name ?? "",
                            style: TextStyles.cairo_10_semiBold.copyWith(
                              color: appColors.grey15,
                            ),
                          ),
                          data?.data?[index].changes == null ||
                                  data?.data?[index].changes != null
                              ? RichText(
                                  text: TextSpan(
                                    style: TextStyles.cairo_12_bold.copyWith(
                                      color: appColors.primaryColorYellow,
                                    ),
                                    children: highlightOccurrences(
                                      data?.data?[index].name ?? "",
                                      searchController.text,
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        style:
                                            TextStyles.cairo_12_bold.copyWith(
                                          color: appColors.primaryColorYellow,
                                        ),
                                        children: highlightOccurrences(
                                          data?.data?[index].name ?? "",
                                          searchController.text,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.edit_note_sharp,
                                      color: appColors.primaryColorYellow,
                                    )
                                  ],
                                ),
                          horizontalSpace(20.w),
                          RichText(
                            text: TextSpan(
                              style: TextStyles.cairo_11_bold.copyWith(
                                color: appColors.blue100,
                              ),
                              children: highlightOccurrences(
                                data?.data?[index].law ?? "",
                                searchController.text,
                              ),
                            ),
                          ),
                          verticalSpace(20.w),
                          data?.data?[index].changes == "" ||
                                  data?.data?[index].changes == null
                              ? const SizedBox()
                              : Text(
                                  data?.data?[index].changes ?? "",
                                  style: TextStyle(
                                    color: appColors.red,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => verticalSpace(10.h),
                itemCount: data?.data?.length ?? 0,
              )
            ],
          );
        },
        fallback: (context) {
          return const NodataFound();
        });
  }
}
