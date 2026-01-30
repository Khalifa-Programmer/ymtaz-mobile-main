// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:yamtaz/core/widgets/custom_button.dart';
// import 'package:yamtaz/feature/layout/services/presentation/widgets/card_loading.dart';
// import 'package:yamtaz/feature/layout/services/presentation/widgets/lawyer_card.dart';
// import 'package:yamtaz/feature/layout/services/data/model/services_requirements_response.dart'
//     as s;
//
// import '../../../../config/themes/styles.dart';
// import '../../../../core/constants/colors.dart';
// import '../../../../core/di/dependency_injection.dart';
// import '../../../../core/widgets/alerts.dart';
// import '../../../../core/widgets/spacing.dart';
// import '../../../../core/widgets/web_payment_screen.dart';
// import '../../../../l10n/locale_keys.g.dart';
// import '../logic/services_cubit.dart';
// import '../logic/services_state.dart';
//
// class SelectLaywerForServicesScreen extends StatelessWidget {
//   const SelectLaywerForServicesScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//         value: getit<ServicesCubit>()
//           ..serviceLawyersById(
//               getit<ServicesCubit>().selectedServiceId.toString(),
//               getit<ServicesCubit>().selectedPriority.toString()),
//         child: BlocConsumer<ServicesCubit, ServicesState>(
//             listener: (context, state) {
//           state.whenOrNull(
//             requestService: () {
//               _showLoadingDialog(context);
//             },
//             requestServiceSuccess: (data) {
//               Navigator.of(context).pop();
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => PaymentScreen(
//                           link: data.data!.paymentUrl!, data: data)));
//             },
//             errorServices: (error) {
//               Navigator.of(context).pop();
//               AppAlerts.showAlert(
//                   context: context,
//                   message: error ?? "حدث خطأ يرجى اعادة المحاولة",
//                   buttonText: LocaleKeys.retry.tr(),
//                   type: AlertType.error);
//             },
//           );
//         }, builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(
//               centerTitle: true,
//               title: Text("اختيار محامي",
//                   style: TextStyles.cairo_14_bold.copyWith(
//                     color: appColors.black,
//                   )),
//             ),
//             body: state.whenOrNull(serviceLawyersByIdLoading: () {
//               return const Center(
//                 child:LawyerCardLoading(),
//               );
//             }, serviceLawyersByIdSuccess: (data) {
//               return Animate(
//                 effects: [
//                   FadeEffect(duration: 200.ms),
//                 ],
//                 child: Padding(
//                     padding:
//                         EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
//                     child: SingleChildScrollView(
//                         physics: const BouncingScrollPhysics(),
//                         child: Column(children: [
//                           Row(),
//                           Row(
//                             children: [
//                               Text("المحامين المتاحين ",
//                                   style: TextStyles.cairo_14_bold.copyWith(
//                                     color: appColors.blue100,
//                                   )),
//                               Text("(${data.data!.length!}) ",
//                                   style: TextStyles.cairo_12_bold.copyWith(
//                                     color: appColors.grey15,
//                                   )),
//                             ],
//                           ),
//                           verticalSpace(16.sp),
//                           ListView.separated(
//                               shrinkWrap: true,
//                               itemBuilder: (context, index) {
//                                 return LawyerCard(data.data![index].lawyer!,
//                                     data.data![index].service! , data.data![index].price!.toString() , data.data![index].importance! );
//                               },
//                               separatorBuilder: (context, index) {
//                                 return verticalSpace(16.sp);
//                               },
//                               itemCount: data.data!.length),
//                         ]))),
//               );
//             }),
//           );
//         }));
//   }
//
//
//   void _showLoadingDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return Dialog(
//           surfaceTintColor: Colors.transparent,
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(20))),
//           child: Container(
//             padding: EdgeInsets.all(16.sp),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(
//                   color: appColors.primaryColorYellow,
//                 ),
//                 horizontalSpace(16.sp),
//                 const Text("جاري حجز الخدمة"),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
