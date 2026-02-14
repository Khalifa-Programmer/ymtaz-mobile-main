import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/digital_office/data/models/my_clients_response.dart';

class ClientProfileScreen extends StatelessWidget {
  final Client client;

  const ClientProfileScreen({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      appBar: AppBar(
        title: Text(
          'معلومات العميل',
          style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
        ),
        centerTitle: true,
        backgroundColor: appColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Profile Image
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    appColors.blue100,
                    appColors.blue90,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  // Profile Image
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: appColors.primaryColorYellow,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundColor: appColors.grey2,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: client.image ?? "https://api.ymtaz.sa/uploads/person.png",
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CupertinoActivityIndicator(),
                          errorWidget: (context, url, error) => Icon(
                            CupertinoIcons.person_alt_circle,
                            size: 60.sp,
                            color: appColors.grey15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(15.h),
                  // Client Name
                  Text(
                    client.name ?? 'غير متوفر',
                    style: TextStyles.cairo_20_bold.copyWith(color: appColors.white),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(5.h),
                  // Client Type Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: appColors.primaryColorYellow,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'عميل',
                      style: TextStyles.cairo_12_bold.copyWith(color: appColors.blue100),
                    ),
                  ),
                ],
              ),
            ),

            // Information Cards
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Personal Information Card
                  _buildInfoCard(
                    title: 'المعلومات الشخصية',
                    children: [
                      if (client.gender != null && client.gender!.isNotEmpty)
                        _buildInfoRow(
                          icon: CupertinoIcons.person,
                          label: 'الجنس',
                          value: client.gender == 'male' ? 'ذكر' : 'أنثى',
                        ),
                      if (client.accountType != null && client.accountType!.isNotEmpty)
                        _buildInfoRow(
                          icon: CupertinoIcons.person_badge_plus,
                          label: 'نوع الحساب',
                          value: client.accountType!,
                        ),
                      if (client.degree != null && client.degree!.title != null)
                        _buildInfoRow(
                          icon: CupertinoIcons.book,
                          label: 'الدرجة العلمية',
                          value: client.degree!.title!,
                        ),
                    ],
                  ),

                  verticalSpace(16.h),

                  // Location Information Card
                  _buildInfoCard(
                    title: 'معلومات الموقع',
                    children: [
                      if (client.nationality != null && client.nationality!.name != null)
                        _buildInfoRow(
                          icon: CupertinoIcons.flag,
                          label: 'الجنسية',
                          value: client.nationality!.name!,
                        ),
                      if (client.country != null && client.country!.name != null)
                        _buildInfoRow(
                          icon: CupertinoIcons.location_solid,
                          label: 'الدولة',
                          value: client.country!.name!,
                        ),
                      if (client.region != null && client.region!.name != null)
                        _buildInfoRow(
                          icon: CupertinoIcons.map,
                          label: 'المنطقة',
                          value: client.region!.name!,
                        ),
                      if (client.city != null && client.city!.title != null)
                        _buildInfoRow(
                          icon: CupertinoIcons.location_circle,
                          label: 'المدينة',
                          value: client.city!.title!,
                        ),
                    ],
                  ),

                  verticalSpace(16.h),

                  // Professional Information Card
                  if (client.generalSpecialty != null || 
                      client.accurateSpecialty != null ||
                      (client.sections != null && client.sections!.isNotEmpty))
                    _buildInfoCard(
                      title: 'المعلومات المهنية',
                      children: [
                        if (client.generalSpecialty != null && client.generalSpecialty!.title != null)
                          _buildInfoRow(
                            icon: CupertinoIcons.briefcase,
                            label: 'التخصص العام',
                            value: client.generalSpecialty!.title!,
                          ),
                        if (client.accurateSpecialty != null && client.accurateSpecialty!.title != null)
                          _buildInfoRow(
                            icon: CupertinoIcons.star,
                            label: 'التخصص الدقيق',
                            value: client.accurateSpecialty!.title!,
                          ),
                        if (client.sections != null && client.sections!.isNotEmpty)
                          _buildInfoRow(
                            icon: CupertinoIcons.square_list,
                            label: 'الأقسام',
                            value: client.sections!
                                .map((s) => s.section?.title ?? '')
                                .where((t) => t.isNotEmpty)
                                .join(', '),
                          ),
                      ],
                    ),

                  verticalSpace(16.h),

                  // Additional Information Card
                  _buildInfoCard(
                    title: 'معلومات إضافية',
                    children: [
                      if (client.currentLevel != null)
                        _buildInfoRow(
                          icon: CupertinoIcons.chart_bar,
                          label: 'المستوى الحالي',
                          value: 'المستوى ${client.currentLevel}',
                        ),
                      if (client.currentRank != null && client.currentRank!.name != null)
                        _buildInfoRow(
                          icon: CupertinoIcons.shield,
                          label: 'الرتبة الحالية',
                          value: client.currentRank!.name!,
                        ),
                      if (client.id != null)
                        _buildInfoRow(
                          icon: CupertinoIcons.number,
                          label: 'رقم العميل',
                          value: '#${client.id}',
                        ),
                      if (client.lastSeen != null && client.lastSeen!.isNotEmpty)
                        _buildInfoRow(
                          icon: CupertinoIcons.time,
                          label: 'آخر ظهور',
                          value: client.lastSeen!,
                        ),
                    ],
                  ),

                  // About Section
                  if (client.about != null && client.about!.isNotEmpty) ...[
                    verticalSpace(16.h),
                    _buildInfoCard(
                      title: 'نبذة عن العميل',
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            client.about!,
                            style: TextStyles.cairo_14_semiBold.copyWith(
                              color: appColors.blue100,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: appColors.grey2, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
          ),
          verticalSpace(12.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: appColors.primaryColorYellow.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: appColors.primaryColorYellow,
              size: 20.sp,
            ),
          ),
          horizontalSpace(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey15),
                ),
                verticalSpace(4.h),
                Text(
                  value,
                  style: TextStyles.cairo_14_semiBold.copyWith(color: appColors.blue100),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
