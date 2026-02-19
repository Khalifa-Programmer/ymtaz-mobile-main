import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yamtaz/feature/ymtaz_elite/presentation/elite_lawyer_section/pricing_screen.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/audio_player_widget.dart';
import '../../data/model/elite_pricing_requests_model.dart'; // Updated import
import '../../../../core/widgets/custom_button.dart';
import '../../logic/ymtaz_elite_cubit.dart';
import '../../../../core/widgets/app_bar.dart';
import 'package:photo_view/photo_view.dart';  // Add this import
import 'package:url_launcher/url_launcher.dart';  // Add this import

class EliteClientOrderScreen extends StatelessWidget {
  final YmtazEliteCubit cubit;
  
  const EliteClientOrderScreen({
    super.key,
    required this.cubit,
  });

  String _getFileType(String? filePath) {
    if (filePath == null) return '';
    final extension = filePath.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif'].contains(extension)) return 'image';
    if (extension == 'pdf') return 'pdf';
    if (['mp3', 'wav', 'm4a'].contains(extension)) return 'audio';
    return 'other';
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        child: Stack(
          children: [
            PhotoView(
              imageProvider: CachedNetworkImageProvider(imageUrl),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAudioPlayer(BuildContext context, String audioUrl) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  'تشغيل الملف الصوتي',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            AudioPlayerWidget(
              audioUrl: audioUrl,
              backgroundColor: appColors.white,
              activeWaveColor: appColors.primaryColorYellow,
              playButtonColor: appColors.primaryColorYellow,
              indicatorColor: appColors.blue100.withOpacity(0.7),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Future<void> _openPdf(String pdfUrl) async {
    if (await canLaunchUrl(Uri.parse(pdfUrl))) {
      await launchUrl(Uri.parse(pdfUrl));
    }
  }

  Widget _buildFileWidget(BuildContext context, FileElement file) {  // Added context parameter
    final fileType = _getFileType(file.file);
    final filePath = file.file ?? '';
    final fileName = filePath.split('/').last;  // Simplified filename extraction

    return GestureDetector(
      onTap: () {
        switch (fileType) {
          case 'image':
            _showFullScreenImage(context, filePath);  // Pass context from parameter
            break;
          case 'audio':
            _showAudioPlayer(context, filePath);  // Pass context from parameter
            break;
          case 'pdf':
            _openPdf(filePath);
            break;
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
        ),
        child: Row(
          children: [
            _buildFileTypeIcon(fileType),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName,  // Using simplified filename
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'اضغط للعرض',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileTypeIcon(String fileType) {
    switch (fileType) {
      case 'image':
        return Icon(Icons.image, size: 24.sp, color: Colors.blue);
      case 'audio':
        return Icon(Icons.audiotrack, size: 24.sp, color: Colors.green);
      case 'pdf':
        return Icon(Icons.picture_as_pdf, size: 24.sp, color: Colors.red);
      default:
        return Icon(Icons.attachment, size: 24.sp, color: Colors.grey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = cubit.selectedRequest;
    if (request == null) {
      return const Scaffold(
        body: Center(child: Text('لا يوجد طلب محدد')),
      );
    }

    return Scaffold(
      appBar: buildBlurredAppBar(context, 'تفاصيل الطلب'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            request.eliteServiceCategory?.name ?? '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          request.createdAt ?? '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'الوصف',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      request.description ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    if (request.files?.isNotEmpty == true) ...[
                      SizedBox(height: 16.h),
                      Text(
                        'المرفقات',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ...request.files!.map((file) => _buildFileWidget(context, file)),  // Pass context here
                    ],
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              CustomButton(title: 'اضافة تسعير', onPress: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocProvider.value(
                    value: cubit,
                    child: PricingScreen(),
                  );
                }));
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddServiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Container(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildServiceOption('موعد', Icons.calendar_today),
                  _buildServiceOption('استشارة', Icons.chat_bubble_outline),
                  _buildServiceOption('خدمة', Icons.grid_view),
                ],
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text('نوع الاستشارة'),
                    items: [],
                    onChanged: (value) {},
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Text(
                      'السعر',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '3000 ريال',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFFD4AF37),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  minimumSize: Size(double.infinity, 48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'إضافة',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceOption(String title, IconData icon) {
    return Container(
      width: 80.w,
      height: 80.w,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24.sp, color: Colors.grey),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
