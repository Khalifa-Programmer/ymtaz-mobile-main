import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/widgets/spacing.dart';
import '../../logic/contact_ymtaz_cubit.dart';
import '../../logic/contact_ymtaz_state.dart';

class SocialMediaScreen extends StatelessWidget {
  const SocialMediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<ContactYmtazCubit>()..getSocial(),
      child: BlocBuilder<ContactYmtazCubit, ContactYmtazState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFFBFBFB),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text('وسائل التواصل الاجتماعي',
                  style: TextStyles.cairo_16_bold.copyWith(
                    color: appColors.blue100,
                  )),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: appColors.blue100, size: 20.sp),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: ConditionalBuilder(
              condition: state is LoadedSocialMedia,
              builder: (BuildContext context) {
                final socialMediaData = (state as LoadedSocialMedia).data;
                return GridView.builder(
                  padding: EdgeInsets.all(20.sp),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.w,
                    mainAxisSpacing: 16.h,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: socialMediaData.data!.length,
                  itemBuilder: (context, index) {
                    final datum = socialMediaData.data![index];
                    return GestureDetector(
                      onTap: () async {
                        final url = datum.url;
                        if (url != null && await canLaunch(url)) {
                          await launch(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('لا يمكن فتح الرابط')),
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: appColors.blue100.withOpacity(0.06),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                          border: Border.all(
                            color: appColors.blue100.withOpacity(0.05),
                            width: 1.5,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: -20,
                              right: -20,
                              child: Container(
                                width: 80.w,
                                height: 80.w,
                                decoration: BoxDecoration(
                                  color: appColors.primaryColorYellow.withOpacity(0.03),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 70.w,
                                    height: 70.w,
                                    padding: EdgeInsets.all(15.sp),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: appColors.blue100.withOpacity(0.08),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Image.network(
                                      datum.logo!,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) => 
                                        Icon(Icons.link, color: appColors.primaryColorYellow, size: 30.sp),
                                    ),
                                  ),
                                  verticalSpace(16.h),
                                  Text(
                                    datum.name!,
                                    style: TextStyles.cairo_14_bold.copyWith(
                                      color: appColors.blue100,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              fallback: (BuildContext context) => const Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
