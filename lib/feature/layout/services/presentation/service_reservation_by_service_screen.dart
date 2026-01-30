// import 'dart:io';
//
// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:yamtaz/core/constants/assets.dart';
// import 'package:yamtaz/core/widgets/custom_container.dart';
// import 'package:yamtaz/feature/layout/services/logic/services_cubit.dart';
//
// import '../../../../config/themes/styles.dart';
// import '../../../../core/constants/colors.dart';
// import '../../../../core/constants/validators.dart';
// import '../../../../core/di/dependency_injection.dart';
// import '../../../../core/network/local/cache_helper.dart';
// import '../../../../core/widgets/alerts.dart';
// import '../../../../core/widgets/custom_button.dart';
// import '../../../../core/widgets/primary/text_form_primary.dart';
// import '../../../../core/widgets/spacing.dart';
// import '../../../../core/widgets/web_payment_screen.dart';
// import '../../../../l10n/locale_keys.g.dart';
// import '../../../../yamtaz.dart';
// import '../../../digital_guide/data/model/fast_search_response_model.dart';
// import '../../account/presentation/guest_screen.dart';
// import '../logic/services_state.dart';
//
// class ServiceReservationByServiceScreen extends StatefulWidget {
//   const ServiceReservationByServiceScreen({super.key, required this.service});
//
//   final Service service;
//
//   @override
//   State<ServiceReservationByServiceScreen> createState() =>
//       _ServiceReservationByServiceScreenState();
// }
//
// class _ServiceReservationByServiceScreenState
//     extends State<ServiceReservationByServiceScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: getit<ServicesCubit>(),
//       child: BlocConsumer<ServicesCubit, ServicesState>(
//         listener: (context, state) {
//           state.whenOrNull(
//             requestService: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => const Center(
//                   child: CircularProgressIndicator(
//                     color: appColors.primaryColorYellow,
//                   ),
//                 ),
//               );
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
//                   message: "حدث خطأ يرجى اعادة المحاولة",
//                   buttonText: LocaleKeys.retry.tr(),
//                   type: AlertType.error);
//             },
//           );
//         },
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(
//               centerTitle: true,
//               title: Text(LocaleKeys.services.tr(),
//                   style: TextStyles.cairo_14_bold.copyWith(
//                     color: appColors.black,
//                   )),
//             ),
//             body: Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
//               child: SingleChildScrollView(
//                 physics: BouncingScrollPhysics(),
//                 child: Form(
//                   key: context.read<ServicesCubit>().formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Animate(
//                         effects: [FadeEffect(delay: 200.ms)],
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "خدمة ${widget.service.title!} ",
//                               style: TextStyles.cairo_16_bold.copyWith(
//                                 color: appColors.blue100,
//                               ),
//                             ),
//                             verticalSpace(16.sp),
//                             ConditionalBuilder(
//                               condition:
//                                   widget.service.ymtazLevelsPrices != null &&
//                                       widget.service.ymtazLevelsPrices != [],
//                               builder: (BuildContext context) =>
//                                   CustomContainer(
//                                       title: 'مستوى الطلب',
//                                       child: CustomDropdown<
//                                           YmtazLevelsPrice>.search(
//                                         validator: (value) {
//                                           if (value == null) {
//                                             return 'مستوى الطلب';
//                                           }
//                                           return null;
//                                         },
//                                         hintText: 'مستوى الطلب',
//                                         items:
//                                             widget.service.ymtazLevelsPrices!,
//                                         onChanged: (value) {
//                                           context
//                                               .read<ServicesCubit>()
//                                               .selectPeriority(
//                                                   value!.level!.id!);
//                                         },
//                                       )),
//                               fallback: (BuildContext context) =>
//                                   const SizedBox(),
//                             ),
//                             CustomTextFieldPrimary(
//                                 hintText: "مضمون الطلب",
//                                 externalController:
//                                     context.read<ServicesCubit>().description,
//                                 validator: Validators.validateNotEmpty,
//                                 multiLine: true,
//                                 title: "مضمون الطلب"),
//                             verticalSpace(16.sp),
//                             ConditionalBuilder(
//                               condition:
//                                   context.read<ServicesCubit>().documentFile ==
//                                       null,
//                               builder: (BuildContext context) => Animate(
//                                 effects: [FadeEffect(delay: 200.ms)],
//                                 child: GestureDetector(
//                                   onTap: () async => {
//                                     hideKeyboard(navigatorKey.currentContext!),
//
//                                     context.read<ServicesCubit>().documentFile =
//                                         await context
//                                             .read<ServicesCubit>()
//                                             .pickFile(),
//                                     setState(() {})
//                                   },
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         height: 150.h,
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 10.w, vertical: 10.h),
//                                         decoration: BoxDecoration(
//                                           color: context
//                                                       .read<ServicesCubit>()
//                                                       .documentFile !=
//                                                   null
//                                               ? appColors.blue100
//                                               : appColors.grey3,
//                                           borderRadius:
//                                               BorderRadius.circular(12.sp),
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             SvgPicture.asset(AppAssets.upload),
//                                             verticalSpace(20.h),
//                                             Text(
//                                               context
//                                                           .read<ServicesCubit>()
//                                                           .documentFile !=
//                                                       null
//                                                   ? "تم إرفاق ملف"
//                                                   : "إرفاق ملف",
//                                               style: TextStyle(
//                                                 fontFamily: 'Cairo',
//                                                 fontSize: 13.sp,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: context
//                                                             .read<
//                                                                 ServicesCubit>()
//                                                             .documentFile !=
//                                                         null
//                                                     ? appColors.white
//                                                     : appColors.blue100,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Animate(
//                                         effects: [FadeEffect(delay: 200.ms)],
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Container(
//                                             padding: const EdgeInsets.all(8.0),
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       10.0), // زاوية الحواف
//                                             ),
//                                             child: const Row(
//                                               children: [
//                                                 Icon(Icons.check,
//                                                     color: Colors.green),
//                                                 // علامة صح
//                                                 SizedBox(width: 8.0),
//                                                 // مسافة بين العلامة والنص
//                                                 Text("png, jpg, jpeg, pdf"),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               fallback: (BuildContext context) =>
//                                   const SizedBox(),
//                             ),
//                             ConditionalBuilder(
//                               condition:
//                                   context.read<ServicesCubit>().documentFile !=
//                                       null,
//                               builder: (BuildContext context) => Animate(
//                                 effects: [FadeEffect(delay: 200.ms)],
//                                 child: ListTile(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius:
//                                           BorderRadius.circular(12.sp),
//                                     ),
//                                     leading: const Icon(
//                                       Icons.file_copy,
//                                       color: appColors.blue90,
//                                     ),
//                                     title: Text(
//                                       softWrap: true,
//                                       overflow: TextOverflow.ellipsis,
//                                       textWidthBasis:
//                                           TextWidthBasis.longestLine,
//                                       context
//                                           .read<ServicesCubit>()
//                                           .documentFile!
//                                           .path
//                                           .split('/')
//                                           .last,
//                                       style: TextStyle(
//                                         fontFamily: 'Cairo',
//                                         fontSize: 13.sp,
//                                         fontWeight: FontWeight.w400,
//                                         color: appColors.black,
//                                       ),
//                                     ),
//                                     subtitle: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "حجم الملف: ${(context.read<ServicesCubit>().documentFile!.lengthSync() / 1024).toStringAsFixed(2)} KB",
//                                           style: TextStyle(
//                                             fontFamily: 'Cairo',
//                                             fontSize: 13.sp,
//                                             fontWeight: FontWeight.w400,
//                                             color: appColors.grey5,
//                                           ),
//                                         ),
//                                         if (!context
//                                             .read<ServicesCubit>()
//                                             .documentFile!
//                                             .path
//                                             .toLowerCase()
//                                             .endsWith('.pdf'))
//                                           Text(
//                                             "اضغط للعرض",
//                                             style: TextStyle(
//                                               fontFamily: 'Cairo',
//                                               fontSize: 13.sp,
//                                               fontWeight: FontWeight.w400,
//                                               color: appColors.grey5,
//                                             ),
//                                           ),
//                                       ],
//                                     ),
//                                     onTap: () {
//                                       if (context
//                                           .read<ServicesCubit>()
//                                           .documentFile!
//                                           .path
//                                           .toLowerCase()
//                                           .endsWith('.pdf')) {
//                                       } else {
//                                         viewImage(
//                                             context,
//                                             context
//                                                 .read<ServicesCubit>()
//                                                 .documentFile!);
//                                       }
//                                     },
//                                     trailing: GestureDetector(
//                                       onTap: () {
//                                         context
//                                             .read<ServicesCubit>()
//                                             .deleteDocument();
//                                         setState(() {});
//                                       },
//                                       child: Container(
//                                         decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: appColors
//                                               .red5, // Light red color for the circle background
//                                         ),
//                                         padding: const EdgeInsets.all(8.0),
//                                         // Adjust the padding as needed
//                                         child: const Icon(
//                                           Icons.delete,
//                                           color: appColors.red,
//                                         ),
//                                       ),
//                                     )),
//                               ),
//                               fallback: (BuildContext context) =>
//                                   const SizedBox(),
//                             ),
//                             CustomButton(
//                               title: "التالي",
//                               onPress: () {
//                                 var userType =
//                                     CacheHelper.getData(key: 'userType');
//
//                                 if (userType == "guest") {
//                                   Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => GestScreen(),
//                                       ));
//                                 } else if (context
//                                     .read<ServicesCubit>()
//                                     .formKey
//                                     .currentState!
//                                     .validate()) {
//                                   FormData form = FormData.fromMap({
//                                     "service_id": widget.service.id,
//                                     "priority": context
//                                         .read<ServicesCubit>()
//                                         .selectedPriority,
//                                     "description": context
//                                         .read<ServicesCubit>()
//                                         .description
//                                         .text,
//                                     "accept_rules": "1",
//                                   });
//                                   if (context
//                                           .read<ServicesCubit>()
//                                           .documentFile !=
//                                       null) {
//                                     form.files.add(MapEntry(
//                                         "file",
//                                         MultipartFile.fromFileSync(context
//                                             .read<ServicesCubit>()
//                                             .documentFile!
//                                             .path)));
//                                   }
//                                   context
//                                       .read<ServicesCubit>()
//                                       .requestService(form);
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void viewImage(BuildContext context, File? image) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: Container(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.file(
//                   image!,
//                   fit: BoxFit.cover,
//                 ),
//                 const SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//                   child: const Text('X'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
