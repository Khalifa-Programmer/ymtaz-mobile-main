import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';
import 'package:yamtaz/feature/digital_guide/presentation/digetal_providers_screen.dart';

class ConsultantsListScreen extends StatelessWidget {
  final List<Lawyer> lawyers;

  const ConsultantsListScreen({super.key, required this.lawyers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: buildBlurredAppBar(context, "فريق الاستشاريين"),
      body: ListView.separated(
        padding: EdgeInsets.all(20.r),
        itemCount: lawyers.length,
        separatorBuilder: (context, index) => verticalSpace(16.h),
        itemBuilder: (context, index) {
          final lawyer = lawyers[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DigitalProvidersScreen(
                    idLawyer: lawyer.id.toString(),
                  ),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    clipBehavior: Clip.antiAlias,
                    child: CachedNetworkImage(
                      imageUrl: lawyer.image ?? "https://api.ymtaz.sa/uploads/person.png",
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SvgPicture.asset(AppAssets.Male),
                      errorWidget: (context, url, error) => SvgPicture.asset(AppAssets.Male),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lawyer.name ?? "مستشار",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F2D37),
                            fontFamily: 'Cairo',
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          lawyer.city?.title ?? "",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: appColors.primaryColorYellow,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16.sp, color: Colors.grey[300]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget verticalSpace(double height) => SizedBox(height: height);
}
