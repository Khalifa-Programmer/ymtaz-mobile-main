import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/digital_office/data/models/services_ymtaz_response_model.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_cubit.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_state.dart';
import 'package:yamtaz/feature/digital_office/view/sevices_adjust/service_adjust_screen.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/spacing.dart';

class AddServices extends StatefulWidget {
  const AddServices({super.key});

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تخصيص خدماتي",
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: getit<OfficeProviderCubit>()..getServices(),
        child: BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
          listener: (context, state) {
            state.whenOrNull(
              errorServices: (message) {
                context.pop();
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
                    content: Text("تم تغيير حالة ظهور الخدمة "),
                  ),
                );
                setState(() {});
              },
              loadedDeleteServices: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("تم حذف الخدمة "),
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
                            .servicesYmtazResponseModel !=
                        null,
                    builder: (BuildContext context) => Column(
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => CustomServiceCard(
                                  serviceData: context
                                      .read<OfficeProviderCubit>()
                                      .servicesYmtazResponseModel!
                                      .data![index],
                                  index: index,
                                ),
                            separatorBuilder: (context, index) =>
                                verticalSpace(16.h),
                            itemCount: context
                                .read<OfficeProviderCubit>()
                                .servicesYmtazResponseModel!
                                .data!
                                .length)
                      ],
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

class CustomServiceCard extends StatelessWidget {
  const CustomServiceCard({
    super.key,
    required this.serviceData,
    required this.index,
  });

  final Datum serviceData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SeviceAdjustScreen(
                      serviceData: serviceData,
                      index: index,
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
                    serviceData.title!,
                    style: TextStyles.cairo_14_bold.copyWith(
                      color: appColors.blue100,
                    ),
                  ),
                  const Spacer(),
                  Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: serviceData.isHidden == false &&
                              serviceData.isActivated == true
                          ? true
                          : false,
                      onChanged: (bool value) {
                        if (serviceData.isHidden != null) {
                          context.read<OfficeProviderCubit>().hideService(
                              serviceData.id!.toString(),
                              serviceData.isHidden ?? false);
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeviceAdjustScreen(
                                        serviceData: serviceData,
                                        index: index,
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
                                      serviceData.ymtazLevelsPrices![index]
                                          .level!.name!,
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
                                          : "${serviceData.ymtazLevelsPrices![index].price!} ريال",
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
                                : serviceData.ymtazLevelsPrices!.length),
                      ],
                    )
                  : const SizedBox(),
            ],
          )),
    );
  }
}
