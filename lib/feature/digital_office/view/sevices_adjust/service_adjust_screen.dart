import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_state.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/widgets/alerts.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/spacing.dart';
import '../../data/models/services_ymtaz_response_model.dart';
import '../../logic/office_provider_cubit.dart';

class SeviceAdjustScreen extends StatelessWidget {
  SeviceAdjustScreen({
    super.key,
    required this.serviceData,
    required this.index,
  });

  final Datum serviceData;

  Datum? serviceDataNew;

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<OfficeProviderCubit>()..getServicesListPrices(serviceData),
      child: BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
        listener: (context, state) {
          state.whenOrNull(
            loadingRequestServices: () {
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
                          const Text("جاري تخصيص الخدمة لملفك"),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            errorServices: (message) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            },
            loadedRequestServices: (data) {
              context.pop();
              context.read<OfficeProviderCubit>().getServices();

              AppAlerts.showAlert(
                  context: context,
                  message: "تم تخصيص الخدمه بنجاح",
                  buttonText: "استمرار",
                  type: AlertType.success);
            },
            errorRequestServices: (message) {
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
          );
        },
        builder: (BuildContext context, state) {
          serviceDataNew = context
              .read<OfficeProviderCubit>()
              .servicesYmtazResponseModel!
              .data![index];

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("تخصيص خدمة",
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serviceData.title!,
                          style: TextStyles.cairo_16_bold.copyWith(
                            color: appColors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "وصف الخدمة : ",
                          style: TextStyles.cairo_12_semiBold.copyWith(
                            color: appColors.grey15,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          serviceData.details ?? "",
                          style: TextStyles.cairo_12_semiBold.copyWith(
                            color: appColors.grey15,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(
                              CupertinoIcons.money_dollar_circle_fill,
                              color: appColors.primaryColorYellow,
                            ),
                            horizontalSpace(4.w),
                            Text(
                              "تسعير المنتج",
                              style: TextStyles.cairo_14_semiBold.copyWith(
                                color: appColors.black,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 75.w,
                                  height: 40.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: appColors.white,
                                    border: Border.all(
                                      color: appColors.primaryColorYellow,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${serviceData.minPrice} ر.س ",
                                        style:
                                            TextStyles.cairo_12_bold.copyWith(
                                          color: appColors.primaryColorYellow,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Container(
                                  height: 40.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w, vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: appColors.white,
                                    border: Border.all(
                                      color: appColors.primaryColorYellow,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${serviceData.maxPrice} ر.س ",
                                        style:
                                            TextStyles.cairo_12_bold.copyWith(
                                          color: appColors.primaryColorYellow,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          color: appColors.grey2,
                        ),
                        const SizedBox(height: 10),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: serviceData.isActivated == true
                              ? serviceData.lawyerPrices!.length
                              : serviceData.ymtazLevelsPrices!.length,
                          itemBuilder: (context, index) {
                            return Animate(
                              effects: [FadeEffect(delay: 200.ms)],
                              child: PriceData(
                                  serviceData.isActivated == true
                                      ? serviceData.lawyerPrices!
                                      : serviceData.ymtazLevelsPrices!,
                                  index),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return verticalSpace(15.h);
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                            title: serviceDataNew!.isActivated == true
                                ? "تعديل الخدمة"
                                : "تخصيص الخدمة",
                            onPress: () {
                              Map<String, dynamic> data = {
                                "service_id": serviceData.id,
                              };
                              if (serviceDataNew!.isActivated == true) {
                                for (int i = 0;
                                    i < serviceDataNew!.lawyerPrices!.length;
                                    i++) {
                                  data["importance[$i][${"id"}]"] =
                                      serviceDataNew!
                                          .lawyerPrices![i].level!.id;

                                  data["importance[$i][${"isHidden"}]"] =
                                      serviceDataNew!
                                          .lawyerPrices![i].isHidden!;

                                  data["importance[$i][${'price'}]"] = context
                                      .read<OfficeProviderCubit>()
                                      .textEditingControllers[i]
                                      .text;
                                }
                                FormData from = FormData.fromMap(data);
                                context
                                    .read<OfficeProviderCubit>()
                                    .createServices(from);
                              } else {
                                for (int i = 0;
                                    i < serviceData.ymtazLevelsPrices!.length;
                                    i++) {
                                  data["importance[$i][${"id"}]"] = serviceData
                                      .ymtazLevelsPrices![i].level!.id;

                                  data["importance[$i][${"isHidden"}]"] =
                                      serviceData
                                          .ymtazLevelsPrices![i].isHidden;

                                  data["importance[$i][${'price'}]"] = context
                                      .read<OfficeProviderCubit>()
                                      .textEditingControllers[i]
                                      .text;
                                }
                                FormData from = FormData.fromMap(data);
                                context
                                    .read<OfficeProviderCubit>()
                                    .createServices(from);
                              }
                            }),
                        serviceDataNew!.isActivated == false
                            ? const SizedBox()
                            : _additionalSettings(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _additionalSettings(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.read<OfficeProviderCubit>().hideService(
                serviceData.id!.toString(), serviceDataNew!.isHidden ?? false);
          },
          child: Row(
            children: [
              CircleAvatar(
                radius: 15.r,
                backgroundColor: appColors.grey10.withOpacity(0.2),
                child: Center(
                  child: IconButton(
                      highlightColor: appColors.grey10.withOpacity(0.5),
                      color: appColors.grey10.withOpacity(0.5),
                      onPressed: () {},
                      icon: Center(
                        child: Icon(
                          CupertinoIcons.eye_solid,
                          color: appColors.grey10,
                          size: 15.r,
                        ),
                      )),
                ),
              ),
              SizedBox(width: 5.w),
              serviceDataNew!.isHidden == true
                  ? Text("تفعيل المنتج",
                      style: TextStyles.cairo_14_bold.copyWith(
                        color: appColors.grey10,
                      ))
                  : Text("تعطيل المنتج",
                      style: TextStyles.cairo_14_bold.copyWith(
                        color: appColors.grey10,
                      )),
            ],
          ),
        ),
        SizedBox(height: 20.h),
        CupertinoButton(
          onPressed: () {
            context
                .read<OfficeProviderCubit>()
                .removeService(serviceData.id!.toString());
          },
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              CircleAvatar(
                radius: 15.r,
                backgroundColor: Colors.red.withOpacity(0.2),
                child: IconButton(
                    highlightColor: Colors.red.withOpacity(0.5),
                    color: Colors.red.withOpacity(0.5),
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.delete,
                      color: appColors.red,
                      size: 15.r,
                    )),
              ),
              SizedBox(width: 5.w),
              Text("حذف المنتج",
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.red,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}

class PriceData extends StatefulWidget {
  PriceData(this.data, this.index, {super.key});

  List<YmtazLevelsPrice> data;
  int index;

  @override
  State<PriceData> createState() => _PriceDataState();
}

class _PriceDataState extends State<PriceData> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: widget.data[widget.index].isHidden == 0 ? false : true,
            activeColor: appColors.primaryColorYellow,
            onChanged: (bool value) {
              setState(() {
                widget.data[widget.index].isHidden = value ? 1 : 0;
              });
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            widget.data[widget.index].level!.name!,
            style: TextStyles.cairo_12_semiBold.copyWith(
              color: appColors.black,
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          flex: 2,
          child: SizedBox(
            width: 156.w,
            child: CupertinoTextField(
              placeholder: 'السعر',
              suffix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "ر.س",
                  style: TextStyles.cairo_12_semiBold.copyWith(
                    color: appColors.grey15,
                  ),
                ),
              ),
              placeholderStyle: TextStyles.cairo_12_semiBold.copyWith(
                color: appColors.grey15,
              ),
              style: TextStyles.cairo_12_semiBold.copyWith(
                color: appColors.black,
              ),
              decoration: BoxDecoration(
                color: appColors.white,
                border: Border.all(
                  color: appColors.grey5,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              controller: context
                  .read<OfficeProviderCubit>()
                  .textEditingControllers[widget.index],
            ),
          ),
        ),
      ],
    );
  }
}
