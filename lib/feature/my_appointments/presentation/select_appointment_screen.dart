import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/card_loading.dart';
import 'package:yamtaz/feature/my_appointments/logic/appointments_cubit.dart';
import 'package:yamtaz/feature/my_appointments/logic/appointments_state.dart';
import 'package:yamtaz/feature/my_appointments/presentation/widgets/lawyer_card.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/widgets/spacing.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../feature/my_appointments/data/model/avaliable_appointment_lawyer_model.dart';

class SelectLawyerScreen extends StatelessWidget {
  SelectLawyerScreen({super.key, required this.dataForm});

  FormData dataForm;

  final ValueNotifier<Set<Lawyer>> selectedLawyers = ValueNotifier({});
  final ValueNotifier<String> searchQuery = ValueNotifier('');
  final ValueNotifier<String> selectedFilter = ValueNotifier('All');

  void toggleLawyerSelection(Lawyer lawyer) {
    final currentSelection = selectedLawyers.value;
    if (currentSelection.contains(lawyer)) {
      currentSelection.remove(lawyer);
    } else {
      currentSelection.add(lawyer);
    }
    selectedLawyers.value = {...currentSelection};
  }

  void toggleSelectAll(List<Lawyer> lawyers) {
    selectedLawyers.value =
    selectedLawyers.value.length == lawyers.length ? {} : {...lawyers};
  }

  void handleError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppointmentsCubit, AppointmentsState>(
      listener: (context, state) {
        state.whenOrNull(
          loadingRequest: () {
            _showLoadingDialog(context);
          },
          loadedRequest: (data) {
            Navigator.pop(context); // Close screen

            context.pushNamedAndRemoveUntil(Routes.homeLayout, predicate: (Route<dynamic> route) {
              return false;
            });
            getit<AppointmentsCubit>().reset();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("تم الارسال بنجاح")),
            );
          },
          errorRequest: (message) {
            Navigator.pop(context); // Close loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          },
        );
      },
      buildWhen: (previous, current) {
        // Only rebuild for lawyer loading/success states
        return current.maybeWhen(
          appointmentLawyersByIdLoading: () => true,
          appointmentLawyersByIdSuccess: (_) => true,
          orElse: () => false,
        );
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: buildBlurredAppBar(context, 'اختيار المحامين'),
          body: state.whenOrNull(appointmentLawyersByIdLoading: () {
            return const Center(
              child: LawyerCardLoading(),
            );
          }, appointmentLawyersByIdSuccess: (data) {
            final lawyers = data.data!.map((e) => e.lawyer!).toList();
            return Stack(
              children: [
                Animate(
                  effects: [
                    FadeEffect(duration: 200.ms),
                  ],
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                    child: ValueListenableBuilder(
                      valueListenable: searchQuery,
                      builder: (context, query, _) {
                        final filteredLawyers = lawyers.where((lawyer) {
                          final matchesQuery = lawyer.name!.contains(query);
                          final matchesFilter = selectedFilter.value == 'All' ||
                              lawyer.region!.name == selectedFilter.value;
                          return matchesQuery && matchesFilter;
                        }).toList();
                        return ListView(
                          children: [
                            _buildSearchAndFilter(),
                            ValueListenableBuilder(
                              valueListenable: selectedLawyers,
                              builder: (context, selected, _) {
                                return Column(
                                  children: [
                                    if (selected.isNotEmpty)
                                      _buildSelectedLawyersCard(selected),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text("المحامين المتاحين ",
                                                style: TextStyles.cairo_14_bold
                                                    .copyWith(
                                                  color: appColors.blue100,
                                                )),
                                            Text("(${filteredLawyers.length}) ",
                                                style: TextStyles.cairo_12_bold
                                                    .copyWith(
                                                  color: appColors.grey15,
                                                )),
                                          ],
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              toggleSelectAll(filteredLawyers),
                                          child: Text(
                                            selected.length ==
                                                filteredLawyers.length
                                                ? "إلغاء التحديد"
                                                : "تحديد الكل",
                                            style: TextStyles.cairo_12_bold
                                                .copyWith(
                                              color: appColors.blue100,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpace(16.sp),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                      const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        final lawyer = filteredLawyers[index];
                                        return LawyerCard(
                                          lawyer,
                                          data.data![index].reservationType!,
                                          data.data![index].price!.toString(),
                                          data.data![index]
                                              .reservationImportance!,
                                          selected.contains(lawyer),
                                          toggleLawyerSelection,
                                        ).animate().fadeIn(
                                            duration: 300.ms,
                                            delay: (index * 100).ms);
                                      },
                                      separatorBuilder: (context, index) {
                                        return verticalSpace(16.sp);
                                      },
                                      itemCount: filteredLawyers.length,
                                    ),
                                  ],
                                );
                              },
                            ),
                            verticalSpace(100.h),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: selectedLawyers,
                  builder: (context, selected, _) {
                    return selected.isNotEmpty
                        ? Positioned(
                      bottom: 20.h,
                      left: 20.w,
                      right: 20.w,
                      child: CupertinoButton(
                        color: appColors.primaryColorYellow,
                        onPressed: () {
                          print(dataForm.fields);
                          List lawyers = selected.toList();
                          for (int i = 0;
                          i < lawyers.length;
                          i++) {
                            dataForm.fields.add(MapEntry(
                                "lawyer_ids[$i]",
                                lawyers[i].id.toString()));
                          }
                          print(dataForm.fields);


                                 getit<AppointmentsCubit>().requestAppointment(dataForm);
                        },
                        child: Text(
                          "إرسال الطلب للمختارين  ( ${selected.length} ) ",
                          style: TextStyles.cairo_14_bold
                              .copyWith(color: appColors.white),
                        ),
                      ).animate().slideY(
                          begin: 1.0,
                          end: 0.0,
                          duration: 300.ms,
                          curve: Curves.easeOut),
                    )
                        : SizedBox.shrink();
                  },
                ),
              ],
            );
          }),
        );
      },
    );
  }

  Widget _buildSearchAndFilter() {
    return Column(
      children: [
        CupertinoTextField(
          placeholder: 'البحث',
          placeholderStyle:
          TextStyles.cairo_14_semiBold.copyWith(color: appColors.grey15),
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
          clearButtonMode: OverlayVisibilityMode.editing,
          clearButtonSemanticLabel: 'مسح',
          onChanged: (query) => searchQuery.value = query,
        ).animate().fadeIn(duration: 300.ms),
        verticalSpace(16.h),
      ],
    );
  }

  Widget _buildSelectedLawyersCard(Set<Lawyer> selected) {
    return Animate(
      effects: [
        FadeEffect(duration: 200.ms, delay: 100.ms),
      ],
      child: Container(
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.04),
              spreadRadius: 3,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: appColors.grey2,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "عدد المحاميين المختارين : ${selected.length}",
              style:
              TextStyles.cairo_14_bold.copyWith(color: appColors.blue100),
            ),
            verticalSpace(16.sp),
            SizedBox(
              height: 40.h,
              child: Row(
                children: selected.map((lawyer) {
                  return CircleAvatar(
                    radius: 20.sp,
                    backgroundImage: CachedNetworkImageProvider(
                      lawyer.image!.isEmpty
                          ? "https://api.ymtaz.sa/uploads/person.png"
                          : lawyer.image!,
                    ),
                  ).animate();
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
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
                CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
                horizontalSpace(16.sp),
                const Text("جاري إرسال الطلب"),
              ],
            ),
          ),
        );
      },
    );
  }
}
