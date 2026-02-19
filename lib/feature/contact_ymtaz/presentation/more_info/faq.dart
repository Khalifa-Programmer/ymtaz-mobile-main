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
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: ExpansionTile(
                              collapsedBackgroundColor: appColors.primaryColorYellow,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              collapsedTextColor: Colors.white,
                              iconColor: appColors.primaryColorYellow,
                              collapsedIconColor: Colors.white,
                              title: Text(
                                datum.title ?? '',
                                style: TextStyles.cairo_14_bold,
                              ),
                              collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                              childrenPadding: EdgeInsets.zero,
                              trailing: const Icon(
                                Icons.expand_more,
                              ),
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(16.sp),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                      top: BorderSide(
                                        color: appColors.primaryColorYellow.withOpacity(0.2),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    datum.data ?? '',
                                    style: TextStyles.cairo_14_regular.copyWith(
                                      color: appColors.blue100,
                                      height: 1.5,
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
