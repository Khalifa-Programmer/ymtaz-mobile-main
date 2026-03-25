import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/widgets/rank_icon.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/spacing.dart';
import '../../../core/widgets/breadcrumb_widget.dart';
import '../../../core/widgets/moyasar_payment_screen.dart';
import '../../../core/widgets/new_payment_success.dart';
import '../../../core/widgets/webpay_new.dart';
import '../../../core/constants/assets.dart';
import '../../layout/account/presentation/client_profile/presentation/client_my_profile.dart';
import '../../layout/account/presentation/widgets/user_profile_row.dart';
import '../logic/advisory_cubit.dart';
import 'advisor_time_selection.dart';
import 'orders/view_order_details.dart';
import '../data/model/all_advirsory_response.dart' as all_advisory;

class AdvisoryPaymentScreen extends StatelessWidget {
  const AdvisoryPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = getit<AdvisoryCubit>();
    return BlocConsumer<AdvisoryCubit, AdvisoryState>(
      listener: (context, state) {
        if (state is AdvisorReservationLoading) {
          // جاري رفع البيانات ... (لا نفعل شيئاً هنا لأن الزر نفسه سيعرض علامة التحميل)
        } else if (state is AdvisorReservationLoaded) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MoyasarPaymentScreen(
                amount: state.data.data?.reservation?.price?.toString() ?? "0",
                description: "استشارة ${state.data.data?.reservation?.advisoryServicesSub?.name ?? ''}",
                transactionId: state.data.data?.transactionId,
                metadata: {
                  'reservation_id': state.data.data?.reservation?.id?.toString() ?? '',
                  'type': 'advisory',
                },
              ),
            ),
          ).then((result) {
            if (result == 'success' && context.mounted) {
              if (cubit.isInstant) {
                // If instant, we might want to go directly to details or a special success page
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewOrderDetails(
                      servicesRequirementsResponse:
                          all_advisory.Reservation.fromJson(state.data.data!.reservation!.toJson()),
                    ),
                  ),
                  (route) => false,
                );
              } else {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const NewSuccessPayment()),
                  (route) => false,
                );
              }
            }
          });
        } else if (state is AdvisorReservationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final parts = <String>[];
        if (cubit.selectedAdvisoryItem?.name != null) {
          parts.add(cubit.selectedAdvisoryItem!.name!);
        }
        if (cubit.selectedGeneralData?.name != null) {
          parts.add(cubit.selectedGeneralData!.name!);
        }
        if (cubit.selectedAccurateData?.name != null) {
          parts.add(cubit.selectedAccurateData!.name!);
        }
        final breadcrumbPath = parts.join(' > ');
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BreadcrumbWidget(path: breadcrumbPath),
            verticalSpace(15.h),
            Text(
              "مراجعة طلبك",
              style: TextStyles.cairo_14_bold,
            ),
            verticalSpace(5.h),
            Text(
              "ملخص طلبك للحصول على استشارة دقيقة",
              style: TextStyles.cairo_12_semiBold
                  .copyWith(color: appColors.grey15),
            ),
            verticalSpace(10.h),
            Divider(
              color: appColors.grey2,
              thickness: 1,
            ),
            verticalSpace(10.h),
            Text(
              "بيانات المحامي المختار",
              style: TextStyles.cairo_12_bold,
            ),
            verticalSpace(20.h),
            lawyerData(),
            verticalSpace(20.h),
            Text(
              "بيانات الاستشارة",
              style: TextStyles.cairo_12_bold,
            ),
            verticalSpace(20.h),
            advisoryData(),
            verticalSpace(50.h),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  color: appColors.primaryColorYellow,
                  onPressed: state is AdvisorReservationLoading
                      ? null
                      : () {
                          Map<String, Object?> map = {
                            "sub_price_id": cubit.selectedLevel?.id ?? cubit.selectedLawyer!.subCategory?.levels?.firstOrNull?.id,
                            "description": cubit.description,
                            "lawyer_id": cubit.selectedLawyer!.lawyer!.id,
                            "importance_id": cubit.selectedLawyer!.importance!.id,
                            "type_id": cubit.selectedAccurateData?.id ?? cubit.selectedLawyer!.subCategory!.id,
                            "advisory_services_id": cubit.selectedAdvisoryType.toString(),
                            "accept_rules": 1,
                          };
                          FormData newRequestData = FormData.fromMap(map);


                          if (cubit.isNeedAppointment && !cubit.isInstant) {
                            newRequestData.fields
                                .add(MapEntry("date", cubit.selectedDate!));
                            newRequestData.fields
                                .add(MapEntry("from", cubit.selectedFrom!));
                            newRequestData.fields
                                .add(MapEntry("to", cubit.selectedTo!));
                          }

                          if (cubit.isInstant) {
                            newRequestData.fields.add(MapEntry("is_instant", "1"));
                          }

                          if (cubit.imagesDocs.isNotEmpty) {
                            for (int i = 0; i < cubit.imagesDocs.length; i++) {
                              newRequestData.files.add(MapEntry(
                                "files[$i]",
                                MultipartFile.fromFileSync(
                                    cubit.imagesDocs[i].path!),
                              ));
                            }
                          }

                          if (cubit.recordPath != null &&
                              cubit.recordPath!.isNotEmpty) {
                            newRequestData.files.add(MapEntry(
                              "voice_file",
                              MultipartFile.fromFileSync(cubit.recordPath!),
                            ));
                          }

                          context
                              .read<AdvisoryCubit>()
                              .createAdvisoryRequest(newRequestData);
                        },
                  child: state is AdvisorReservationLoading
                      ? const CupertinoActivityIndicator(color: Colors.white)
                      : Text(
                          "إرسال الطلب",
                          style: TextStyles.cairo_14_bold
                              .copyWith(color: appColors.white),
                        )),
            ),
          ],
        );
      },
    );
  }

  Widget lawyerData() {
    var cubit = getit<AdvisoryCubit>();
    if (cubit.selectedLawyer == null || cubit.selectedLawyer!.lawyer == null) {
      return SizedBox.shrink(); // Return an empty widget if data is null
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          lawyerImage(cubit.selectedLawyer!.lawyer!),
          const SizedBox(width: 10),
          lawyerDetails(cubit.selectedLawyer!.lawyer!),
        ],
      ),
    ]);
  }

  Widget lawyerDetails(var lawyer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${lawyer.name}",
              style: TextStyles.cairo_14_bold.copyWith(
                color: appColors.blue100,
              ),
            ),
            horizontalSpace(3.0.w),
            lawyer.hasBadge == "blue"
                ? Icon(
                    Icons.verified,
                    color: CupertinoColors.activeBlue,
                    size: 15,
                  )
                : lawyer.hasBadge == "gold"
                    ? const Icon(
                        Icons.verified,
                        color: Color(0xffd0b101),
                        size: 15,
                      )
                    : SizedBox(),
          ],
        ),
        verticalSpace(4.h),
        Row(
          children: [
            Icon(
              CupertinoIcons.location_solid,
              color: appColors.primaryColorYellow,
              size: 15.sp,
            ),
            horizontalSpace(5.w),
            Text(
              "${(lawyer.region?.name == null || lawyer.region!.name.toString().toLowerCase() == 'null') ? '-' : lawyer.region!.name!} - ${(lawyer.city?.title == null || lawyer.city!.title.toString().toLowerCase() == 'null') ? '-' : lawyer.city!.title!}",
              style:
                  TextStyles.cairo_12_regular.copyWith(color: appColors.grey15),
            ),
          ],
        ),
      ],
    );
  }

  Widget lawyerImage(var lawyer) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          backgroundColor: getColor(lawyer.currentRank?.borderColor ?? ''),
          radius: 26.0.sp,
          child: CachedNetworkImage(
            imageUrl: lawyer.image?.isEmpty ?? true
                ? "https://api.ymtaz.sa/uploads/person.png"
                : lawyer.image!,
            imageBuilder: (context, imageProvider) => Container(
              width: 48.0.w,
              height: 48.0.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                imageShimmer(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Positioned(
          bottom: -8.0,
          left: 0,
          right: 35.w,
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 10.sp,
              backgroundColor: appColors.white,
              child: RankIcon(imageUrl: lawyer.currentRank?.image, size: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget advisoryData() {
    var cubit = getit<AdvisoryCubit>();
    if (cubit.selectedLawyer == null) {
      return SizedBox.shrink();
    }

    // اسم التخصص الدقيق المختار من الخطوة 2
    final String specialtyName = cubit.selectedAccurateData?.name
        ?? cubit.selectedLawyer!.subCategory?.name
        ?? '-';

    // نوع وسيلة الاستشارة المختارة في الخطوة 0
    // قمنا بأخذ الاسم مباشرة من الـ API لضمان التطابق التام مهما تغير المسمى
    final String mediumName = cubit.selectedAdvisoryItem?.name ?? '-';

    // السعر الصحيح: من المستوى المختار، أو من سعر المحامي كاحتياط
    final String price = cubit.selectedLevel?.price
        ?? cubit.selectedLawyer!.price
        ?? '-';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow(label: 'التخصص الدقيق', value: specialtyName),
        verticalSpace(8.h),
        _infoRow(label: 'وسيلة الاستشارة', value: mediumName),
        verticalSpace(8.h),
        _infoRow(label: 'سعر الاستشارة', value: '$price ريال'),
        if (cubit.selectedLevel?.level?.title != null) ...[  
          verticalSpace(8.h),
          _infoRow(label: 'مستوى الطلب', value: cubit.selectedLevel!.level!.title!),
        ],
        if (cubit.isNeedAppointment && !cubit.isInstant && cubit.selectedDate != null) ...[  
          verticalSpace(8.h),
          _infoRow(label: 'تاريخ الموعد', value: '${cubit.selectedDate} | ${cubit.selectedFrom} - ${cubit.selectedTo}'),
        ],
      ],
    );
  }

  Widget _infoRow({required String label, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey15),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyles.cairo_12_bold.copyWith(color: appColors.blue100),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(appColors.primaryColorYellow),
          ),
        );
      },
    );
  }
}
