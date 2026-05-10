import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:yamtaz/core/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/repo/ymtaz_elite_repo.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';
import 'package:yamtaz/core/router/routes.dart';

import '../../../core/constants/assets.dart';
import '../../../core/widgets/audio_player_widget.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';

import '../../layout/account/logic/my_account_cubit.dart';
import '../../../core/widgets/users_images.dart';
import 'consultants_list_screen.dart';
import 'rejection_reason_screen.dart';
import 'elite_repricing_request_screen.dart';
import '../../../../core/helpers/file_helper.dart';
import '../../advisory_window/presentation/video_call/video_call_lobby_screen.dart';
import '../../../core/widgets/app_attachment_tile.dart';
import 'elite_price_offer_screen.dart';
import 'package:yamtaz/feature/advisory_window/logic/advisory_cubit.dart';


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
    // When tab changes, setState to trigger rebuild if needed
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  TypesImportance _getSafeOffer() {
    if (widget.request.offers?.reservationType?.typesImportance?.isNotEmpty == true) {
      return widget.request.offers!.reservationType!.typesImportance!.first;
    }
    final totalPrice = (num.tryParse(widget.request.offers?.advisoryServiceSubPrice?.toString() ?? '0') ?? 0) +
                       (num.tryParse(widget.request.offers?.serviceSubPrice?.toString() ?? '0') ?? 0) +
                       (num.tryParse(widget.request.offers?.reservationPrice?.toString() ?? '0') ?? 0);
    return TypesImportance(
      id: widget.request.offers?.id,
      price: totalPrice.toInt(),
    );
  }

  String _getFileType(String? filePath) {
    if (filePath == null || filePath.isEmpty) return '';
    final resolved = FileHelper.resolveUrl(filePath);
    final fileName = resolved.split('/').last.split('?').first.toLowerCase();
    
    if (fileName.endsWith('.jpg') || 
        fileName.endsWith('.jpeg') || 
        fileName.endsWith('.png') || 
        fileName.endsWith('.gif') || 
        fileName.endsWith('.webp') ||
        fileName.endsWith('.heic') ||
        fileName.endsWith('.heif')) return 'image';
        
    if (fileName.endsWith('.pdf')) return 'pdf';
    
    if (fileName.endsWith('.mp3') || 
        fileName.endsWith('.wav') || 
        fileName.endsWith('.m4a') || 
        fileName.endsWith('.amr') || 
        fileName.endsWith('.aac') ||
        fileName.endsWith('.ogg') ||
        fileName.endsWith('.audio')) return 'audio';
        
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
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image, color: Colors.white, size: 50),
                    SizedBox(height: 10),
                    Text("الصورة غير متاحة", style: TextStyle(color: Colors.white, fontFamily: 'Cairo')),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.maybePop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openPdf(String pdfUrl) async {
    // Standardize URL
    if (pdfUrl.contains('ymtaz.sa') && !pdfUrl.contains('api.ymtaz.sa')) {
      pdfUrl = pdfUrl.replaceFirst('ymtaz.sa', 'api.ymtaz.sa');
    }
    pdfUrl = pdfUrl.replaceFirst('http://', 'https://');
    
    await FileHelper.openFile(context, pdfUrl, title: "ملف الرد");
  }

  Future<void> _startVideoCall() async {
    final offerId = widget.request.offers?.id;
    if (offerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("عذراً، لا يوجد معرف مكالمة متاح حالياً")),
      );
      return;
    }

    final channelName = "Ymtaz";
    context.read<YmtazEliteCubit>().getAgoraToken(channelName);
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<YmtazEliteCubit, YmtazEliteState>(
        listener: (context, state) {
          if (state is YmtazEliteOfferApprovalError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: appColors.red,
              ),
            );
          } else if (state is YmtazEliteAgoraTokenSuccess) {
            // Navigate to Video Call Lobby (same as Advisory window does)
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VideoCallLobbyScreen(
                  durationMinutes: 30, // Or get from offer if available
                  date: widget.request.offers?.reservationDate != null ? DateFormat('yyyy/MM/dd').format(widget.request.offers!.reservationDate!) : "لا يوجد تاريخ",
                  time: widget.request.offers?.reservationFromTime ?? "",
                  channelName: "Ymtaz",
                ),
              ),
            );
          } else if (state is YmtazEliteAgoraTokenError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("خطأ في جلب التوكن: ${state.message}")),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFFBFBFB),
          appBar: buildBlurredAppBar(context, widget.request.serviceTitle ?? widget.request.eliteServiceCategory?.name ?? "تفاصيل الطلب"),
          body: Column(
            children: [
              // Custom Tabs (Pill Style)
              Container(
                margin: EdgeInsets.all(20.w),
                padding: EdgeInsets.all(4.w),
                height: 54.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: TabBar(
                  controller: _tabController,
                  dividerColor: Colors.transparent,
                  labelColor: const Color(0xFF8B7355),
                  unselectedLabelColor: const Color(0xFFB4B4B4),
                  labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: const Color(0xFFFAF6E9),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  tabs: const [
                    Tab(text: "تفاصيل الطلب"),
                    Tab(text: "تفاصيل الرد"),
                  ],
                ),
              ),

              // Stepper and Divider
              if (_tabController.index == 0) ...[
                _buildStepper(),
                verticalSpace(20.h),
              ],

              // Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildDetailsTab(),
                    _buildReplyTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildFileWidgetUI(FileElement file) {
    if (file.file == null) return const SizedBox.shrink();
    
    final fileType = _getFileType(file.file);
    final filePath = FileHelper.resolveUrl(file.file ?? '');

    final isAudio = fileType == 'audio' || (file.isVoice == 1 && fileType != 'image' && fileType != 'pdf');

    if (isAudio) {
      return Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFD6DBDE).withOpacity(0.5),
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: AudioPlayerWidget(
          audioUrl: filePath,
          backgroundColor: Colors.transparent,
          activeWaveColor: const Color(0xFF0F2D37),
          inactiveWaveColor: const Color(0xFF0F2D37).withOpacity(0.2),
          playButtonColor: const Color(0xFF0F2D37),
          indicatorColor: Colors.black87,
        ),
      );
    }

    return AppAttachmentTile(
      url: filePath,
      title: file.file?.split('/').last ?? "ملف المرفق",
    );
  }

  Widget _buildStepper() {
    int currentStep = 1; // 1 = قيد الانتظار, 2 = قيد الدراسة, 3 = مكتملة
    if (widget.request.status == "قيد الدراسة") {
      currentStep = 2;
    } else if (widget.request.status == "مكتملة" || widget.request.status == "مكتمل") {
      currentStep = 3;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 2, child: _buildStepPoint(currentStep >= 1, "قيد الانتظار")),
              _buildStepLine(currentStep >= 2),
              Expanded(flex: 2, child: _buildStepPoint(currentStep >= 2, "قيد الدراسة")),
              _buildStepLine(currentStep >= 3),
              Expanded(flex: 2, child: _buildStepPoint(currentStep >= 3, "مكتملة")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepPoint(bool isActive, String label) {
    return Column(
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFD4AF37) : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? const Color(0xFFD4AF37) : Colors.grey[200]!,
              width: 2,
            ),
          ),
          child: isActive 
              ? Icon(Icons.check, size: 14.sp, color: Colors.white)
              : null,
        ),
        verticalSpace(8.h),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: isActive ? const Color(0xFFD4AF37) : const Color(0xFFB4B4B4),
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
          ),
        ),
      ],
    );
  }

  Widget _buildStepCircle(bool reached, bool subActive, {bool isEnd = false}) {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        color: subActive ? const Color(0xFFD4AF37) : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: subActive ? const Color(0xFFD4AF37) : Colors.grey[200]!,
          width: 2,
        ),
      ),
      child: subActive 
          ? Icon(Icons.check, size: 14.sp, color: Colors.white)
          : null,
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2.h,
        color: isActive ? const Color(0xFFD4AF37) : Colors.grey[200],
      ),
    );
  }

  Widget _buildStepText(String text, bool isActive) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: isActive ? const Color(0xFFD4AF37) : const Color(0xFFB4B4B4),
        fontSize: 11.sp, // Reduced slightly to avoid overflow
        fontWeight: FontWeight.bold,
        fontFamily: 'Cairo',
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          _buildServicePriceBox(),
          verticalSpace(20.h),
          _buildAdvisoryTeamBox(),
          verticalSpace(20.h),
          _buildRequestDateBox(),
          verticalSpace(20.h),
          _buildCaseDetailsBox(),
          verticalSpace(20.h),
          if (widget.request.files?.isNotEmpty ?? false) ...[
            ...widget.request.files!.where((f) => (f.isReply ?? 0) != 1).map((file) => _buildFileWidgetUI(file)),
          ],
          verticalSpace(20.h),
        ],
      ),
    );
  }

  Widget _buildServicePriceBox() {
    if (widget.request.offers == null) return const SizedBox.shrink();
    
    final totalPrice = (num.tryParse(widget.request.offers?.advisoryServiceSubPrice?.toString() ?? '0') ?? 0) +
                       (num.tryParse(widget.request.offers?.serviceSubPrice?.toString() ?? '0') ?? 0) +
                       (num.tryParse(widget.request.offers?.reservationPrice?.toString() ?? '0') ?? 0);
    
    final serviceName = widget.request.serviceTitle ?? widget.request.eliteServiceCategory?.name ?? "طلب خدمة النخبة";

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.elitePriceOffer,
          arguments: {
            'request': widget.request,
            'offer': _getSafeOffer(),
          },
        );
      },
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.2), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD4AF37).withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF6E9),
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Icon(Icons.assignment_outlined, color: const Color(0xFFD4AF37), size: 28.sp),
            ),
            horizontalSpace(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "عرض التسعير المقترح",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[500],
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  verticalSpace(2.h),
                  Text(
                    serviceName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F2D37),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      "$totalPrice",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFFD4AF37),
                        fontFamily: 'Cairo',
                      ),
                    ),
                    horizontalSpace(4.w),
                    Text(
                      "ريال",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFD4AF37),
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOfferOptionsBottomSheet() {
    final cubit = context.read<YmtazEliteCubit>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (innerContext) => BlocProvider.value(
        value: cubit,
        child: Container(
          padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 40.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              verticalSpace(30.h),
              Text(
                "اتخاذ إجراء بشأن التسعير",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2D37),
                  fontFamily: 'Cairo',
                ),
              ),
              verticalSpace(12.h),
              Text(
                "اختر الإجراء المناسب للعرض المقدم من فريق النخبة الاستشاري",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                  fontFamily: 'Cairo',
                  height: 1.5,
                ),
              ),
              verticalSpace(32.h),
              _buildOptionButton(
                label: "قبول",
                icon: Icons.check_circle_rounded,
                color: const Color(0xFFD4AF37),
                onTap: () {
                  Navigator.pop(innerContext);
                  Navigator.pushNamed(
                    context,
                    Routes.elitePayment,
                    arguments: {
                      'request': widget.request,
                      'offer': _getSafeOffer(),
                    },
                  );
                },
              ),
              verticalSpace(16.h),
              _buildOptionButton(
                label: "تجاهل",
                icon: Icons.close_rounded,
                color: const Color(0xFFE54560),
                showArrow: false,
                onTap: () {
                   Navigator.pop(innerContext);
                   _showIgnoreMenu(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showIgnoreMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (innerContext) => Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            verticalSpace(24.h),
            Text(
              "تجاهل العرض",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
                color: const Color(0xFF0F2D37),
              ),
            ),
            verticalSpace(24.h),
            _buildActionOption(
              context,
              label: "طلب إعادة تسعير",
              icon: CupertinoIcons.refresh_thick,
              color: const Color(0xFFD4AF37),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  Routes.eliteRepricingRequest,
                  arguments: {
                    'request': widget.request,
                    'offer': _getSafeOffer(),
                  },
                );
              },
            ),
            verticalSpace(12.h),
            _buildActionOption(
              context,
              label: "رفض العرض نهائياً",
              icon: CupertinoIcons.xmark_circle,
              color: const Color(0xFFE54560),
              onTap: () {
                Navigator.pop(context);
                _showRejectionDialog();
              },
            ),
            verticalSpace(24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildActionOption(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(CupertinoIcons.chevron_left, size: 14.sp, color: Colors.grey),
            const Spacer(),
            Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Cairo',
                color: const Color(0xFF0F2D37),
                fontWeight: FontWeight.w600,
              ),
            ),
            horizontalSpace(12.w),
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton({
    required String label, 
    required IconData icon, 
    required Color color, 
    required VoidCallback onTap,
    bool showArrow = true,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withOpacity(0.12), width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22.sp),
            ),
            horizontalSpace(16.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            if (showArrow)
              Icon(Icons.arrow_forward_ios, size: 14.sp, color: color.withOpacity(0.4)),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvisoryTeamBox() {
    final typesImportance = widget.request.offers?.reservationType?.typesImportance ?? [];
    final consultants = typesImportance.where((ti) => ti.lawyer != null).map((ti) => ti.lawyer!).toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            appColors.primaryColorYellow.withOpacity(0.5),
            appColors.lightYellow10,
            appColors.lightYellow10.withOpacity(0.8),
            appColors.primaryColorYellow.withOpacity(0.2),
          ],
          stops: const [0.0, 0.2, 0.4, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${consultants.length}+",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F2D37),
                        fontFamily: 'Cairo',
                      ),
                    ),
                    Text(
                      "فريقك الاستشاري",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF0F2D37),
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
                if (widget.request.offers?.reservationFromTime != null)
                   _buildTeamIcon(
                    Icons.videocam_rounded,
                    isActive: true,
                    onTap: _startVideoCall,
                  ),
                if (consultants.isNotEmpty)
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConsultantsListScreen(lawyers: consultants)),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'عرض الكل',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF0F2D37),
                          ),
                        ),
                        horizontalSpace(5.w),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14.sp,
                          color: const Color(0xFF0F2D37),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          verticalSpace(12.h),
          if (consultants.isNotEmpty)
            Container(
              height: 45.h,
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: UsersImagesWidget(
                imageList: consultants.map((c) => FileHelper.resolveUrl(c.image ?? "https://ymtaz.sa/uploads/person.png")).toList(),
                totalCount: consultants.length,
                imageRadius: 16.w,
                imageCount: 9,
                imageBorderWidth: 1.5.w,
                overlapDistance: 28.w,
              ),
            )
          else
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                "نخبة من المستشارين المتخصصين لمتابعة طلبك",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFF0F2D37).withOpacity(0.6),
                  fontFamily: 'Cairo',
                ),
              ),
            ),
          verticalSpace(15.h),
        ],
      ),
    );
  }

  Widget _buildActionButton({required String label, required Color color, required VoidCallback onTap}) {
    return CupertinoButton(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      color: color,
      borderRadius: BorderRadius.circular(12.r),
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  void _showRejectionDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RejectionReasonScreen(offerId: widget.request.offers!.id.toString()),
      ),
    );
  }

  Widget _buildTeamIcon(IconData icon, {VoidCallback? onTap, bool isActive = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFD4AF37).withOpacity(0.1) : const Color(0xFFFAF6E9),
          shape: BoxShape.circle,
          border: isActive ? Border.all(color: const Color(0xFFD4AF37), width: 1) : null,
        ),
        child: Icon(
          icon, 
          color: isActive ? const Color(0xFFD4AF37) : const Color(0xFFD4AF37).withOpacity(0.5), 
          size: 18.sp
        ),
      ),
    );
  }

  Widget _buildRequestDateBox() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF062129),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "موعد الطلب",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          verticalSpace(16.h),
          // Dashed Divider
          Row(
            children: List.generate(20, (index) => Expanded(
              child: Container(
                height: 1,
                color: index % 2 == 0 ? Colors.white.withOpacity(0.1) : Colors.transparent,
              ),
            )),
          ),
          verticalSpace(16.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _buildAlarmIcon(),
                    horizontalSpace(8.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "موعد الطلب",
                            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 10.sp, fontFamily: 'Cairo'),
                          ),
                          Text(
                            widget.request.createdAt != null 
                              ? "${getDate(widget.request.createdAt!)}  ${getTime(widget.request.createdAt!)}"
                              : "--",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(10.w),
              Expanded(
                child: Row(
                  children: [
                    _buildAlarmIcon(),
                    horizontalSpace(8.w),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "موعد الرد",
                            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 10.sp, fontFamily: 'Cairo'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.request.offers?.createdAt != null
                                ? "${getDate(widget.request.offers!.createdAt!)}  ${getTime(widget.request.offers!.createdAt!)}"
                                : "--",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlarmIcon() {
    return Container(
      width: 38.w,
      height: 38.w,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.alarm, color: const Color(0xFFD4AF37), size: 18.sp),
    );
  }

  Widget _buildCaseDetailsBox() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFF5F5F5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Label (Pill)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF6E9),
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.category_rounded, color: const Color(0xFFD4AF37), size: 14.sp),
                    horizontalSpace(6.w),
                    Text(
                      widget.request.eliteServiceCategory?.name ?? "طلب نخبة",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFD4AF37),
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ],
                ),
              ),
              // Icon Badge
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F2D37).withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.gavel_rounded, color: const Color(0xFF0F2D37), size: 18.sp),
              ),
            ],
          ),
          verticalSpace(20.h),
          
          // Request Title
          Text(
            widget.request.serviceTitle ?? "بدون عنوان",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0F2D37),
              fontFamily: 'Cairo',
              height: 1.4,
            ),
          ),
          
          verticalSpace(16.h),
          const Divider(height: 1),
          verticalSpace(16.h),
          
          // Description Header
          Row(
            children: [
              Icon(Icons.notes_rounded, size: 16.sp, color: const Color(0xFF8B7355)),
              horizontalSpace(8.w),
              Text(
                "وصف الطلب",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF8B7355),
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          verticalSpace(12.h),
          
          // Description Content
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFBFBFB),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: const Color(0xFFF0F0F0)),
            ),
            child: Text(
              widget.request.description ?? "لا يوجد وصف متاح لهذا الطلب",
              textAlign: TextAlign.justify,
              textDirection: ui.TextDirection.rtl,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF4A4A4A),
                fontFamily: 'Cairo',
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyTab() {
    String replyDetailsText = widget.request.offers?.advisoryServiceSub?.description ?? '';
    
    if (widget.request.status == "pending-pricing" || 
        (replyDetailsText.isEmpty && (widget.request.status == "قيد الدراسة" || widget.request.status == "قيد الانتظار"))) {
      replyDetailsText = "الطلب قيد التسعير الان ، وسيتم الرد عليك قريبا من قبل فريق النخبة الاستشاري";
    } else if (widget.request.offers != null && widget.request.status != "pending-pricing") {
      replyDetailsText = replyDetailsText.isEmpty 
          ? "تم الرد على طلبك بإرسال عرض أسعار وتحديد فريق المستشارين.\nيمكنك مراجعة تفاصيل التسعير وفريقك الاستشاري في تبويب (تفاصيل الطلب) أو من خلال اتخاذ إجراء." 
          : replyDetailsText;
    } else if (replyDetailsText.isEmpty) {
      replyDetailsText = "لا يوجد رد حتى الآن";
    }

    // Collect reply files (isReply == 1)
    final replyFiles = widget.request.files?.where((f) => (f.isReply ?? 0) == 1).toList() ?? [];
    final replyAudioFiles = replyFiles.where((f) {
      final t = _getFileType(f.file);
      return t == 'audio' || ((f.isVoice ?? 0) == 1 && t != 'image' && t != 'pdf');
    }).toList();
    final replyDocFiles = replyFiles.where((f) {
      final t = _getFileType(f.file);
      return !(t == 'audio' || ((f.isVoice ?? 0) == 1 && t != 'image' && t != 'pdf'));
    }).toList();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          // Reply Text Card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.02),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "حالة الطلب",
                      style: TextStyle(fontSize: 11.sp, color: const Color(0xFFB4B4B4), fontFamily: 'Cairo'),
                    ),
                    _buildStatusTag(widget.request.status ?? "قيد الدراسة"),
                  ],
                ),
                verticalSpace(12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "تاريخ الرد",
                      style: TextStyle(fontSize: 11.sp, color: const Color(0xFFB4B4B4), fontFamily: 'Cairo'),
                    ),
                    Text(
                      widget.request.offers?.createdAt != null 
                        ? "${getDate(widget.request.offers!.createdAt!)}  ${getTime(widget.request.offers!.createdAt!)}"
                        : "${getDate(widget.request.createdAt)}  ${getTime(widget.request.createdAt!)}",
                      style: TextStyle(fontSize: 12.sp, color: const Color(0xFF0F2D37), fontWeight: FontWeight.bold, fontFamily: 'Cairo'),
                    ),
                  ],
                ),
                verticalSpace(16.h),
                Divider(color: Colors.grey[100], thickness: 1),
                verticalSpace(16.h),
                Text(
                  "الرد",
                  style: TextStyle(fontSize: 11.sp, color: const Color(0xFFB4B4B4), fontFamily: 'Cairo'),
                ),
                verticalSpace(12.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    replyDetailsText,
                    textAlign: TextAlign.justify,
                    textDirection: ui.TextDirection.rtl,
                    style: TextStyle(fontSize: 13.sp, color: const Color(0xFF0F2D37), height: 1.8, fontFamily: 'Cairo'),
                  ),
                ),
              ],
            ),
          ),

          // Real voice reply files
          if (replyAudioFiles.isNotEmpty) ...[
            verticalSpace(20.h),
            ...replyAudioFiles.map((f) => _buildReplyAudioPlayer(f.file ?? '')),
          ],

          // Real PDF/image reply files
          if (replyDocFiles.isNotEmpty) ...[
            verticalSpace(20.h),
            ...replyDocFiles.map((f) => _buildReplyFileCard(f)),
          ],

          verticalSpace(20.h),
        ],
      ),
    );
  }

  Widget _buildReplyAudioPlayer(String audioUrl) {
    if (audioUrl.isEmpty) return const SizedBox.shrink();

    // Standardize URL to current API domain
    if (audioUrl.contains('ymtaz.sa') && !audioUrl.contains('api.ymtaz.sa')) {
      audioUrl = audioUrl.replaceFirst('ymtaz.sa', 'api.ymtaz.sa');
    }
    
    // Ensure https
    audioUrl = audioUrl.replaceFirst('http://', 'https://');
    
    // Handle relative paths
    if (!audioUrl.startsWith('http')) {
      if (audioUrl.startsWith('/')) {
        audioUrl = 'https://api.ymtaz.sa$audioUrl';
      } else {
        audioUrl = 'https://api.ymtaz.sa/$audioUrl';
      }
    }
    
    audioUrl = audioUrl.trim();
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFD6DBDE).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: AudioPlayerWidget(
        audioUrl: audioUrl,
        backgroundColor: Colors.transparent,
        activeWaveColor: const Color(0xFF0F2D37),
        inactiveWaveColor: const Color(0xFF0F2D37).withOpacity(0.2),
        playButtonColor: const Color(0xFF0F2D37),
        indicatorColor: Colors.black87,
      ),
    );
  }

  Widget _buildReplyFileCard(FileElement file) {
    final fileType = _getFileType(file.file);
    final filePath = FileHelper.resolveUrl(file.file ?? '');
    final fileName = filePath.split('/').last.split('?').first;

    return GestureDetector(
      onTap: () {
        if (fileType == 'image') {
          _showFullScreenImage(filePath);
        } else if (fileType == 'pdf') {
          _openPdf(filePath);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              fileType == 'image' ? Icons.image_outlined : Icons.picture_as_pdf,
              color: fileType == 'image' ? Colors.blue[700] : Colors.red[700],
              size: 28.sp,
            ),
            horizontalSpace(12.w),
            Expanded(
              child: Text(
                fileName.isNotEmpty ? fileName : "مرفق الرد",
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2D37),
                  fontFamily: 'Cairo',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(Icons.file_download_outlined, color: Colors.grey[400], size: 24.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTag(String status) {
    Color textColor;
    Color bgColor;
    String displayStatus = getEliteRequestStatusText(status);

    if (status == "pending-pricing" || 
        status == "pending-pricing-change" || 
        status == "pending-pricing-approval" || 
        status == "pending-payment" ||
        status == "قيد الدراسة" || 
        status == "قيد الإنتظار") {
      textColor = const Color(0xFF2DAFAF);
      bgColor = const Color(0xFFE6F7F7);
    } else if (status == "approved" || 
               status == "accepted" || 
               status == "completed" || 
               status == "مكتملة" || 
               status == "مكتمل") {
      textColor = const Color(0xFF4CAF50);
      bgColor = const Color(0xFFE8F5E9);
    } else {
      textColor = const Color(0xFF2DAFAF);
      bgColor = const Color(0xFFE6F7F7);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        displayStatus,
        style: TextStyle(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Cairo',
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
