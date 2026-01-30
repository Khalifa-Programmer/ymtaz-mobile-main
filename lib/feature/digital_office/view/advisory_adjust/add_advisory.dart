import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/digital_office/data/models/advisory_available_types_response.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_cubit.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_state.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/alerts.dart';
import '../../../../core/widgets/spacing.dart';
import 'advisory_service_adjust_screen.dart';

class AddAdvisory extends StatefulWidget {
  const AddAdvisory({super.key});

  @override
  State<AddAdvisory> createState() => _AddAdvisoryState();
}

class _AddAdvisoryState extends State<AddAdvisory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("تخصيص استشاراتي",
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: BlocProvider.value(
        value: getit<OfficeProviderCubit>()..getAdvisorServicesProviderOffice(),
        child: BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
          listener: (context, state) {
            state.whenOrNull(
              loadingAddAdvisory: () {
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
                            const Text("جاري اضافة الاستشارة لملفك"),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              errorAddAdvisory: (message) {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
              loadedAddAdvisory: (data) {
                context.pop();

                AppAlerts.showAlert(
                    context: context,
                    message: "تم اضافة الاستشارة بنجاح",
                    buttonText: "استمرار",
                    type: AlertType.success);
                setState(() {});
              },
              errorAdvisoryAvaliable: (message) {
                context.pop();
                AppAlerts.showAlert(
                    context: context,
                    message: message,
                    buttonText: "حاول مرة اخرى",
                    type: AlertType.error);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              },
              loadedHideServices: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("تم تغيير حالة ظهور الاستشارة "),
                  ),
                );
                setState(() {});
              },
              loadedDeleteServices: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("تم حذف الاستشارة "),
                  ),
                );
                setState(() {});
                context.pop();
              },
            );
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ConditionalBuilder(
                    condition: context
                            .read<OfficeProviderCubit>()
                            .advisoryAvailableTypesResponse !=
                        null,
                    builder: (BuildContext context) => ConditionalBuilder(
                      condition: context
                          .read<OfficeProviderCubit>()
                          .advisoryAvailableTypesResponse!
                          .data!
                          .isNotEmpty,
                      builder: (BuildContext context) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: context
                              .read<OfficeProviderCubit>()
                              .advisoryAvailableTypesResponse!
                              .data!
                              .length,
                          itemBuilder: (BuildContext context, int index) {
                            var mainItem = context
                                .read<OfficeProviderCubit>()
                                .advisoryAvailableTypesResponse!
                                .data![index];

                            return CustomAdvisoryServiceCard(
                                serviceData: mainItem,
                                index: index,
                                currentIndex: index);
                          },
                          separatorBuilder: (context, index) =>
                              verticalSpace(16.h),
                        );
                      },
                      fallback: (BuildContext context) => const Center(
                          child: Text("لا يوجد استشارات متاحة لحسابك")),
                    ),
                    fallback: (BuildContext context) =>
                        const CupertinoActivityIndicator(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomAdvisoryServiceCard extends StatelessWidget {
  const CustomAdvisoryServiceCard({
    super.key,
    required this.serviceData,
    required this.index,
    required this.currentIndex,
  });

  final Type serviceData;
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdvisorySeviceAdjustScreen(
                      serviceData: serviceData,
                      index: index,
                      indexItem: currentIndex,
                    )));
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 17.w),
          margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 17.w),
          decoration: BoxDecoration(
            color: appColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                spreadRadius: 2.r,
                blurRadius: 10.r,
                offset: const Offset(0.0, 0.75),
              ),
            ],
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    serviceData.name!,
                    style: TextStyles.cairo_14_bold.copyWith(
                      color: appColors.blue100,
                    ),
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: serviceData.isHidden == false ? true : false,
                      onChanged: (bool value) {
                        if (serviceData.isHidden != null) {
                          context
                              .read<OfficeProviderCubit>()
                              .hideAdvisoryService(serviceData.id!.toString(),
                                  serviceData.isHidden ?? false);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AdvisorySeviceAdjustScreen(
                                        serviceData: serviceData,
                                        index: index,
                                        indexItem: currentIndex,
                                      )));
                        }
                      },
                    ),
                  )
                ],
              ),
              verticalSpace(4.h),
              serviceData.isActivated == true
                  ? Column(
                      children: [
                        Divider(
                          color: appColors.grey5.withOpacity(0.5),
                        ),
                        verticalSpace(4.h),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.money_dollar_circle_fill,
                                      color: appColors.primaryColorYellow,
                                    ),
                                    horizontalSpace(5.w),
                                    Text(
                                      serviceData
                                          .lawyerPrices![index].level!.name!,
                                      style:
                                          TextStyles.cairo_14_semiBold.copyWith(
                                        color: appColors.blue100,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      serviceData.isActivated == true &&
                                              serviceData.lawyerPrices != null
                                          ? "${serviceData.lawyerPrices![index].price!} ريال"
                                          : "${serviceData.ymtazPrices![index].price!} ريال",
                                      style:
                                          TextStyles.cairo_14_semiBold.copyWith(
                                        color: appColors.blue100,
                                      ),
                                    ),
                                  ],
                                ),
                            separatorBuilder: (context, index) =>
                                verticalSpace(10.h),
                            itemCount: serviceData.isActivated == true &&
                                    serviceData.lawyerPrices != null
                                ? serviceData.lawyerPrices!.length
                                : serviceData.ymtazPrices!.length),
                      ],
                    )
                  : const SizedBox(),
            ],
          )),
    );
  }
}
