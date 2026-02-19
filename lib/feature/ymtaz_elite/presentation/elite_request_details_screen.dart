import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/repo/ymtaz_elite_repo.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';
import '../../../core/widgets/audio_player_widget.dart';
import 'widgets/description_card_widget.dart';
import 'widgets/request_header_widget.dart';
import 'widgets/offer_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EliteRequestDetailsScreen extends StatefulWidget {
  final Request request;

  const EliteRequestDetailsScreen({super.key, required this.request});

  @override
  State<EliteRequestDetailsScreen> createState() =>
      _EliteRequestDetailsScreenState();
}

class _EliteRequestDetailsScreenState extends State<EliteRequestDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  String _getFileType(String? filePath) {
    if (filePath == null) return '';
    final extension = filePath.split('.').last.toLowerCase();
    if (['jpg', 'jpeg', 'png', 'gif'].contains(extension)) return 'image';
    if (extension == 'pdf') return 'pdf';
    if (['mp3', 'wav', 'm4a'].contains(extension)) return 'audio';
    return 'other';
  }

  void _showFullScreenImage(String imageUrl) {
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
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAudioPlayer(String audioUrl) {
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
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: AudioPlayerWidget(
            audioUrl:audioUrl,
            backgroundColor: appColors.white,
            activeWaveColor: appColors.primaryColorYellow,
            playButtonColor: appColors.primaryColorYellow,
            indicatorColor: appColors.blue100.withOpacity(0.7),
          ),),
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

  Widget _buildFileWidget(FileElement file) {
    final fileType = _getFileType(file.file);
    final filePath = file.file ?? '';
    final fileName = filePath.split('/').last;

    return GestureDetector(
      onTap: () {
        switch (fileType) {
          case 'image':
            _showFullScreenImage(filePath);
            break;
          case 'audio':
            _showAudioPlayer(filePath);
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
                    fileName,
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => YmtazEliteCubit(
        getit<YmtazEliteRepo>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تفاصيل الطلب',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: appColors.primaryColorYellow,
                unselectedLabelColor: Colors.grey,
                indicatorColor: appColors.primaryColorYellow,
                tabs: const [
                  Tab(text: 'تفاصيل الطلب'),
                  Tab(text: 'العروض'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDetailsTab(),
                  _buildOffersTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RequestHeaderWidget(request: widget.request),
          SizedBox(height: 16.h),
          DescriptionCardWidget(description: widget.request.description ?? ''),
          SizedBox(height: 16.h),
          if (widget.request.files?.isNotEmpty ?? false) ...[
            Text(
              'المرفقات',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            ...widget.request.files!.map((file) => _buildFileWidget(file)),
          ],
        ],
      ),
    );
  }

  Widget _buildOffersTab() {
    final offer = widget.request.offers;
    
    if (offer == null) {
      return Center(
        child: Text(
          'لا توجد عروض حالياً',
          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Service Offer
          if (offer.serviceSub != null)
            ServiceOfferWidget(
              serviceSub: offer.serviceSub!,
              price: offer.serviceSubPrice,
              offerId: offer.id.toString(),
              onReject: () {
                print('Rejecting service offer ${offer.id}');
              },
            ),

          // Consultation Offer
          if (offer.advisoryServiceSub != null)
            ConsultationOfferWidget(
              advisoryServiceSub: offer.advisoryServiceSub!,
              price: offer.advisoryServiceSubPrice,
              offerId: offer.id.toString(),
              onReject: () {
                print('Rejecting consultation offer ${offer.id}');
              },
            ),

          // Appointment Offer
          if (offer.reservationType != null)
            AppointmentOfferWidget(
              reservationType: offer.reservationType!,
              date: offer.reservationDate,
              fromTime: offer.reservationFromTime,
              toTime: offer.reservationToTime,
              price: offer.reservationPrice,
              offerId: offer.id.toString(),
              onReject: () {
                print('Rejecting appointment offer ${offer.id}');
              },
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
