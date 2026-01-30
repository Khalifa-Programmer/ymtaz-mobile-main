import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart' as UL;
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/spacing.dart';
import '../data/model/judicial_guide_response_model.dart';

class SubDataDetails extends StatelessWidget {
  const SubDataDetails({super.key, required this.data});

  final SubCategory data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(data.name ?? "",
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
                Utils.generateSubCategoryMessage(data),
                subject: 'يمتاز',
                sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            // _buildBody(),
          ],
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) {
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
                if (data.address != null && data.address!.isNotEmpty)
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: appColors.primaryColorYellow,
                        size: 15.0.sp,
                      ),
                      horizontalSpace(5),
                      Expanded(
                        child: Text(
                          data.address ?? "العنوان",
                          maxLines: 3,
                          style: TextStyles.cairo_12_medium.copyWith(
                            color: appColors.black,
                          ),
                        ),
                      ),
                    ],
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
              children: [
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
                if (data.emails != null && data.emails!.isNotEmpty)
                  Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.emails!.length,
                        itemBuilder: (context, index) => Row(
                          children: [
                            Text(
                              "البريد الإلكتروني ",
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
                          return verticalSpace(10.h);
                        },
                      ),
                      verticalSpace(10.h),
                    ],
                  ),
                if (data.numbers != null && data.numbers!.isNotEmpty)
                  Column(
                    children: [
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
                                Utils.makePhoneCall(
                                    data.numbers![index].phoneNumber!);
                              },
                              child: Text(
                                "${data.numbers![index].phoneNumber!} ${data.numbers![index].phoneCode}+",
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
                      verticalSpace(10.h),
                    ],
                  ),
                if (data.workingHoursFrom != null &&
                    data.workingHoursFrom!.isNotEmpty &&
                    data.workingHoursTo != null &&
                    data.workingHoursTo!.isNotEmpty)
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
              ],
            ),
          ),
          verticalSpace(12),
          data.locationUrl != null
              ? Container(
                  height: 50.h,
                  width: double.infinity,
                  margin: EdgeInsets.all(10.0.w),
                  child: CupertinoButton(
                    color: appColors.blue100,
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Utils.openLink(data.locationUrl!);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            FontAwesomeIcons.mapMarkerAlt,
                            color: appColors.white,
                            size: 20.0.sp,
                          ),
                        ),
                        Text(
                          "عرض الموقع",
                          style: TextStyles.cairo_14_bold
                              .copyWith(color: appColors.white),
                        ),
                        horizontalSpace(30.w),
                      ],
                    ),
                  ),
                )
              : const SizedBox(),
          Container(
            height: 50.h,
            width: double.infinity,
            margin: EdgeInsets.all(10.0.w),
            child: CupertinoButton(
              color: appColors.primaryColorYellow,
              padding: EdgeInsets.zero,
              onPressed: () {
                context.pushNamed(Routes.forensicGuideSubCategory,
                    arguments: data);
              },
              child: Text(
                "عرض الدوائر",
                style:
                    TextStyles.cairo_14_bold.copyWith(color: appColors.white),
              ),
            ),
          ),
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

  static String generateSubCategoryMessage(SubCategory subCategory) {
    StringBuffer message = StringBuffer();

    message.writeln("⚖️ الدليل العدلي | ${subCategory.name ?? 'No Name'}");

    // if (subCategory.region != null) {
    //   message.writeln("•⁠  ⁠المنطقة: ${subCategory.region?.name ?? ''}");
    // }
    //
    // if (subCategory.city != null) {
    //   message.writeln("•⁠  ⁠المدينة: ${subCategory.city?.title ?? ''}");
    // }

    if (subCategory.address != null) {
      message.writeln("•⁠  ⁠العنوان: ${subCategory.address}");
    }

    if (subCategory.emails != null && subCategory.emails!.isNotEmpty) {
      message
          .writeln("•⁠  ⁠البريد الإلكتروني: ${subCategory.emails!.join(", ")}");
    }

    if (subCategory.numbers != null && subCategory.numbers!.isNotEmpty) {
      message.writeln(
          "•⁠  ⁠أرقام الهاتف: ${subCategory.numbers!.map((number) => number.phoneNumber).join(", ")}");
    }

    if (subCategory.workingHoursFrom != null &&
        subCategory.workingHoursTo != null) {
      message.writeln(
          "•⁠  ⁠ساعات العمل: من ${subCategory.workingHoursFrom} إلى ${subCategory.workingHoursTo}");
    }

    if (subCategory.locationUrl != null) {
      message.writeln("•⁠  ⁠الموقع: ${subCategory.locationUrl}");
    }

    // Add the footer message with the emoji
    message.writeln("\n⚖️ لتحميل تطبيق يمتاز:");
    message.writeln("https://onelink.to/bb6n4x");

    return message.toString();
  }

  static Future<void> openLink(String path) async {
    try {
      final Uri url = Uri.parse(path);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception("Unable to open the link");
      }
    } catch (e) {
      print("Error opening link: $e");
      throw Exception("Unable to open the link: $e");
    }
  }

  static Future<void> makePhoneCall(String number) async {
    String phone = "tel:$number";
    if (await UL.canLaunch(phone)) {
      await UL.launch(phone);
    } else {
      throw Exception("Unable to make a phone call");
    }
  }
}
