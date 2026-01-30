import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/validators.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/custom_container.dart';
import 'package:yamtaz/core/widgets/primary/text_form_primary.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_category_response.dart';
import 'package:yamtaz/feature/advisory_services/data/model/lawyer_advisory_services.dart';
import 'package:yamtaz/feature/advisory_services/logic/advisor_state.dart';
import 'package:yamtaz/feature/advisory_services/presentation/advisory_request_time.dart';
import 'package:yamtaz/feature/advisory_services/presentation/advisroy_request_time_digital.dart';
import 'package:yamtaz/feature/advisory_services/presentation/invice_screen.dart';
import 'package:yamtaz/feature/advisory_services/presentation/payment_gateway.dart';

import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/network/local/cache_helper.dart';
import '../../../yamtaz.dart';
import '../../layout/account/presentation/guest_screen.dart';
import '../logic/advisor_cubit.dart';

class RequestAdvisorDigitalGuideScreen extends StatefulWidget {
  RequestAdvisorDigitalGuideScreen(
      {super.key,
      required this.data,
      required this.lawyerId,
      required this.advisoryId,
      required this.needAppointment});

  Type data;
  String lawyerId;
  String advisoryId;
  int needAppointment;

  @override
  State<RequestAdvisorDigitalGuideScreen> createState() =>
      _RequestAdvisorStateDigitalGuide();
}

class _RequestAdvisorStateDigitalGuide
    extends State<RequestAdvisorDigitalGuideScreen> {
  TextEditingController aboutController = TextEditingController();
  int selectedType = -1;
  int selectedPrice = -1;
  File? documentFile;
  int selectedTypeIndex = -1;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<AdvisorCubit>(),
      child: BlocConsumer<AdvisorCubit, AdvisorState>(
        listener: (context, state) {
          state.whenOrNull(
            loadingReservation: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Dialog(
                    surfaceTintColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      padding: EdgeInsets.all(16.sp),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(
                            color: appColors.primaryColorYellow,
                          ),
                          horizontalSpace(16.sp),
                          const Text("جاري حجز الاستشارة"),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            sucessReservation: (data) {
              Navigator.of(context).pop();
              if (data.data!.paymentUrl != null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentAdvisoryScreen(
                            link: data.data!.paymentUrl!, data: data)));
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SuccessPaymentInvoice(data: data)));
              }

              // context.pushNamed(Routes.advisoryRequestTime, arguments: data);
            },
          );

          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('طلب استشارة',
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 16.sp),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      ConditionalBuilder(
                        condition: widget.data.advisoryServicesPrices != null,
                        builder: (BuildContext context) => CustomContainer(
                            title: 'مستوى الطلب',
                            child: CustomDropdown(
                              validator: (value) {
                                if (value == null) {
                                  return 'مستوى الطلب';
                                }
                                return null;
                              },
                              hintText: 'مستوى الطلب',
                              items: widget.data.advisoryServicesPrices,
                              onChanged: (value) {
                                selectedPrice = value!.importance!.id!.toInt();
                              },
                            )),
                        fallback: (BuildContext context) => const SizedBox(),
                      ),
                      CustomTextFieldPrimary(
                          hintText: "مضمون الطلب",
                          externalController: aboutController,
                          validator: Validators.validateNotEmpty,
                          multiLine: true,
                          title: "مضمون الطلب"),
                      verticalSpace(16.sp),
                      ConditionalBuilder(
                        condition: documentFile == null,
                        builder: (BuildContext context) => Animate(
                          effects: [FadeEffect(delay: 200.ms)],
                          child: GestureDetector(
                            onTap: () async => {
                              hideKeyboard(navigatorKey.currentContext!),
                              documentFile =
                                  await context.read<AdvisorCubit>().pickFile(),
                              setState(() {})
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150.h,
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: documentFile != null
                                        ? appColors.blue100
                                        : appColors.grey3,
                                    borderRadius: BorderRadius.circular(12.sp),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(AppAssets.upload),
                                      verticalSpace(20.h),
                                      Text(
                                        documentFile != null
                                            ? "تم إرفاق ملف"
                                            : "إرفاق ملف",
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400,
                                          color: documentFile != null
                                              ? appColors.white
                                              : appColors.blue100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Animate(
                                  effects: [FadeEffect(delay: 200.ms)],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            10.0), // زاوية الحواف
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(Icons.check,
                                              color: Colors.green),
                                          // علامة صح
                                          SizedBox(width: 8.0),
                                          // مسافة بين العلامة والنص
                                          Text("png, jpg, jpeg, pdf"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        fallback: (BuildContext context) => const SizedBox(),
                      ),
                      ConditionalBuilder(
                        condition: documentFile != null,
                        builder: (BuildContext context) => Animate(
                          effects: [FadeEffect(delay: 200.ms)],
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.sp),
                              ),
                              leading: const Icon(
                                Icons.file_copy,
                                color: appColors.blue90,
                              ),
                              title: Text(
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                textWidthBasis: TextWidthBasis.longestLine,
                                documentFile!.path.split('/').last,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w400,
                                  color: appColors.black,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "حجم الملف: ${(documentFile!.lengthSync() / 1024).toStringAsFixed(2)} KB",
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                      color: appColors.grey5,
                                    ),
                                  ),
                                  if (!documentFile!.path
                                      .toLowerCase()
                                      .endsWith('.pdf'))
                                    Text(
                                      "اضغط للعرض",
                                      style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                        color: appColors.grey5,
                                      ),
                                    ),
                                ],
                              ),
                              onTap: () {
                                if (documentFile!.path
                                    .toLowerCase()
                                    .endsWith('.pdf')) {
                                } else {
                                  viewImage(context, documentFile!);
                                }
                              },
                              trailing: GestureDetector(
                                onTap: () {
                                  documentFile = null;
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: appColors
                                        .red5, // Light red color for the circle background
                                  ),
                                  padding: const EdgeInsets.all(8.0),
                                  // Adjust the padding as needed
                                  child: const Icon(
                                    Icons.delete,
                                    color: appColors.red,
                                  ),
                                ),
                              )),
                        ),
                        fallback: (BuildContext context) => const SizedBox(),
                      ),
                      verticalSpace(16.sp),
                      CustomButton(
                        title: "التالي",
                        onPress: () {
                          var userType = CacheHelper.getData(key: 'userType');

                          if (userType == "guest") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const GestScreen(),
                                ));
                          } else if (_formKey.currentState!.validate()) {
                            if (widget.needAppointment == 1) {
                              ItemAdvisor data =
                                  ItemAdvisor.fromJson(widget.data.toJson());
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: getit<AdvisorCubit>()
                                      ..getAvailableTimes(widget.lawyerId),
                                    child: AdvisoryRequestTimeDigital(
                                      data: data,
                                      serviceId: widget.advisoryId,
                                      typeId: widget.data.id!,
                                      note: aboutController.text,
                                      importanceId: selectedPrice,
                                      lawyerId: widget.lawyerId,
                                    ),
                                  ),
                                ),
                              );

                              // context.pushNamed(Routes.advisoryRequestTime,
                              //     arguments: data);
                            } else {
                              Map<String, dynamic> data = {
                                "advisory_services_id": widget.advisoryId,
                                "type_id": widget.data.id,
                                "lawyer_id": widget.lawyerId,
                                "description": aboutController.text,
                                "importance_id": selectedPrice,
                                "accept_rules": 1,
                              };
                              FormData formData = FormData.fromMap(data);

                              if (documentFile != null) {
                                formData.files.add(MapEntry(
                                    "file",
                                    MultipartFile.fromFileSync(
                                        documentFile!.path)));
                              }
                              context.read<AdvisorCubit>().createAppointmentWithLawyer(
                                    formData,
                                  );
                            }
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void viewImage(BuildContext context, File? image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.file(
                  image!,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('X'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
