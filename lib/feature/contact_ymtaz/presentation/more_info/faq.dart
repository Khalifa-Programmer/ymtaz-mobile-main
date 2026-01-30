import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../logic/contact_ymtaz_cubit.dart';
import '../../logic/contact_ymtaz_state.dart';
class Faq extends StatelessWidget {
  const Faq({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<ContactYmtazCubit>()..getFaq(),
      child: BlocBuilder<ContactYmtazCubit, ContactYmtazState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('الأسئلة الشائعة',
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.all(16.sp),
              child: ConditionalBuilder(
                  condition: state is LoadedFaq,
                  builder: (BuildContext context) {
                    final faqData = (state as LoadedFaq).data;
                    return ListView.builder(
                      itemCount: faqData.data!.length ?? 0,
                      itemBuilder: (context, index) {
                        final datum = faqData.data![index];
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
                            child: ExpansionTile(
                              title: Text(
                                datum.title ?? '',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: appColors.black,
                                ),
                              ),
                              collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              tilePadding:
                                  EdgeInsets.symmetric(horizontal: 16.sp),
                              backgroundColor: Colors.white,
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              childrenPadding: EdgeInsets.all(10.sp),
                              trailing: const Icon(
                                Icons.expand_more,
                                color: appColors.black,
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10.sp),
                                  child: Text(
                                    datum.data ?? '',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: appColors.black,
                                    ),
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
                      )),
            ),
          );
        },
      ),
    );
  }
}
