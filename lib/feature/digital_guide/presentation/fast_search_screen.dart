import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/digital_guide/data/model/fast_search_response_model.dart';
import 'package:yamtaz/feature/digital_guide/logic/digital_guide_cubit.dart';
import 'package:yamtaz/feature/digital_guide/logic/digital_guide_state.dart';

import '../../forensic_guide/data/model/judicial_guide_response_model.dart';
import '../data/model/digital_search_response_model.dart';
import 'digetal_providers_screen.dart';

class FastSearchScreen extends StatefulWidget {
  const FastSearchScreen({super.key});

  @override
  State<FastSearchScreen> createState() => _FastSearchScreenState();
}

class _FastSearchScreenState extends State<FastSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // final FocusNode _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    // _searchFocusNode.requestFocus();
    return BlocConsumer<DigitalGuideCubit, DigitalGuideState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var data = getit<DigitalGuideCubit>().fastSearchResponseModel;
        return GestureDetector(
          onTap: () {
            // Unfocus when tapping outside search field
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("البحث", style: TextStyles.cairo_16_bold),
              centerTitle: true,
              elevation: 0,
            ),
            body: DefaultTabController(
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.0.w, vertical: 10.h),
                              child: CupertinoTextField(
                                placeholder: 'البحث',
                                placeholderStyle: TextStyles.cairo_14_semiBold
                                    .copyWith(color: appColors.grey15),
                                prefix: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    CupertinoIcons.search,
                                    color: appColors.blue100,
                                  ),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: appColors.grey15.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                onSubmitted: (value) {
                                  FocusManager focus = FocusManager.instance;
                                  if (focus.primaryFocus?.hasFocus ?? false) {
                                    focus.primaryFocus?.unfocus();
                                  }
                                  BlocProvider.of<DigitalGuideCubit>(context)
                                      .fastSearchDigitalGuideClient(
                                          _searchController.text);
                                },
                                clearButtonMode: OverlayVisibilityMode.editing,
                                controller: _searchController,
                                clearButtonSemanticLabel: 'مسح',
                                // focusNode: _searchFocusNode,
                                onChanged: (value) {
                                  setState(() {});
                                  // BlocProvider.of<DigitalGuideCubit>(context).fastSearchDigitalGuideClient(value);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: CupertinoButton(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              color: appColors.primaryColorYellow,
                              onPressed: _searchController.text.isEmpty
                                  ? null
                                  : () {
                                      FocusManager focus =
                                          FocusManager.instance;
                                      if (focus.primaryFocus?.hasFocus ??
                                          false) {
                                        focus.primaryFocus?.unfocus();
                                      }
                                      BlocProvider.of<DigitalGuideCubit>(
                                              context)
                                          .fastSearchDigitalGuideClient(
                                              _searchController.text);
                                    },
                              child: Text(
                                "البحث",
                                style: TextStyles.cairo_12_bold
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      data == null
                          ? const Center(
                              child: Text(""),
                            )
                          : Animate(
                              effects: [
                                FadeEffect(delay: 200.ms),
                              ],
                              child: TabBar(
                                  tabAlignment: TabAlignment.start,
                                  isScrollable: true,
                                  indicatorColor: appColors.primaryColorYellow,
                                  labelStyle: TextStyles.cairo_14_bold,
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                  unselectedLabelColor: const Color(0xFF808D9E),
                                  unselectedLabelStyle:
                                      TextStyles.cairo_14_semiBold,
                                  tabs: [
                                    Tab(
                                      // text: 'الجميع',
                                      child: Row(
                                        children: [
                                          const Text('الجميع'),
                                          horizontalSpace(3.w),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: const Color(0xFFF6E3B8)),
                                            child: Text(
                                                "${data.data!.judicialGuide!.length + data.data!.lawyers!.length}",
                                                style:
                                                    TextStyles.cairo_10_medium),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Tab(
                                    //   // text: 'الجميع',
                                    //   child: Row(
                                    //     children: [
                                    //       const Text('الخدمات'),
                                    //       horizontalSpace(3.w),
                                    //       Container(
                                    //         padding: EdgeInsets.symmetric(
                                    //             horizontal: 5.w),
                                    //         decoration: BoxDecoration(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(4),
                                    //             color: const Color(0xFFF6E3B8)),
                                    //         child: Text(
                                    //             "${data.data!.services!.length}",
                                    //             style:
                                    //                 TextStyles.cairo_10_medium),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // Tab(
                                    //   // text: 'الجميع',
                                    //   child: Row(
                                    //     children: [
                                    //       const Text('الاستشارات'),
                                    //       horizontalSpace(3.w),
                                    //       Container(
                                    //         padding: EdgeInsets.symmetric(
                                    //             horizontal: 5.w),
                                    //         decoration: BoxDecoration(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(4),
                                    //             color: const Color(0xFFF6E3B8)),
                                    //         child: Text(
                                    //             "${data.data!.advisoryServicesTypes!.length}",
                                    //             style:
                                    //                 TextStyles.cairo_10_medium),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // Tab(
                                    //   // text: 'الجميع',
                                    //   child: Row(
                                    //     children: [
                                    //       const Text('المواعيد'),
                                    //       horizontalSpace(3.w),
                                    //       Container(
                                    //         padding: EdgeInsets.symmetric(
                                    //             horizontal: 5.w),
                                    //         decoration: BoxDecoration(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(4),
                                    //             color: const Color(0xFFF6E3B8)),
                                    //         child: Text(
                                    //             "${data.data!.appointmentTypes!.length}",
                                    //             style:
                                    //                 TextStyles.cairo_10_medium),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    Tab(
                                      // text: 'الجميع',
                                      child: Row(
                                        children: [
                                          const Text('الدليل الرقمي'),
                                          horizontalSpace(3.w),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: const Color(0xFFF6E3B8)),
                                            child: Text(
                                                "${data.data!.lawyers!.length}",
                                                style:
                                                    TextStyles.cairo_10_medium),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Tab(
                                      // text: 'الجميع',
                                      child: Row(
                                        children: [
                                          const Text('الدليل العدلي'),
                                          horizontalSpace(3.w),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: const Color(0xFFF6E3B8)),
                                            child: Text(
                                                "${data.data!.judicialGuide!.length}",
                                                style:
                                                    TextStyles.cairo_10_medium),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ),
                    ],
                  ),
                  data == null
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 250.h),
                            child: const Text("قم بالبحث الان"),
                          ),
                        )
                      : state is LoadingFastSearch
                          ? const Expanded(
                              child:
                                  Center(child: CupertinoActivityIndicator()))
                          : Animate(
                              effects: [FadeEffect(delay: 200.ms)],
                              child: Expanded(
                                child: NotificationListener<ScrollNotification>(
                                  onNotification: (scrollNotification) {
                                    // Unfocus when scrolling
                                    if (scrollNotification
                                        is ScrollStartNotification) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    }
                                    return true;
                                  },
                                  child: TabBarView(children: [
                                    _allListData(
                                        data.data!.services,
                                        data.data!.advisoryServicesTypes,
                                        data.data!.lawyers),
                                    // Padding(
                                    //   padding: EdgeInsets.all(14.0.sp),
                                    //   child:
                                    //       _serviceListData(data.data!.services),
                                    // ),
                                    // Padding(
                                    //   padding: EdgeInsets.all(14.0.sp),
                                    //   child: _advisoryListData(
                                    //       data.data!.advisoryServicesTypes),
                                    // ),
                                    // Padding(
                                    //   padding: EdgeInsets.all(14.0.sp),
                                    //   child: _appointmentListData(
                                    //       data.data!.appointmentTypes),
                                    // ),
                                    Padding(
                                      padding: EdgeInsets.all(14.0.sp),
                                      child:
                                          _lawyersListData(data.data!.lawyers),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(14.0.sp),
                                      child: _judicialGuideData(
                                          data.data!.judicialGuide),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _serviceListData(List<Service>? services) {
  //   return SingleChildScrollView(
  //     physics: const ClampingScrollPhysics(),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         verticalSpace(20.h),
  //         Text("نتائج الخدمات", style: TextStyles.cairo_12_semiBold),
  //         verticalSpace(20.h),
  //         ListView.separated(
  //           padding: const EdgeInsets.all(0),
  //           itemCount: services!.length,
  //           physics: const ClampingScrollPhysics(),
  //           shrinkWrap: true,
  //           itemBuilder: (context, index) {
  //             return InkWell(
  //               borderRadius: BorderRadius.circular(8.sp),
  //               onTap: () {
  //                 context.pushNamed(Routes.servicesReservationByService,
  //                     arguments: services[index]);
  //               },
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     height: 42.h,
  //                     width: 10.w,
  //                     decoration: BoxDecoration(
  //                         color: appColors.grey15,
  //                         borderRadius: BorderRadius.circular(4)),
  //                   ),
  //                   horizontalSpace(16.w),
  //                   Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text("خدمات",
  //                           style: TextStyles.cairo_14_medium
  //                               .copyWith(color: appColors.grey15)),
  //                       Text(services[index].title!,
  //                           style: TextStyles.cairo_14_semiBold),
  //                     ],
  //                   ),
  //                   const Spacer(),
  //                   const Icon(CupertinoIcons.arrow_up_left)
  //                 ],
  //               ),
  //             );
  //           },
  //           separatorBuilder: (BuildContext context, int index) {
  //             return verticalSpace(10.h);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _advisoryListData(List<AdvisoryServicesType>? advisoryServicesTypes) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         verticalSpace(20.h),
  //         Text("نتائج الاستشارات", style: TextStyles.cairo_12_semiBold),
  //         verticalSpace(20.h),
  //         Container(
  //           child: ListView.separated(
  //             padding: const EdgeInsets.all(0),
  //             itemCount: advisoryServicesTypes!.length,
  //             physics: const NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             itemBuilder: (context, index) {
  //               return InkWell(
  //                 borderRadius: BorderRadius.circular(8.sp),
  //                 onTap: () {
  //                   context.pushNamed(Routes.advisoryRequestFast,
  //                       arguments: advisoryServicesTypes[index].toJson());
  //                 },
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Container(
  //                       height: 42.h,
  //                       width: 10.w,
  //                       decoration: BoxDecoration(
  //                           color: appColors.blue90,
  //                           borderRadius: BorderRadius.circular(4)),
  //                     ),
  //                     horizontalSpace(16.w),
  //                     Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text("استشارة",
  //                             style: TextStyles.cairo_14_medium
  //                                 .copyWith(color: appColors.grey15)),
  //                         Text(advisoryServicesTypes[index].title!,
  //                             style: TextStyles.cairo_14_semiBold),
  //                       ],
  //                     ),
  //                     const Spacer(),
  //                     const Icon(CupertinoIcons.arrow_up_left)
  //                   ],
  //                 ),
  //               );
  //             },
  //             separatorBuilder: (BuildContext context, int index) {
  //               return verticalSpace(10.h);
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // Widget _appointmentListData(List<ReservationsType>? appointments) {
  //   return SingleChildScrollView(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         verticalSpace(20.h),
  //         Text("نتائج المواعيد", style: TextStyles.cairo_12_semiBold),
  //         verticalSpace(20.h),
  //         ListView.separated(
  //           padding: const EdgeInsets.all(0),
  //           itemCount: appointments!.length,
  //           physics: const NeverScrollableScrollPhysics(),
  //           shrinkWrap: true,
  //           itemBuilder: (context, index) {
  //             return InkWell(
  //               borderRadius: BorderRadius.circular(8.sp),
  //               onTap: () {
  //                 Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                   return BlocProvider.value(
  //                     value: getit<AppointmentsCubit>()..load(),
  //                     child: AppointmentYmtaz(
  //                       reservationsType: appointments[index],
  //                       selectedMainTypeIndex: index,
  //                       selectedMainType: appointments[index].id!,
  //                     ),
  //                   );
  //                 }));
  //               },
  //               child: Row(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   Container(
  //                     height: 42.h,
  //                     width: 10.w,
  //                     decoration: BoxDecoration(
  //                         color: appColors.blue90,
  //                         borderRadius: BorderRadius.circular(4)),
  //                   ),
  //                   horizontalSpace(16.w),
  //                   Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text("موعد",
  //                           style: TextStyles.cairo_14_medium
  //                               .copyWith(color: appColors.grey15)),
  //                       Text(appointments[index].name!,
  //                           style: TextStyles.cairo_14_semiBold),
  //                     ],
  //                   ),
  //                   const Spacer(),
  //                   const Icon(CupertinoIcons.arrow_up_left)
  //                 ],
  //               ),
  //             );
  //           },
  //           separatorBuilder: (BuildContext context, int index) {
  //             return verticalSpace(10.h);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _judicialGuideData(List<JudicialGuide>? judicialGuide) {
    print(judicialGuide!.length);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(20.h),
          Text("نتائج الدليل العدلي", style: TextStyles.cairo_12_semiBold),
          verticalSpace(20.h),
          Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(0),
              itemCount: judicialGuide.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(8.sp),
                  onTap: () {
                    context.pushNamed(Routes.forensicGuideDetails,
                        arguments: judicialGuide[index]);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 42.h,
                        width: 10.w,
                        decoration: BoxDecoration(
                            color: appColors.blue90,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      horizontalSpace(16.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("دليل عدلي",
                              style: TextStyles.cairo_14_medium
                                  .copyWith(color: appColors.grey15)),
                          Text(judicialGuide[index].name!,
                              style: TextStyles.cairo_14_semiBold),
                        ],
                      ),
                      const Spacer(),
                      const Icon(CupertinoIcons.arrow_up_left)
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return verticalSpace(10.h);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _lawyersListData(List<Lawyer>? lawyers) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(20.h),
          Text("نتائج مقدمي الخدمة", style: TextStyles.cairo_12_semiBold),
          verticalSpace(20.h),
          Container(
            child: ListView.separated(
              padding: const EdgeInsets.all(0),
              itemCount: lawyers!.length,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  borderRadius: BorderRadius.circular(8.sp),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DigitalProvidersScreen(
                            idLawyer: lawyers[index].id.toString(),
                          ),
                        ));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: appColors.grey15,
                        backgroundImage: lawyers[index].image != null
                            ? NetworkImage(lawyers[index].image!)
                            : null,
                      ),
                      horizontalSpace(16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lawyers[index].name!,
                              style: TextStyles.cairo_12_bold),
                          verticalSpace(4.h),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.location_solid,
                                color: appColors.primaryColorYellow,
                                size: 20.sp,
                              ),
                              horizontalSpace(4.w),
                              Text(lawyers[index].gender ?? "",
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
                                "0",
                                style: TextStyles.cairo_12_bold.copyWith(),
                              ),
                              horizontalSpace(4.w),
                              Icon(
                                CupertinoIcons.star_fill,
                                color: appColors.primaryColorYellow,
                                size: 20.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return verticalSpace(10.h);
              },
            ),
          ),
        ],
      ),
    );
  }

  _allListData(
      List<Service>? services,
      List<AdvisoryServicesType>? advisoryServicesTypes,
      List<Lawyer>? lawyers) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(14.0.sp),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Visibility(
              //   visible: getit<DigitalGuideCubit>()
              //       .fastSearchResponseModel!
              //       .data!
              //       .services!
              //       .isNotEmpty,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(vertical: 10.h),
              //     child: _serviceListData(getit<DigitalGuideCubit>()
              //         .fastSearchResponseModel!
              //         .data!
              //         .services),
              //   ),
              // ),
              // Visibility(
              //   visible: getit<DigitalGuideCubit>()
              //       .fastSearchResponseModel!
              //       .data!
              //       .advisoryServicesTypes!
              //       .isNotEmpty,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(vertical: 10.h),
              //     child: _advisoryListData(getit<DigitalGuideCubit>()
              //         .fastSearchResponseModel!
              //         .data!
              //         .advisoryServicesTypes),
              //   ),
              // ),
              // Visibility(
              //   visible: getit<DigitalGuideCubit>()
              //       .fastSearchResponseModel!
              //       .data!
              //       .appointmentTypes!
              //       .isNotEmpty,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(vertical: 10.h),
              //     child: _appointmentListData(getit<DigitalGuideCubit>()
              //         .fastSearchResponseModel!
              //         .data!
              //         .appointmentTypes),
              //   ),
              // ),
              Visibility(
                visible: getit<DigitalGuideCubit>()
                    .fastSearchResponseModel!
                    .data!
                    .lawyers!
                    .isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: _lawyersListData(getit<DigitalGuideCubit>()
                      .fastSearchResponseModel!
                      .data!
                      .lawyers),
                ),
              ),
              Visibility(
                visible: getit<DigitalGuideCubit>()
                    .fastSearchResponseModel!
                    .data!
                    .judicialGuide!
                    .isNotEmpty,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: _judicialGuideData(getit<DigitalGuideCubit>()
                      .fastSearchResponseModel!
                      .data!
                      .judicialGuide),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
