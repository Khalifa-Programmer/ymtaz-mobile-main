import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_main_category_response.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_payment_types.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_cubit.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_state.dart';
import 'package:yamtaz/feature/layout/account/presentation/guest_screen.dart';

import '../../../core/network/local/cache_helper.dart';
import '../../../core/widgets/custom_container.dart';

class AdvisoryScreen extends StatefulWidget {
  AdvisoryScreen({super.key});

  int indexMainCategory = -1;

  @override
  State<AdvisoryScreen> createState() => _AdvisoryScreenState();
}

class _AdvisoryScreenState extends State<AdvisoryScreen> {
  var userType = CacheHelper.getData(key: 'userType');

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AdvisorCubit>()..getData(),
      child: BlocConsumer<AdvisorCubit, AdvisorState>(
        listener: (context, state) {
          state.whenOrNull(
            loadingMainCategory: () {},
            errorLoadMainCategory: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                ),
              );
            },
            loadingTypes: () {},
            errorLoadTypes: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                ),
              );
            },
            sucessLoadTypes: (response) {},
          );
        },
        builder: (context, state) {
          state.whenOrNull(
            loadingTypes: () {},
            errorLoadTypes: (error) {},
            sucessLoadTypes: (response) {},
          );
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<AdvisorCubit>().clearData();
                    getit<AdvisorCubit>().getMainCategories();
                  },
                  icon: const Icon(
                    CupertinoIcons.refresh,
                    color: appColors.blue100,
                  ),
                )
              ],
              centerTitle: true,
              title: Text(
                'نافذة الاستشارات',
                style:
                    TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
              ),
            ),
            body: PopScope(
              onPopInvoked: (didPop) {
                context.read<AdvisorCubit>().clearData();
              },
              child: ConditionalBuilder(
                  condition: getit<AdvisorCubit>().mainCategoryResponse != null,
                  builder: (BuildContext context) => ConditionalBuilder(
                        condition: widget.indexMainCategory == -1,
                        builder: (BuildContext context) {
                          return _buildMainCategory(context);
                        },
                        fallback: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 16.sp, horizontal: 16.sp),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomContainer(
                                      title: 'فئة الاستشارة',
                                      child: CustomDropdown<ItemMainCategory>(
                                        validator: (value) {
                                          if (value == null) {
                                            return 'الرجاء اختيار الاستشارة';
                                          }
                                          return null;
                                        },
                                        hintText: 'فئة الاستشارة',
                                        initialItem: getit<AdvisorCubit>()
                                            .mainCategoryResponse!
                                            .data!
                                            .items![widget.indexMainCategory],
                                        items: getit<AdvisorCubit>()
                                            .mainCategoryResponse!
                                            .data!
                                            .items,
                                        onChanged: (value) {
                                          context
                                              .read<AdvisorCubit>()
                                              .getTypesAndPaymentTypes(
                                                  value!.id.toString());
                                        },
                                      )),
                                  ConditionalBuilder(
                                    condition: context
                                            .read<AdvisorCubit>()
                                            .paymentsResponse !=
                                        null,
                                    builder: (BuildContext context) => Animate(
                                      effects: [
                                        FadeEffect(delay: 200.ms),
                                      ],
                                      child: CustomContainer(
                                          title: 'باقة الاستشارة',
                                          child: CustomDropdown<Item>(
                                            validator: (value) {
                                              if (value == null) {
                                                return 'الرجاء اختيار الاستشارة';
                                              }
                                              return null;
                                            },
                                            hintText: 'باقة الاستشارة',
                                            items: getit<AdvisorCubit>()
                                                .paymentsResponse!
                                                .data!
                                                .items,
                                            onChanged: (value) {
                                              context
                                                  .read<AdvisorCubit>()
                                                  .getSections(
                                                      value!.id.toString());
                                            },
                                          )),
                                    ),
                                    fallback: (BuildContext context) =>
                                        const SizedBox(),
                                  ),
                                  ConditionalBuilder(
                                    condition: context
                                            .read<AdvisorCubit>()
                                            .sectionsResponse !=
                                        null,
                                    builder: (BuildContext context) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("وسيلة الاستشارة",
                                              style: TextStyles
                                                  .cairo_14_semiBold
                                                  .copyWith(
                                                color: appColors.blue100,
                                              )),
                                          verticalSpace(16.h),
                                          ConditionalBuilder(
                                            condition: context
                                                .read<AdvisorCubit>()
                                                .sectionsResponse!
                                                .data!
                                                .items!
                                                .isNotEmpty,
                                            builder: (BuildContext context) =>
                                                ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: context
                                                  .read<AdvisorCubit>()
                                                  .sectionsResponse!
                                                  .data!
                                                  .items!
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return Animate(
                                                  effects: [
                                                    FadeEffect(delay: 200.ms),
                                                  ],
                                                  child: GestureDetector(
                                                    onTap: () async {
                                                      await context
                                                          .read<AdvisorCubit>()
                                                          .getTypes(context
                                                              .read<
                                                                  AdvisorCubit>()
                                                              .sectionsResponse!
                                                              .data!
                                                              .items![index]
                                                              .id
                                                              .toString());

                                                      if (userType == "guest") {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const GestScreen(),
                                                            ));
                                                      } else if (context
                                                          .read<AdvisorCubit>()
                                                          .typesResponse!
                                                          .data!
                                                          .items!
                                                          .isNotEmpty) {
                                                        context.pushNamed(
                                                            Routes
                                                                .advisoryRequest,
                                                            arguments: context
                                                                .read<
                                                                    AdvisorCubit>()
                                                                .sectionsResponse!
                                                                .data!
                                                                .items![index]);
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                                'لا يوجد انواع استشارة لهذه الوسيلة'),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      decoration: BoxDecoration(
                                                        color: appColors.grey3,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    12.sp),
                                                      ),
                                                      margin: EdgeInsets.only(
                                                          bottom: 16.sp),
                                                      padding:
                                                          EdgeInsets.all(20.sp),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Icon(
                                                                    CupertinoIcons
                                                                        .tickets_fill,
                                                                    color: appColors
                                                                        .primaryColorYellow,
                                                                  ),
                                                                  horizontalSpace(
                                                                      8.sp),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        context
                                                                            .read<AdvisorCubit>()
                                                                            .sectionsResponse!
                                                                            .data!
                                                                            .items![index]
                                                                            .title!,
                                                                        style: TextStyles
                                                                            .cairo_16_bold
                                                                            .copyWith(color: appColors.blue100),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            180.w,
                                                                        child:
                                                                            Text(
                                                                          context
                                                                              .read<AdvisorCubit>()
                                                                              .sectionsResponse!
                                                                              .data!
                                                                              .items![index]
                                                                              .description!,
                                                                          style: TextStyles
                                                                              .cairo_14_medium
                                                                              .copyWith(color: appColors.grey5),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            fallback: (BuildContext context) =>
                                                const Center(
                                                    child: Text(
                                                        "لا يوجد وسائل للاستشارة")),
                                          ),
                                        ],
                                      );
                                    },
                                    fallback: (BuildContext context) =>
                                        const Center(
                                      child: SizedBox(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  fallback: (BuildContext context) => const Center(
                        child: CupertinoActivityIndicator(),
                      )),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainCategory(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            verticalSpace(20.sp),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.9,
                crossAxisCount: 2,
                crossAxisSpacing: 0.0.w,
                mainAxisSpacing: 0.0.h,
              ),
              itemCount: getit<AdvisorCubit>()
                  .mainCategoryResponse!
                  .data!
                  .items!
                  .length,
              itemBuilder: (context, index) {
                var item = getit<AdvisorCubit>()
                    .mainCategoryResponse!
                    .data!
                    .items![index];
                return _buildCategoryItem(item, context, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      ItemMainCategory item, BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        widget.indexMainCategory = index;
        context
            .read<AdvisorCubit>()
            .getTypesAndPaymentTypes(item.id.toString());
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.all(8.0.sp),
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

            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  CupertinoIcons.doc_on_clipboard_fill,
                  size: 24.sp,
                  color: appColors.primaryColorYellow,
                ),
                verticalSpace(8.h),
                Text(item.title ?? '',
                    style: TextStyles.cairo_12_bold.copyWith(
                      color: appColors.blue100,
                    )),
              ],
            ),
            Container(
              height: double.infinity,
              width: 4.h,
            ),
          ],
        ),
      ),
    );
  }
}
