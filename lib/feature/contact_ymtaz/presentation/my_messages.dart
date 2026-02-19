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
                      itemBuilder: (context, index) => Container(
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
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ExpansionTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          collapsedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          backgroundColor:  appColors.grey3,
                          collapsedBackgroundColor: appColors.white,
                          tilePadding: EdgeInsets.symmetric(horizontal: 16.sp),
                          expandedCrossAxisAlignment: CrossAxisAlignment.start,
                          childrenPadding: EdgeInsets.zero,
                          leading: Icon(
                            allContactRequests[index].replyDescription != null
                                ? Icons.check_circle_outline
                                : Icons.access_time,
                            color: allContactRequests[index].replyDescription != null
                                ? Colors.green
                                : Colors.orange,
                          ),
                          title: Text(
                            "${getTypeNameById(allContactRequests[index].type!)} -  ${allContactRequests[index].subject} - ${getTimeDate(allContactRequests[index].createdAt.toString())}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: appColors.black,
                            ),
                          ),
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: appColors.grey3,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16.sp),
                                  bottomRight: Radius.circular(16.sp),
                                ),
                              ),
                              padding: EdgeInsets.all(16.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "الرسالة ",
                                        maxLines: 4,
                                        style: TextStyles.cairo_16_bold
                                            .copyWith(color: appColors.blue100),
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(16.sp),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(context
                                        .read<ContactYmtazCubit>()
                                        .myContactYmtazResponse!
                                        .data!
                                        .contactRequests![index]
                                        .subject!),
                                  ),
                                  context
                                              .read<ContactYmtazCubit>()
                                              .myContactYmtazResponse!
                                              .data!
                                              .contactRequests![index]
                                              .file !=
                                          null
                                      ? ListTile(
                                          contentPadding: EdgeInsets.zero,
                                          title: Text(
                                            "تم إرفاق ملف",
                                            style: TextStyles.cairo_12_bold
                                                .copyWith(
                                                    color: appColors.blue100),
                                          ),
                                          leading: Icon(
                                            Icons.attach_file,
                                            color: appColors.blue100,
                                          ),
                                          trailing: CupertinoButton(
                                            onPressed: () {
                                              String link = context
                                                  .read<ContactYmtazCubit>()
                                                  .myContactYmtazResponse!
                                                  .data!
                                                  .contactRequests![index]
                                                  .file!;
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfWebView(
                                                      link: link,
                                                    ),
                                                  ));
                                            },
                                            child: Text("عرض"),
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(height: 16.sp),
                                  Row(
                                    children: [
                                      Text(
                                        "رد يمتاز",
                                        style: TextStyles.cairo_16_bold
                                            .copyWith(color: appColors.blue100),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(16.sp),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(context
                                            .read<ContactYmtazCubit>()
                                            .myContactYmtazResponse!
                                            .data!
                                            .contactRequests![index]
                                            .replyDescription ??
                                        "سيتم الرد قريبا"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
