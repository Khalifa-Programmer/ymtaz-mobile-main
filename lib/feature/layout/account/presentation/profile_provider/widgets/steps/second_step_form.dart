import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/custom_container.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/auth/sign_up/data/models/countries_response.dart';
import 'package:yamtaz/feature/auth/sign_up/logic/sign_up_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class SecondStepForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final VoidCallback onGetCurrentPosition;
  final bool locationLoading;

  const SecondStepForm({
    super.key,
    required this.formKey,
    required this.onGetCurrentPosition,
    required this.locationLoading,
  });

  @override
  State<SecondStepForm> createState() => _SecondStepFormState();
}

class _SecondStepFormState extends State<SecondStepForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _buildNationalityAndCountry(),
          _buildRegionCity(),
          _buildLocationPicker(),
        ],
      ),
    );
  }

  Widget _buildNationalityAndCountry() {
    return ConditionalBuilder(
      condition: context.read<SignUpCubit>().nationalities != null &&
          context.read<SignUpCubit>().countries != null,
      builder: (BuildContext context) => Animate(
        effects: const [
          FadeEffect(
            duration: Duration(milliseconds: 500),
          ),
        ],
        child: Column(
          children: [
            CustomContainerEditSignUp(
              title: 'الجنسية',
              child: CustomDropdown.search(
                validator: (value) {
                  if (value == null) {
                    return 'الرجاء اختيار الجنسية';
                  }
                  return null;
                },
                hintText: "الجنسية",
                initialItem: context.read<SignUpCubit>().targetNationality,
                items: context
                    .read<SignUpCubit>()
                    .nationalities!
                    .data!
                    .nationalities,
                onChanged: (value) {
                  context.read<SignUpCubit>().selectedNationality = value!.id!;
                },
              )
            ),
            CustomContainerEditSignUp(
              title: 'الدولة',
              child: CustomDropdown.search(
                validator: (value) {
                  if (value == null) {
                    return 'الرجاء اختيار الدولة';
                  }
                  return null;
                },
                hintText: "الدولة",
                initialItem: context.read<SignUpCubit>().targetCountry,
                items: context
                    .read<SignUpCubit>()
                    .countries!
                    .data!
                    .countries,
                onChanged: (value) {
                  setState(() {
                    context.read<SignUpCubit>().selectCounrty(
                        value!.regions!, value.id!, value.phoneCode!);
                  });
                },
              )
            ),
          ],
        ),
      ),
      fallback: (BuildContext context) => const CupertinoActivityIndicator(),
    );
  }

  Widget _buildRegionCity() {
    SignUpCubit signUpCubit = context.read<SignUpCubit>();
    
    return Column(
      children: [
        // المنطقة
        Visibility(
          visible: signUpCubit.selectedCountry != -1,
          child: ConditionalBuilder(
            condition: signUpCubit.regions!.isNotEmpty,
            builder: (BuildContext context) => CustomContainerEditSignUp(
              title: 'المنطقة',
              child: CustomDropdown<Region>(
                hintText: "اختر المنطقة",
                initialItem: signUpCubit.targetRegion,
                items: signUpCubit.regions!,
                onChanged: (value) {
                  setState(() {
                    signUpCubit.selectRegion(value!.cities!, value.id!);
                  });
                },
              ),
            ),
            fallback: (BuildContext context) => const Text("لا يوجد مناطق"),
          ),
        ),
        
        // المدينة
        Visibility(
          visible: signUpCubit.selectedRegion != -1,
          child: ConditionalBuilder(
            condition: signUpCubit.cities!.isNotEmpty,
            builder: (BuildContext context) => CustomContainerEditSignUp(
              title: 'المدينة',
              child: CustomDropdown<City>(
                hintText: "اختر المدينة",
                initialItem: signUpCubit.targetCity,
                items: signUpCubit.cities,
                onChanged: (value) {
                  signUpCubit.selectDistricts(value!.id!);
                },
              ),
            ),
            fallback: (BuildContext context) => const Text("لا يوجد مدن"),
          ),
        ),
      ],
    );
  }

  Widget _buildLocationPicker() {
    SignUpCubit signUpCubit = context.read<SignUpCubit>();
    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "الموقع",
            style: TextStyles.cairo_14_semiBold.copyWith(
              color: appColors.blue100,
            ),
          ),
          verticalSpace(10.h),
          GestureDetector(
            onTap: widget.onGetCurrentPosition,
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(
                  horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: appColors.blue100,
                borderRadius: BorderRadius.circular(12.sp),
              ),
              child: ConditionalBuilder(
                condition: widget.locationLoading,
                builder: (BuildContext context) => const Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                  ),
                ),
                fallback: (BuildContext context) => Animate(
                  effects: [FadeEffect(delay: 200.ms)],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        signUpCubit.currentPositionUser == null
                            ? "اختر الموقع"
                            : '${signUpCubit.currentPositionUser?.latitude}. تم اختيار الموقع',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: appColors.white,
                        ),
                      ),
                      const Icon(
                        CupertinoIcons.location,
                        color: appColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
