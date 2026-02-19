import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_request_response.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';

class SuccessPaymentInvoice extends StatelessWidget {
  const SuccessPaymentInvoice({super.key, Key? key, required this.data});

  final AdvisoryRequestResponse data;

  Future<void> _generateAndSharePdf(BuildContext context) async {
    String logo = await rootBundle.loadString('assets/svgs/logo.svg');
    String userType = CacheHelper.getData(key: 'userType');

    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      theme: pw.ThemeData.withFont(
        base: pw.Font.ttf(
            await rootBundle.load('assets/fonts/Cairo/Cairo-Regular.ttf')),
      ),
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(
            children: [
              pw.Container(
                alignment: pw.Alignment.topRight,
                height: 72.h,
                width: 150.w,
                child: pw.SvgImage(svg: logo),
              ),
              pw.Text('تمت عملية الدفع بنجاح',
                  style: const pw.TextStyle(fontSize: 20),
                  textDirection: pw.TextDirection.rtl),
              pw.SizedBox(height: 20),
              pw.Text('شكرا لك على استخدام خدماتنا',
                  style: const pw.TextStyle(fontSize: 20),
                  textDirection: pw.TextDirection.rtl),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  // Customer information
                  pw.TableRow(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                            userType == "client"
                                ? getit<MyAccountCubit>()
                                .clientProfile!
                                .data!
                                .client!
                                .name!
                                : getit<MyAccountCubit>()
                                .userDataResponse!
                                .data!
                                .client!
                                .name!,
                            textDirection: pw.TextDirection.rtl)),
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('اسم طالب الخدمة',
                            textDirection: pw.TextDirection.rtl)),
                  ]),
                  pw.TableRow(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                            userType == "client"
                                ? getit<MyAccountCubit>()
                                .clientProfile!
                                .data!
                                .client!
                                .email!
                                : getit<MyAccountCubit>()
                                .userDataResponse!
                                .data!
                                .client!
                                .email!,
                            textDirection: pw.TextDirection.rtl)),
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('بريد طالب الخدمة',
                            textDirection: pw.TextDirection.rtl)),
                  ]),
                  pw.TableRow(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                            userType == "client"
                                ? getit<MyAccountCubit>()
                                .clientProfile!
                                .data!
                                .client!
                                .mobile!
                                : getit<MyAccountCubit>()
                                .userDataResponse!
                                .data!
                                .client!
                                .phone!,
                            textDirection: pw.TextDirection.rtl)),
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('رقم الهاتف',
                            textDirection: pw.TextDirection.rtl)),
                  ]),
                  // Empty row for spacing
                  // Table header
                  pw.TableRow(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('بوابة الاستشارات',
                            textDirection: pw.TextDirection.rtl)),
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('اسم البوابة',
                            textDirection: pw.TextDirection.rtl)),
                  ]),
                  // Row 2
                  pw.TableRow(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                            '${data.data!.reservation!.advisoryServicesId!.title}',
                            textDirection: pw.TextDirection.rtl)),
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('الاستشارة المطلوبة',
                            textDirection: pw.TextDirection.rtl)),
                  ]),
                  // Row 3
                  pw.TableRow(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                            '${data.data!.reservation!.price ?? 0} ريال',
                            textDirection: pw.TextDirection.rtl)),
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('سعر الاستشارة',
                            textDirection: pw.TextDirection.rtl)),
                  ]),
                  // Row 4
                  pw.TableRow(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                            data.data!.reservation!.importance?.title ??
                                'مجانية',
                            textDirection: pw.TextDirection.rtl)),
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('مستوى الطلب',
                            textDirection: pw.TextDirection.rtl)),
                  ]),
                  // Row 5
                  pw.TableRow(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(DateTime.now().toString(),
                            textDirection: pw.TextDirection.rtl)),
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('وقت الشراء',
                            textDirection: pw.TextDirection.rtl)),
                  ]),
                ],
              ),
            ],
          ),
        );
      },
    ));

    // Save the PDF to a temporary file
    // Get the temporary directory path
    final tempDir = await getTemporaryDirectory();
    final tempPath = '${tempDir.path}/success_payment.pdf';
    final Uint8List bytes = await pdf.save();

    // Write the PDF to a file
    await File(tempPath).writeAsBytes(bytes);

    // Check if the file exists before sharing
    if (File(tempPath).existsSync()) {
      // Share the PDF file
      Share.shareFiles([tempPath],
          text: 'تمت عملية الدفع بنجاح', subject: 'فاتورة دفع');
    } else {
    }

    // Await the pdf.save() to get the Uint8List

    // Write the bytes to the file
    // await File(tempPath).writeAsBytes(bytes);

    // Share the PDF file
    // Share.shareFiles([tempPath],
    //     text: 'تمت عملية الدفع بنجاح', subject: 'فاتورة دفع');
    //
    // // Delete the temporary PDF file
    // File(tempPath).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.sp), // Padding around the entire content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "فاتورة الحجز",
                  style: TextStyles.cairo_18_bold.copyWith(color: appColors.black),
                ),
                verticalSpace(5.h),
                Text(
                  getTimeDate(DateTime.now().toString()), // Current date
                  style: TextStyles.cairo_14_regular.copyWith(color: appColors.grey),
                ),
                verticalSpace(20.h),
                _buildInfoSection(), // Custom method to build the info section
                verticalSpace(20.h),
                _buildDetailsSection(), // Custom method to build the details section
                verticalSpace(30.h),
                const Divider(color: appColors.grey5, thickness: 0.3),
                verticalSpace(10.h),
                _buildInvoiceTotal(context), // Custom method to build the total and actions section
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: EdgeInsets.all(16.0.sp),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoColumn('الرقم المرجعي', 'Invoice#${data.data!.reservation!.id.toString()}'),
          _buildInfoColumn('الرقم الضريبي', '3021550606'),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.cairo_14_regular.copyWith(color: appColors.black),
        ),
        verticalSpace(5.h),
        Text(
          value,
          style: TextStyles.cairo_12_regular.copyWith(color: appColors.black),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Container(
      padding: EdgeInsets.all(16.0.sp),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      child: Column(
        children: [
          _buildDetailsHeaderRow(),
          const Divider(color: appColors.grey5, thickness: 0.3),
          verticalSpace(10.h),
          _buildDetailsRow('نوع الاستشارة', '${data.data!.reservation!.advisoryServicesId!.title}'),
          verticalSpace(10.h),
          _buildDetailsRow('اسم الاستشارة', '${data.data!.reservation!.type!.title}'),

          verticalSpace(10.h),
          _buildDetailsRow('سعر الاستشارة', '${data.data!.reservation?.price ?? 0} ريال'),
          verticalSpace(10.h),
          _buildDetailsRow('مستوى الطلب', data.data!.reservation!.importance?.title ?? 'مجانية'),
          verticalSpace(10.h),
          _buildDetailsRow('وقت الشراء', getTimeDate(DateTime.now().toString())),
          verticalSpace(10.h),
          _buildDetailsRow('حالة الطلب', "تم الدفع", color: appColors.green),
        ],
      ),
    );
  }

  Widget _buildDetailsHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'التفاصيل',
          style: TextStyles.cairo_14_bold.copyWith(color: appColors.primaryColorYellow),
        ),
      ],
    );
  }

  Widget _buildDetailsRow(String description, String value, {Color color = appColors.black}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          description,
          style: TextStyles.cairo_14_regular.copyWith(color: appColors.black),
        ),
        Text(
          value,
          style: TextStyles.cairo_14_regular.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildInvoiceTotal(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailsRow('الرسوم', '${data.data!.reservation?.price ?? 0} ريال'),
        verticalSpace(10.h),
        _buildDetailsRow('الضرائب', '15%'),
        const Text("*السعر شامل ضريبة القيمة المضافة"),
        verticalSpace(10.h),
        const Divider(color: appColors.grey5, thickness: 0.3),
        verticalSpace(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'المجموع الكلي',
              style: TextStyles.cairo_16_bold.copyWith(color: appColors.primaryColorYellow),
            ),
            Text(
              '${data.data!.reservation?.price ?? 0} ريال',
              style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
            ),
          ],
        ),
        verticalSpace(20.h),
        Column(
          children: [
            CustomButton(
              bgColor: appColors.blue100,
              borderColor: appColors.blue100,
              fontWeight: FontWeight.bold,
              height: 40.h,
              fontSize: 12.sp,
              title: 'الذهاب للطلبات',
              onPress: () {
                context.pushNamedAndRemoveUntil(Routes.homeLayout,
                    predicate: (Route<dynamic> route) {
                      return false;
                    });
                context.pushNamed(Routes.myAdvisoryOrders);
              },
            ),
            SizedBox(height: 10.h),
            CustomButton(
              fontWeight: FontWeight.bold,
              height: 40.h,
              fontSize: 12.sp,
              title: 'مشاركة الفاتورة',
              onPress: () async {
                await _generateAndSharePdf(context);
              },
            ),
          ],
        ),
        verticalSpace(20.h),
      ],
    );
  }
}
