import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
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
            appBar: AppBar(
              title: Text('وسائل التواصل الاجتماعي',
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.all(16.sp),
              child: ConditionalBuilder(
                condition: state is LoadedSocialMedia,
                builder: (BuildContext context) {
                  final socialMediaData = (state as LoadedSocialMedia).data;
                  return ListView.builder(
                    itemCount: socialMediaData.data!.length,
                    itemBuilder: (context, index) {
                      final datum = socialMediaData.data![index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Container(
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
                          child: ListTile(
                            leading: Image.network(
                              datum.logo!,
                              width: 20,
                              height: 20,
                            ),
                            // Social media icon
                            title: Text(
                              datum.name!,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: appColors.black,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: appColors.grey,
                              size: 16.sp,
                            ),
                            onTap: () async {
                              final url = datum.url;
                              if (url != null && await canLaunch(url)) {
                                await launch(url);
                              } else {
                                // Handle the error if the URL can't be opened
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('لا يمكن فتح الرابط'),
                                  ),
                                );
                              }
                            },
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
            ),
          );
        },
      ),
    );
  }
}
