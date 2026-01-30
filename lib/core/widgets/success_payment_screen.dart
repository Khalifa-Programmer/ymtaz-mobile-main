import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/services/data/model/services_request_response.dart';

import '../../config/themes/styles.dart';
import '../../feature/layout/account/logic/my_account_cubit.dart';
import '../constants/colors.dart';

class SuccessPayment extends StatelessWidget {
  const SuccessPayment({super.key, required this.data});

  final ServicesRequestResponse data;

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
                                    .account!
                                    .name!
                                : getit<MyAccountCubit>()
                                    .userDataResponse!
                                    .data!
                                    .account!
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
                                    .account!
                                    .email!
                                : getit<MyAccountCubit>()
                                    .userDataResponse!
                                    .data!
                                    .account!
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
                                    .account!
                                    .phone!
                                : getit<MyAccountCubit>()
                                    .userDataResponse!
                                    .data!
                                    .account!
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
                        child: pw.Text('بوابة الخدمات',
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
                            '${data.data!.serviceRequest!.service!.title}',
                            textDirection: pw.TextDirection.rtl)),
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('الخدمة المطلوبة',
                            textDirection: pw.TextDirection.rtl)),
                  ]),
                  // Row 3
                  pw.TableRow(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('${data.data!.serviceRequest!.price}',
                            textDirection: pw.TextDirection.rtl)),
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('سعر الخدمة',
                            textDirection: pw.TextDirection.rtl)),
                  ]),
                  // Row 4
                  pw.TableRow(children: [
                    pw.Container(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                            '${data.data!.serviceRequest!.priority!.title}',
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
      // Share.shareXFiles(XFile(tempPath.),
      //     text: 'تمت عملية الدفع بنجاح', subject: 'فاتورة دفع');
    } else {}

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
      // Background color similar to the screenshot
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.sp),
            // Padding around the entire content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "فاتورة الحجز",
                  style:
                      TextStyles.cairo_18_bold.copyWith(color: appColors.black),
                ),
                verticalSpace(5.h),
                Text(
                  getTimeDate(DateTime.now().toString()),
                  // Current date, as in the screenshot
                  style: TextStyles.cairo_14_regular
                      .copyWith(color: appColors.grey),
                ),
                verticalSpace(20.h),
                _buildInfoSection(),
                // Custom method to build the info section
                // verticalSpace(20.h),
                // _buildToSection(), // Custom method to build the "To" section
                verticalSpace(20.h),
                _buildDetailsSection(),
                // Custom method to build the details section
                verticalSpace(30.h),
                const Divider(color: appColors.grey5, thickness: 0.3),
                verticalSpace(10.h),
                _buildInvoiceTotal(context),
                // Custom method to build the total and actions section
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
            // Shadow color
            spreadRadius: 3,
            // Spread radius
            blurRadius: 10,
            // Blur radius
            offset: const Offset(0, 3), // Offset in x and y direction
          ),
        ],
        shape: RoundedRectangleBorder(
          // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),

          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoColumn('الرقم المرجعي',
              'Invoice#${data.data!.serviceRequest!.id.toString()}'),
          _buildInfoColumn('الرقم الضريبي', '3021550606'),
          // Static Tax ID as an example
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
            // Shadow color
            spreadRadius: 3,
            // Spread radius
            blurRadius: 10,
            // Blur radius
            offset: const Offset(0, 3), // Offset in x and y direction
          ),
        ],
        shape: RoundedRectangleBorder(
          // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),

          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      child: Column(
        children: [
          _buildDetailsHeaderRow(), // Custom method for the header row
          const Divider(color: appColors.grey5, thickness: 0.3),
          verticalSpace(10.h),
          _buildDetailsRow('اسم الخدمة',
              '${data.data!.serviceRequest!.price} ريال', appColors.black),
          verticalSpace(10.h),
          _buildDetailsRow('مستوى الطلب',
              data.data!.serviceRequest!.priority!.title!, appColors.black),
          verticalSpace(10.h),
          _buildDetailsRow('وقت الشراء', getTimeDate(DateTime.now().toString()),
              appColors.black),
          verticalSpace(10.h),
          _buildDetailsRow('حالة الطلب', "تم الدفع", appColors.green),
          verticalSpace(10.h),
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
          style: TextStyles.cairo_14_bold
              .copyWith(color: appColors.primaryColorYellow),
        ),
      ],
    );
  }

  Widget _buildDetailsRow(String description, String price, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          description,
          style: TextStyles.cairo_14_regular.copyWith(color: appColors.black),
        ),
        Text(
          price,
          style: TextStyles.cairo_14_regular.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildInvoiceTotal(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailsRow('الرسوم', '${data.data!.serviceRequest!.price} ريال',
            appColors.black),
        verticalSpace(10.h),
        _buildDetailsRow('الضرائب', '15%', appColors.black),
        const Text("*السعر شامل ضريبة القيمة المضاف"),
        verticalSpace(10.h),
        const Divider(color: appColors.grey5, thickness: 0.3),
        verticalSpace(10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'المجموع الكلي',
              style: TextStyles.cairo_16_bold
                  .copyWith(color: appColors.primaryColorYellow),
            ),
            Text(
              '${data.data!.serviceRequest!.price} ريال',
              style:
                  TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
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
                context.pushNamed(Routes.myServices);
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
