import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/contact_ymtaz/logic/contact_ymtaz_cubit.dart';
import 'package:yamtaz/feature/contact_ymtaz/logic/contact_ymtaz_state.dart';
import '../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../core/widgets/app_attachment_tile.dart';
import '../../../core/widgets/webview_pdf.dart';

class MyMessages extends StatelessWidget {
  const MyMessages({super.key});


  // get name by iding type id
  String getTypeNameById(int id) {
      if (id == 1) {
        return 'اقتراح';
      }
      else if (id == 2) {
        return 'شكوى';
      }
      else if (id == 3) {
        return 'اخرى';
      }
    return '';
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<ContactYmtazCubit>()..getData(),
      child: BlocBuilder<ContactYmtazCubit, ContactYmtazState>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(16.sp),
              child: ConditionalBuilder(
                  condition: state is LoadedContactYmtazState,
                  builder: (BuildContext context) {
                  List<dynamic> allContactRequests = context.read<ContactYmtazCubit>().myContactYmtazResponse!.data!.contactRequests!;
                    // افترض أن القائمة تسمى dataList
allContactRequests.sort((a, b) {
  // تحويل النصوص إلى DateTime للمقارنة
  DateTime dateA = DateTime.parse(a.createdAt!);
  DateTime dateB = DateTime.parse(b.createdAt!);
  
  // للمقارنة العكسية (الأحدث أولاً) نستخدم dateB قبل dateA
  return dateB.compareTo(dateA);
});
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        final request = allContactRequests[index];
                        final bool isReplied = request.replyDescription != null;
                        
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: appColors.blue100.withOpacity(0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: Colors.grey[100]!, width: 1),
                          ),
                          child: ExpansionTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.r),
                            ),
                            backgroundColor: const Color(0xFFFBFBFB),
                            collapsedBackgroundColor: Colors.white,
                            tilePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                            expandedCrossAxisAlignment: CrossAxisAlignment.start,
                            childrenPadding: EdgeInsets.zero,
                            leading: Container(
                              padding: EdgeInsets.all(8.sp),
                              decoration: BoxDecoration(
                                color: (isReplied ? Colors.green : Colors.orange).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isReplied ? Icons.check_circle_rounded : Icons.pending_actions_rounded,
                                color: isReplied ? Colors.green : Colors.orange,
                                size: 20.sp,
                              ),
                            ),
                            title: Text(
                              "${getTypeNameById(request.type!)} - ${request.subject}",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: appColors.blue100,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            subtitle: Text(
                              getTimeDate(request.createdAt.toString()),
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: Colors.grey[500],
                                fontFamily: 'Cairo',
                              ),
                            ),
                            children: [
                              Container(
                                padding: EdgeInsets.all(20.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildMessageSection("محتوى الرسالة", request.subject ?? "", appColors.blue100),
                                    if (request.file != null) ...[
                                      verticalSpace(16.h),
                                      AppAttachmentTile(
                                        url: request.file,
                                        title: "المرفقات",
                                      ),
                                    ],
                                    verticalSpace(20.h),
                                    const Divider(),
                                    verticalSpace(16.h),
                                    _buildMessageSection("رد يمتاز", request.replyDescription ?? "سيتم الرد عليك في أقرب وقت ممكن", appColors.primaryColorYellow),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => verticalSpace(10.h),
                      itemCount: context
                          .read<ContactYmtazCubit>()
                          .myContactYmtazResponse!
                          .data!
                          .contactRequests!
                          .length,
                    );
                  },
                  fallback: (BuildContext context) => const Center(
                        child: CircularProgressIndicator(
                          color: appColors.primaryColorYellow,
                        ),
                      )),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMessageSection(String title, String content, Color titleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: titleColor,
            fontFamily: 'Cairo',
          ),
        ),
        verticalSpace(8.h),
        Text(
          content,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey[700],
            fontFamily: 'Cairo',
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
