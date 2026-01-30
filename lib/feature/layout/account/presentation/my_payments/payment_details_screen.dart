import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/feature/layout/account/data/models/my_payments_response.dart';

class PaymentDetailsScreen extends StatelessWidget {
  PaymentDetailsScreen({super.key, required this.payment}) {
    // Set full screen mode when screen is created
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  final Payment payment;
  final GlobalKey _globalKey = GlobalKey();

  Future<Uint8List?> _captureScreen() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> _generateAndSharePDF(String id) async {
    final pdf = pw.Document();
    final screenshotBytes = await _captureScreen();

    if (screenshotBytes != null) {
      final image = pw.MemoryImage(screenshotBytes);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(image),
            );
          },
        ),
      );

      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/payment_details-$id.pdf');
      await file.writeAsBytes(await pdf.save());

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'تفاصيل الدفع',
        subject: 'Payment Details-$id',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          "تفاصيل الدفع",
          style: TextStyle(
            color: appColors.black,
            fontSize: 16.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.share,
              color: appColors.black,
            ),
            onPressed: () =>
                _generateAndSharePDF(payment.transactionId.toString()),
          ),
        ],
      ),
      body: RepaintBoundary(
        key: _globalKey,
        child: Padding(
          padding: EdgeInsets.all(25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  AppAssets.mainLogo,
                  height: 70.h,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "التفاصيل",
                style: TextStyle(
                  color: appColors.grey,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(
                color: appColors.grey2,
                height: 0.5.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "اسم المنتج",
                    style: TextStyle(
                      color: appColors.grey15,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    "${payment.name}",
                    style: TextStyle(
                      color: appColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "تاريخ الشراء",
                    style: TextStyle(
                      color: appColors.grey15,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    getDate(payment.createdAt.toString()),
                    style: TextStyle(
                      color: appColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "وقت الشراء",
                    style: TextStyle(
                      color: appColors.grey15,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    "${getTime(payment.createdAt.toString())}",
                    style: TextStyle(
                      color: appColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 30.h,
              ),
              Text(
                "تفاصيل الدفع",
                style: TextStyle(
                  color: appColors.grey,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(
                color: appColors.grey2,
                height: 0.5.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "طريقة الدفع",
                    style: TextStyle(
                      color: appColors.grey15,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    "بطاقة ائتمان",
                    style: TextStyle(
                      color: appColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "حالة الدفع",
                    style: TextStyle(
                      color: appColors.grey15,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    payment.transactionComplete == 1 ? 'مدفوع' : 'غير مدفوع',
                    style: TextStyle(
                      color: payment.transactionComplete == 1
                          ? appColors.green
                          : appColors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "المبلغ",
                    style: TextStyle(
                      color: appColors.grey15,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    "${payment.price} ريال",
                    style: TextStyle(
                      color: appColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "الرسوم الضريبية",
                    style: TextStyle(
                      color: appColors.grey15,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    "السعر الإجمالي شامل الضريبة",
                    style: TextStyle(
                      color: appColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "الرقم الضريبي",
                    style: TextStyle(
                      color: appColors.grey15,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    "3021550606",
                    style: TextStyle(
                      color: appColors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "الإجمالي",
                style: TextStyle(
                  color: appColors.grey,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(
                color: appColors.grey2,
                height: 0.5.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "المبلغ الإجمالي",
                    style: TextStyle(
                      color: appColors.grey15,
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    "${payment.price} ريال",
                    style: TextStyle(
                      color: appColors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                textAlign: TextAlign.center,
                "لمزيد من المعلومات حول تفاصيل قيمة الخدمة ،اتصل بنا واستخدم الرقم المرجعي #${payment.transactionId}",
                style: TextStyle(
                  color: appColors.blue90,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
