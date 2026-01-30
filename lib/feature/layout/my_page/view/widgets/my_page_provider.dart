// import 'package:card_swiper/card_swiper.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yamtaz/config/themes/styles.dart';
// import 'package:yamtaz/core/constants/colors.dart';
// import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
// import 'package:yamtaz/core/widgets/custom_button.dart';
// import 'package:yamtaz/core/widgets/spacing.dart';
// import 'package:yamtaz/feature/layout/my_page/logic/my_page_cubit.dart';
//
// import '../../../../../core/router/routes.dart';
//
// class MyPageProvider extends StatelessWidget {
//   const MyPageProvider({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.w),
//         child: ConditionalBuilder(
//           condition:
//               context.read<MyPageCubit>().myPageLawyerResponseModel != null,
//           builder: (BuildContext context) => Column(
//             children: [
//               SizedBox(
//                 height: 150.h,
//                 child: Swiper(
//                   itemBuilder: (BuildContext context, int index) {
//                     return ClipRRect(
//                       borderRadius: BorderRadius.circular(10.0.r),
//                       child: Image.network(
//                         "https://bestlawyeruae.com/wp-content/uploads/2022/02/%D8%A7%D8%B3%D8%AA%D8%B4%D8%A7%D8%B1%D8%A7%D8%AA-%D9%82%D8%A7%D9%86%D9%88%D9%86%D9%8A%D8%A9-%D8%A7%D8%B3%D8%B1%D9%8A%D8%A9-%D9%85%D8%AC%D8%A7%D9%86%D9%8A%D8%A9-%D8%A7%D9%84%D8%A7%D9%85%D8%A7%D8%B1%D8%A7%D8%AA.webp",
//                         fit: BoxFit.cover,
//                       ),
//                     );
//                   },
//                   itemCount: 3,
//                   pagination: const SwiperPagination(
//                     builder: DotSwiperPaginationBuilder(
//                       color: ColorsPalletes.white,
//                       activeColor: ColorsPalletes.blue100,
//                     ),
//                   ),
//                   physics: const BouncingScrollPhysics(),
//                   scale: 0.5,
//                   viewportFraction: 0.9,
//                 ),
//               ),
//               verticalSpace(20.h),
//               const TodayServices(),
//               verticalSpace(20.h),
//               const TodayAdvisory(),
//               verticalSpace(20.h),
//               const TodayAppointments(),
//             ],
//           ),
//           fallback: (BuildContext context) => const Center(
//             child: CircularProgressIndicator(),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class TodayAppointments extends StatelessWidget {
//   const TodayAppointments({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//                 radius: 12.r,
//                 backgroundColor: ColorsPalletes.blue100,
//                 child: const Icon(
//                   size: 15,
//                   Icons.today_rounded,
//                   color: ColorsPalletes.primaryColorYellow,
//                 )),
//             horizontalSpace(7.w),
//             Text(
//               'مواعيدي',
//               style: TextStyles.cairo_16_bold,
//             ),
//           ],
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 20.h),
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//           decoration: BoxDecoration(
//             color: Colors.white, //
//             borderRadius: BorderRadius.circular(12.r),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 // Shadow color
//                 spreadRadius: 1,
//                 // Spread radius
//                 blurRadius: 9,
//                 // Blur radius
//                 offset: const Offset(3, 3), // Offset in x and y directions
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               context
//                       .read<MyPageCubit>()
//                       .myPageLawyerResponseModel!
//                       .data!
//                       .reservations!
//                       .isEmpty
//                   ? Center(
//                       child: Text(
//                         'لا يوجد مواعيد لليوم',
//                         style: TextStyles.cairo_14_bold.copyWith(
//                           color: ColorsPalletes.black,
//                         ),
//                       ),
//                     )
//                   : ListView.separated(
//                       itemCount: 2,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Icon(
//                               CupertinoIcons.time_solid,
//                               color: ColorsPalletes.primaryColorYellow,
//                               size: 20.r,
//                             ),
//                             horizontalSpace(7.w),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'موعد اليوم',
//                                   style: TextStyles.cairo_14_bold.copyWith(
//                                     color: ColorsPalletes.black,
//                                   ),
//                                 ),
//                                 verticalSpace(5.h),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       CupertinoIcons.clock,
//                                       color: ColorsPalletes.grey15,
//                                       size: 15.r,
//                                     ),
//                                     horizontalSpace(5.w),
//                                     Text(
//                                       '10:00 صباحا',
//                                       style:
//                                           TextStyles.cairo_14_regular.copyWith(
//                                         color: ColorsPalletes.black,
//                                       ),
//                                     ),
//                                     horizontalSpace(95.w),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 5.h, horizontal: 15.w),
//                                       decoration: BoxDecoration(
//                                         color: ColorsPalletes.darkYellow90,
//                                         borderRadius:
//                                             BorderRadius.circular(4.r),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           "منتهي",
//                                           style: TextStyles.cairo_10_semiBold
//                                               .copyWith(
//                                                   color: ColorsPalletes.black),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             horizontalSpace(10.w),
//                           ],
//                         );
//                       },
//                       separatorBuilder: (BuildContext context, int index) {
//                         return Column(
//                           children: [
//                             verticalSpace(10.h),
//                             Divider(
//                               color: ColorsPalletes.grey5,
//                               thickness: 0.5.h,
//                             ),
//                             verticalSpace(10.h),
//                           ],
//                         );
//                       },
//                     ),
//               verticalSpace(20.h),
//               CustomButton(
//                 title: 'جميع المواعيد',
//                 onPress: () {},
//                 bgColor: Colors.white,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14.sp,
//                 height: 35.h,
//                 titleColor: ColorsPalletes.blue100,
//                 borderColor: ColorsPalletes.grey5,
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class TodayAdvisory extends StatelessWidget {
//   const TodayAdvisory({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//                 radius: 12.r,
//                 backgroundColor: ColorsPalletes.blue100,
//                 child: const Icon(
//                   size: 15,
//                   Icons.file_copy_rounded,
//                   color: ColorsPalletes.primaryColorYellow,
//                 )),
//             horizontalSpace(7.w),
//             Text(
//               'استشاراتي',
//               style: TextStyles.cairo_16_bold,
//             ),
//           ],
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 20.h),
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//           decoration: BoxDecoration(
//             color: Colors.white, //
//             borderRadius: BorderRadius.circular(12.r),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 // Shadow color
//                 spreadRadius: 1,
//                 // Spread radius
//                 blurRadius: 9,
//                 // Blur radius
//                 offset: const Offset(3, 3), // Offset in x and y directions
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               context
//                       .read<MyPageCubit>()
//                       .myPageLawyerResponseModel!
//                       .data!
//                       .advisoryServices!
//                       .isEmpty
//                   ? Center(
//                       child: Text(
//                         'لا يوجد استشارات',
//                         style: TextStyles.cairo_14_bold.copyWith(
//                           color: ColorsPalletes.black,
//                         ),
//                       ),
//                     )
//                   : ListView.separated(
//                       itemCount: context
//                                   .read<MyPageCubit>()
//                                   .myPageLawyerResponseModel!
//                                   .data!
//                                   .advisoryServices!
//                                   .length >
//                               1
//                           ? 2
//                           : 1,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Icon(
//                               Icons.file_copy_rounded,
//                               color: ColorsPalletes.primaryColorYellow,
//                               size: 20.r,
//                             ),
//                             horizontalSpace(7.w),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   context
//                                       .read<MyPageCubit>()
//                                       .myPageLawyerResponseModel!
//                                       .data!
//                                       .advisoryServices![index]
//                                       .type!
//                                       .title!,
//                                   style: TextStyles.cairo_14_bold.copyWith(
//                                     color: ColorsPalletes.black,
//                                   ),
//                                 ),
//                                 verticalSpace(5.h),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       CupertinoIcons.clock,
//                                       color: ColorsPalletes.grey15,
//                                       size: 15.r,
//                                     ),
//                                     horizontalSpace(5.w),
//                                     Text(
//                                       context
//                                                   .read<MyPageCubit>()
//                                                   .myPageLawyerResponseModel!
//                                                   .data!
//                                                   .advisoryServices![index]
//                                                   .price
//                                                   .toString() ==
//                                               "null"
//                                           ? '0' + ' ريال'
//                                           : context
//                                               .read<MyPageCubit>()
//                                               .myPageLawyerResponseModel!
//                                               .data!
//                                               .advisoryServices![index]
//                                               .price
//                                               .toString(),
//                                       style:
//                                           TextStyles.cairo_14_regular.copyWith(
//                                         color: ColorsPalletes.black,
//                                       ),
//                                     ),
//                                     horizontalSpace(125.w),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: 5.h, horizontal: 15.w),
//                                       decoration: BoxDecoration(
//                                         color: ColorsPalletes.darkYellow90,
//                                         borderRadius:
//                                             BorderRadius.circular(4.r),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           context
//                                               .read<MyPageCubit>()
//                                               .myPageLawyerResponseModel!
//                                               .data!
//                                               .advisoryServices![index]
//                                               .type!
//                                               .advisoryServicePrices!
//                                               .first
//                                               .title!,
//                                           style: TextStyles.cairo_10_semiBold
//                                               .copyWith(
//                                                   color: ColorsPalletes.black),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             horizontalSpace(10.w),
//                           ],
//                         );
//                       },
//                       separatorBuilder: (BuildContext context, int index) {
//                         return Column(
//                           children: [
//                             verticalSpace(10.h),
//                             Divider(
//                               color: ColorsPalletes.grey5,
//                               thickness: 0.5.h,
//                             ),
//                             verticalSpace(10.h),
//                           ],
//                         );
//                       },
//                     ),
//               verticalSpace(20.h),
//               CustomButton(
//                 title: 'جميع الاستشارات',
//                 onPress: () {
//                   Navigator.pushNamed(context, Routes.myAdvisoryOrders);
//                 },
//                 bgColor: Colors.white,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14.sp,
//                 height: 35.h,
//                 titleColor: ColorsPalletes.blue100,
//                 borderColor: ColorsPalletes.grey5,
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class TodayServices extends StatelessWidget {
//   const TodayServices({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//                 radius: 12.r,
//                 backgroundColor: ColorsPalletes.blue100,
//                 child: const Icon(
//                   size: 15,
//                   CupertinoIcons.tickets_fill,
//                   color: ColorsPalletes.primaryColorYellow,
//                 )),
//             horizontalSpace(7.w),
//             Text(
//               'خدماتي',
//               style: TextStyles.cairo_16_bold,
//             ),
//           ],
//         ),
//         Container(
//           margin: EdgeInsets.only(top: 20.h),
//           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//           decoration: BoxDecoration(
//             color: Colors.white, //
//             borderRadius: BorderRadius.circular(12.r),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 // Shadow color
//                 spreadRadius: 1,
//                 // Spread radius
//                 blurRadius: 9,
//                 // Blur radius
//                 offset: const Offset(3, 3), // Offset in x and y directions
//               ),
//             ],
//           ),
//           child: Column(
//             children: [
//               context
//                       .read<MyPageCubit>()
//                       .myPageLawyerResponseModel!
//                       .data!
//                       .services!
//                       .isEmpty
//                   ? Center(
//                       child: Text(
//                         'لا يوجد خدمات',
//                         style: TextStyles.cairo_14_bold.copyWith(
//                           color: ColorsPalletes.black,
//                         ),
//                       ),
//                     )
//                   : ListView.separated(
//                       itemCount: context
//                                   .read<MyPageCubit>()
//                                   .myPageLawyerResponseModel!
//                                   .data!
//                                   .services!
//                                   .length >
//                               1
//                           ? 2
//                           : 1,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemBuilder: (context, index) {
//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Icon(
//                               CupertinoIcons.tickets_fill,
//                               color: ColorsPalletes.primaryColorYellow,
//                               size: 20.r,
//                             ),
//                             horizontalSpace(7.w),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   context
//                                       .read<MyPageCubit>()
//                                       .myPageLawyerResponseModel!
//                                       .data!
//                                       .services![index]
//                                       .service!
//                                       .title!,
//                                   style: TextStyles.cairo_14_bold.copyWith(
//                                     color: ColorsPalletes.black,
//                                   ),
//                                 ),
//                                 verticalSpace(5.h),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       CupertinoIcons.clock,
//                                       color: ColorsPalletes.grey15,
//                                       size: 15.r,
//                                     ),
//                                     horizontalSpace(5.w),
//                                     Text(
//                                       getDate(context
//                                           .read<MyPageCubit>()
//                                           .myPageLawyerResponseModel!
//                                           .data!
//                                           .services![index]
//                                           .createdAt!),
//                                       style:
//                                           TextStyles.cairo_14_regular.copyWith(
//                                         color: ColorsPalletes.black,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 verticalSpace(5.h),
//
//                                 // Container(
//                                 //   padding: EdgeInsets.symmetric(
//                                 //       vertical: 5.h, horizontal: 15.w),
//                                 //   decoration: BoxDecoration(
//                                 //     color: ColorsPalletes.darkYellow90,
//                                 //     borderRadius:
//                                 //     BorderRadius.circular(4.r),
//                                 //   ),
//                                 //   child: Center(
//                                 //     child: Text(
//                                 //       context
//                                 //           .read<MyPageCubit>()
//                                 //           .myPageLawyerResponseModel!
//                                 //           .data!
//                                 //           .services![index]
//                                 //           .priority!
//                                 //           .title!,
//                                 //       style: TextStyles.cairo_10_semiBold
//                                 //           .copyWith(
//                                 //           color: ColorsPalletes.black),
//                                 //     ),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                             horizontalSpace(10.w),
//                           ],
//                         );
//                       },
//                       separatorBuilder: (BuildContext context, int index) {
//                         return Column(
//                           children: [
//                             verticalSpace(10.h),
//                             Divider(
//                               color: ColorsPalletes.grey5,
//                               thickness: 0.5.h,
//                             ),
//                             verticalSpace(10.h),
//                           ],
//                         );
//                       },
//                     ),
//               verticalSpace(20.h),
//               CustomButton(
//                 title: 'جميع الخدمات',
//                 onPress: () {
//                   Navigator.pushNamed(context, Routes.myServices);
//                 },
//                 bgColor: Colors.white,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14.sp,
//                 height: 35.h,
//                 titleColor: ColorsPalletes.blue100,
//                 borderColor: ColorsPalletes.grey5,
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
