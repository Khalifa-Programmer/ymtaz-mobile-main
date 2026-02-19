import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as UL;
import 'package:yamtaz/feature/forensic_guide/data/model/judicial_guide_response_model.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/spacing.dart';

class ForensicGuideCategoryDetailsScreen extends StatelessWidget {
  const ForensicGuideCategoryDetailsScreen({super.key, required this.data});

  final JudicialGuide data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(data.name ?? "الدليل العدلي",
              style: TextStyles.cairo_14_bold.copyWith(
                color: appColors.black,
              )),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.share,
                color: appColors.black,
              ),
              onPressed: () {
                final RenderBox box = context.findRenderObject() as RenderBox;

                Share.share(
                  Utils.generateJudicialGuideShareText(data),
                  subject: 'يمتاز',
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size,
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              verticalSpace(10.h),
              _judicialGuideDetails(data.subCateogry!),
              // _buildBody(),
            ],
          ),
        ));
  }

  Padding _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.0.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.04),
                  blurRadius: 10,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.network(
                    data.image ?? "https://api.ymtaz.sa/uploads/person.png",
                    width: MediaQuery.of(context).size.width,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
                verticalSpace(20),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.gavel,
                      color: appColors.primaryColorYellow,
                      size: 20.0.sp,
                    ),
                    horizontalSpace(5),
                    Text(
                      data.name ?? "الدليل العدلي",
                      style: TextStyles.cairo_14_bold.copyWith(
                        color: appColors.black,
                      ),
                    ),
                  ],
                ),
                verticalSpace(10),
                Text(
                  data.about ?? "الوصف",
                  style: TextStyles.cairo_12_medium.copyWith(
                    color: appColors.black,
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.04),
                  blurRadius: 10,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data.emails != null && data.emails!.isNotEmpty) ...[
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.emails!.length,
                    itemBuilder: (context, index) => Row(
                      children: [
                        Text(
                          "البريد الإلكتروني",
                          style: TextStyles.cairo_12_semiBold
                              .copyWith(color: appColors.grey15),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            // Copy the email to the clipboard
                            Clipboard.setData(
                                ClipboardData(text: data.emails![index]));

                            // Show the green toast message

                            // Launch the email submission utility if needed
                            // Utils.launchSubmission(data.emails![index]);
                          },
                          child: Text(
                            data.emails![index],
                            style: TextStyles.cairo_12_semiBold
                                .copyWith(color: appColors.blue100),
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (BuildContext context, int index) {
                      return verticalSpace(20.h);
                    },
                  ),
                  verticalSpace(20.h),
                ],
                if (data.numbers != null && data.numbers!.isNotEmpty) ...[
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.numbers!.length,
                    itemBuilder: (context, index) => Row(
                      children: [
                        Text(
                          "الهاتف ${index + 1} ",
                          style: TextStyles.cairo_12_semiBold
                              .copyWith(color: appColors.grey15),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Utils.makePhoneCall(data.numbers![index]);
                          },
                          child: Text(
                            data.numbers![index],
                            style: TextStyles.cairo_12_semiBold
                                .copyWith(color: appColors.blue100),
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (BuildContext context, int index) {
                      return verticalSpace(20.h);
                    },
                  ),
                  verticalSpace(20.h),
                ],
                if (data.workingHoursFrom != null &&
                    data.workingHoursTo != null) ...[
                  Row(
                    children: [
                      Text(
                        "مواعيد العمل",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      Text(
                        "${data.workingHoursFrom} - ${data.workingHoursTo}",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.blue100),
                      ),
                    ],
                  ),
                  verticalSpace(20.h),
                ],
                if (data.url != null && data.url!.isNotEmpty)
                  Row(
                    children: [
                      Text(
                        "الموقع الإلكتروني",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Utils.launchSubmission(data.url!);
                        },
                        child: Text(
                          data.url!,
                          style: TextStyles.cairo_12_semiBold
                              .copyWith(color: appColors.blue100),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _judicialGuideDetails(SubCateogry data) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      margin: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 0.0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            blurRadius: 10,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("بيانات المحكمة",
              style: TextStyles.cairo_14_bold
                  .copyWith(color: appColors.primaryColorYellow)),
          verticalSpace(10.h),
          Row(
            children: [
              Text(
                "اسم المحكمة",
                style: TextStyles.cairo_12_semiBold
                    .copyWith(color: appColors.grey15),
              ),
              Spacer(),
              Text(
                data.name!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyles.cairo_12_semiBold
                    .copyWith(color: appColors.blue100),
              ),
            ],
          ),
          verticalSpace(10.h),
          // if (data.region != null &&
          //     data.region!.name != null &&
          //     data.region!.name!.isNotEmpty)
          //   Column(
          //     children: [
          //       Row(
          //         children: [
          //           Text(
          //             "المنطقة",
          //             style: TextStyles.cairo_12_semiBold
          //                 .copyWith(color: appColors.grey15),
          //           ),
          //           Spacer(),
          //           Text(
          //             "${data.region!.name}",
          //             overflow: TextOverflow.ellipsis,
          //             maxLines: 1,
          //             style: TextStyles.cairo_12_semiBold
          //                 .copyWith(color: appColors.blue100),
          //           ),
          //         ],
          //       ),
          //       verticalSpace(10.h),
          //     ],
          //   ),
          // if (data.city != null &&
          //     data.city!.title != null &&
          //     data.city!.title!.isNotEmpty)
          //   Column(
          //     children: [
          //       Row(
          //         children: [
          //           Text(
          //             "المدينة",
          //             style: TextStyles.cairo_12_semiBold
          //                 .copyWith(color: appColors.grey15),
          //           ),
          //           Spacer(),
          //           Text(
          //             "${data.city!.title}",
          //             overflow: TextOverflow.ellipsis,
          //             maxLines: 1,
          //             style: TextStyles.cairo_12_semiBold
          //                 .copyWith(color: appColors.blue100),
          //           ),
          //         ],
          //       ),
          //       verticalSpace(10.h),
          //     ],
          //   ),
        ],
      ),
    );
  }
}

class Utils {
  static Future<void> sendEmail({required String email}) async {
    String mail = "mailto:$email";
    if (await UL.canLaunch(mail)) {
      await UL.launch(mail);
    } else {
      throw Exception("Unable to open the email");
    }
  }

  static void launchSubmission(String destination) async {
    final Uri params = Uri(
      scheme: destination.startsWith('https') ? 'https' : 'mailto',
      path: destination,
    );
    String url = params.toString();
    if (await UL.canLaunch(url)) {
      await UL.launch(url);
    } else {}
  }

  static Future<void> makePhoneCall(String number) async {
    String phone = "tel:$number";
    if (await UL.canLaunch(phone)) {
      await UL.launch(phone);
    } else {
      throw Exception("Unable to make a phone call");
    }
  }

  static String generateJudicialGuideShareText(JudicialGuide guide) {
    StringBuffer shareText = StringBuffer();

    // عنوان المشاركة
    shareText.writeln("⚖️ يمتاز | الدليل العدلي");

    // معلومات أساسية
    if (guide.name != null && guide.name!.isNotEmpty) {
      shareText.writeln("•⁠  ⁠اسم الدائرة: ${guide.name}");
    }
    if (guide.subCateogry != null &&
        guide.subCateogry!.name != null &&
        guide.subCateogry!.name!.isNotEmpty) {
      shareText.writeln("•⁠  ⁠المحكمة: ${guide.subCateogry!.name}");
    }
    if (guide.about != null && guide.about!.isNotEmpty) {
      shareText.writeln("•⁠  ⁠نبذة: ${guide.about}");
    }
    if (guide.workingHoursFrom != null && guide.workingHoursTo != null) {
      shareText.writeln(
          "•⁠  ⁠ساعات العمل: من ${guide.workingHoursFrom} إلى ${guide.workingHoursTo}");
    }
    if (guide.url != null && guide.url!.isNotEmpty) {
      shareText.writeln("•⁠  ⁠الموقع الإلكتروني: ${guide.url}");
    }

    // إضافة البريد الإلكتروني
    if (guide.emails != null && guide.emails!.isNotEmpty) {
      shareText.writeln("•⁠  ⁠البريد الإلكتروني: ${guide.emails!.join(", ")}");
    }

    // إضافة أرقام الاتصال
    if (guide.numbers != null && guide.numbers!.isNotEmpty) {
      shareText.writeln("•⁠  ⁠أرقام الاتصال: ${guide.numbers!.join(", ")}");
    }

    // معلومات إضافية
    if (guide.subCateogry != null) {
      if (guide.subCateogry!.address != null &&
          guide.subCateogry!.address!.isNotEmpty) {
        shareText.writeln("•⁠  ⁠عنوان المحكمة: ${guide.subCateogry!.address}");
      }
    }

    // رابط التحميل
    shareText.writeln("\n⚖️ لتحميل تطبيق يمتاز:");
    shareText.writeln("https://onelink.to/bb6n4x");

    return shareText.toString();
  }
}
