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
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: Text(
          "المعلومات الشخصية",
          style: TextStyles.cairo_14_bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            children: [
              // Profile Header Card (Matching Advisor style)
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: appColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 4,
                      blurRadius: 9,
                      offset: const Offset(3, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    _buildProfileImage(client),
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            client.name ?? "بدون اسم",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: appColors.primaryColorYellow,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "عميل",
                            style: TextStyles.cairo_12_semiBold.copyWith(
                              color: appColors.grey15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              verticalSpace(20.h),

              // Overview Section
              if (client.about != null && client.about!.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: appColors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 9,
                        offset: const Offset(3, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "نبذة عن العميل",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: appColors.grey15,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        client.about!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: appColors.blue100,
                        ),
                      ),
                    ],
                  ),
                ),

              if (client.about != null && client.about!.isNotEmpty)
                verticalSpace(20.h),

              // Personal Information Section
              Container(
                padding: EdgeInsets.all(20.0.r),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: appColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 4,
                      blurRadius: 9,
                      offset: const Offset(3, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "المعلومات الشخصية",
                      style: TextStyles.cairo_12_medium
                          .copyWith(color: appColors.grey15),
                    ),
                    verticalSpace(20.h),
                    _buildInfoRow(
                      icon: CupertinoIcons.person,
                      label: "الجنس",
                      value: client.gender == 'male' ? 'ذكر' : 'أنثى',
                    ),
                    _buildInfoRow(
                      icon: CupertinoIcons.flag,
                      label: "الجنسية",
                      value: client.nationality?.name ?? "",
                    ),
                    _buildInfoRow(
                      icon: CupertinoIcons.location_solid,
                      label: "الدولة",
                      value: client.country?.name ?? "",
                    ),
                    _buildInfoRow(
                      icon: CupertinoIcons.map,
                      label: "المنطقة",
                      value: client.region?.name ?? "",
                    ),
                    _buildInfoRow(
                      icon: CupertinoIcons.location_circle,
                      label: "المدينة",
                      value: client.city?.title ?? "",
                    ),
                    _buildInfoRow(
                      icon: CupertinoIcons.book,
                      label: "الدرجة العلمية",
                      value: client.degree?.title ?? "",
                    ),
                  ],
                ),
              ),

              verticalSpace(20.h),

              // Additional Details Section
              Container(
                padding: EdgeInsets.all(20.0.r),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: appColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 4,
                      blurRadius: 9,
                      offset: const Offset(3, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "تفاصيل إضافية",
                      style: TextStyles.cairo_12_medium
                          .copyWith(color: appColors.grey15),
                    ),
                    verticalSpace(20.h),
                    _buildInfoRow(
                      icon: CupertinoIcons.chart_bar,
                      label: "المستوى",
                      value: "المستوى ${client.currentLevel ?? 0}",
                    ),
                    _buildInfoRow(
                      icon: CupertinoIcons.shield,
                      label: "الرتبة",
                      value: client.currentRank?.name ?? "",
                    ),
                    _buildInfoRow(
                      icon: CupertinoIcons.number,
                      label: "رقم العميل",
                      value: "#${client.id ?? ''}",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(Client client) {
    return Container(
      width: 100.w,
      height: 100.h,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: CachedNetworkImage(
        imageUrl: client.image ?? "https://ymtaz.sa/uploads/person.png",
        fit: BoxFit.cover,
        placeholder: (context, url) => const CupertinoActivityIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.person, size: 50),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    if (value.isEmpty || value.toLowerCase() == 'null') return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          Icon(
            icon,
            color: appColors.primaryColorYellow,
            size: 20.sp,
          ),
          horizontalSpace(10.w),
          Text(
            label,
            style: TextStyles.cairo_12_semiBold.copyWith(color: appColors.grey15),
          ),
          const Spacer(),
          Expanded(
            child: Text(
              value,
              style: TextStyles.cairo_12_semiBold.copyWith(color: appColors.blue100),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
