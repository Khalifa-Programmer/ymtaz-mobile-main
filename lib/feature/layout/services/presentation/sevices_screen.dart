import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_requirements_response.dart';
import 'package:yamtaz/feature/layout/services/logic/services_cubit.dart';
import 'package:yamtaz/feature/layout/services/logic/services_state.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/item_widget.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/spacing.dart';
import '../../../../l10n/locale_keys.g.dart';
import '../../account/presentation/guest_screen.dart';

class ServicesScreen extends StatelessWidget {
  ServicesScreen({super.key});

  var userType = CacheHelper.getData(key: 'userType');

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<ServicesCubit>()..loadServicesData(),
      child: BlocConsumer<ServicesCubit, ServicesState>(
        listener: (context, state) {
          state.whenOrNull(
            errorServices: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                ),
              );
            },
          );
        },
        listenWhen: (previous, current) =>
            current is LoadingServices ||
            current is LoadedServices ||
            current is ErrorServices,
        builder: (context, state) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: buildBlurredAppBar(context, LocaleKeys.services.tr()),
            body: Animate(
                effects: [FadeEffect(delay: 200.ms)],
                child: _buildBody(state, context)),
          );
        },
      ),
    );
  }

  Widget _buildBody(ServicesState state, BuildContext context) {
    return ConditionalBuilder(
      condition: getit<ServicesCubit>().servicesRequirementsResponse != null,
      builder: (context) {
        return RefreshIndicator(
          color: appColors.primaryColorYellow,
          onRefresh: () async {
            getit<ServicesCubit>().loadServices();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: RefreshIndicator(
              onRefresh: () async {
                getit<ServicesCubit>().loadServices();
              },
              child: ListView(
                children: [
                  verticalSpace(20.h),
                  Text(
                    "تخصص الخدمة العام",
                    style: TextStyles.cairo_14_bold,
                  ),
                  verticalSpace(5.h),
                  Text(
                    "اختر التخصص الذي ترغب فيه للحصول على الخدمات المتاحة",
                    style: TextStyles.cairo_12_semiBold
                        .copyWith(color: appColors.grey15),
                  ),
                  verticalSpace(20.h),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // separatorBuilder: (context, index) {
                    //   return SizedBox(
                    //     height: 10.h,
                    //   );
                    // },
                    itemCount: getit<ServicesCubit>()
                        .servicesRequirementsResponse!
                        .data!
                        .items!
                        .length,
                    itemBuilder: (context, index) {
                      Item item = getit<ServicesCubit>()
                          .servicesRequirementsResponse!
                          .data!
                          .items![index];
                      return ItemCardWidget(
                        index: index,
                        iconPath: AppAssets.services,
                        name: item.name ?? '',
                        total: item.services!.length.toString(),
                        id: item.id!,
                        onPressed: () {
                          if (userType == "guest") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GestScreen(),
                                ));
                          } else if (item.services!.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('لا يوجد خدمات متاحة'),
                              ),
                            );
                            return;
                          } else {
                            getit<ServicesCubit>().selectedMainType = item;
                            Navigator.of(context).pushNamed(
                                Routes.servicesSubTypeScreen,
                                arguments: item);
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      fallback: (context) {
        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}
