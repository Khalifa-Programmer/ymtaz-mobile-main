import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/repo/ymtaz_elite_repo.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';
import '../../../core/constants/assets.dart';
import '../../../core/widgets/audio_player_widget.dart';
import '../../../core/widgets/app_bar.dart';
import '../../../core/widgets/spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import '../../advisory_window/presentation/call_screen.dart';
import '../../../core/network/local/cache_helper.dart';
import '../../layout/account/logic/my_account_cubit.dart';
import '../../../core/widgets/users_images.dart';
import 'consultants_list_screen.dart';
import 'rejection_reason_screen.dart';

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
                onPressed: () => Navigator.pop(context),
              ),
            ),
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

  Future<void> _startVideoCall() async {
    final offerId = widget.request.offers?.id;
    if (offerId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("عذراً، لا يوجد معرف مكالمة متاح حالياً")),
      );
      return;
    }

    try {
      var userType = CacheHelper.getData(key: 'userType');
      final myAccountCubit = getit<MyAccountCubit>();
      
      // Initialize Stream Video
      StreamVideo.reset();
      
      if (userType == 'client') {
        final account = myAccountCubit.clientProfile?.data?.account;
        if (account == null) return;
        
        StreamVideo(
          'd3cgunkh7jrg',
          user: User.regular(
            userId: account.streamioId.toString(),
            name: account.name ?? '',
          ),
          userToken: account.streamioToken ?? '',
        );
      } else {
        final account = myAccountCubit.userDataResponse?.data?.account;
        if (account == null) return;
        
        StreamVideo(
          'd3cgunkh7jrg',
          user: User.regular(
            userId: account.streamioId.toString(),
            name: account.name ?? '',
          ),
          userToken: account.streamioToken ?? '',
        );
      }

      var call = StreamVideo.instance.makeCall(
        callType: StreamCallType.custom("default"),
        id: "elite_$offerId", // Using offer ID as unique call ID
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CallScreen(call: call),
        ),
      );

      await call.getOrCreate();
    } catch (e) {
      debugPrint('Error joining or creating elite call: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ في بدء المكالمة: $e")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<YmtazEliteCubit, YmtazEliteState>(
        listener: (context, state) {
          if (state is YmtazEliteOfferApprovalSuccess) {
            launchUrl(Uri.parse(state.paymentUrl), mode: LaunchMode.externalApplication);
          } else if (state is YmtazEliteOfferApprovalError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: appColors.red,
              ),
            );
          }
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFFBFBFB),
          appBar: buildBlurredAppBar(context, "تفاصيل الطلب"),
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
    final fileType = _getFileType(file.file);
    final filePath = (file.file ?? '').replaceAll('https://ymtaz.sa/', 'https://api.ymtaz.sa/');

    if (fileType == 'audio' || (file.isVoice == 1 && fileType != 'image' && fileType != 'pdf')) {
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.picture_as_pdf, color: Colors.red[700], size: 28.sp),
            horizontalSpace(12.w),
            Expanded(
              child: Text(
                file.file?.split('/').last ?? "ملف القضية", 
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2D37),
                  fontFamily: 'Cairo',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            horizontalSpace(8.w),
            Icon(Icons.file_download_outlined, color: Colors.grey[400], size: 24.sp),
          ],
        ),
      ),
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

  Widget _buildAdvisoryTeamBox() {
    final typesImportance = widget.request.offers?.reservationType?.typesImportance ?? [];
    final consultants = typesImportance.where((ti) => ti.lawyer != null).map((ti) => ti.lawyer!).toList();
    final totalPrice = (widget.request.offers?.advisoryServiceSubPrice ?? 0) +
                       (widget.request.offers?.serviceSubPrice ?? 0) +
                       (widget.request.offers?.reservationPrice ?? 0);

    return Container(
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
            children: [
              Text(
                "فريقك الاستشاري",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2D37),
                  fontFamily: 'Cairo',
                ),
              ),
              const Spacer(),
              if (totalPrice > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF6E9),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    "$totalPrice ريال",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD4AF37),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
            ],
          ),
          verticalSpace(16.h),
          
          if (consultants.isNotEmpty) ...[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConsultantsListScreen(lawyers: consultants)),
                );
              },
              child: Row(
                children: [
                   UsersImagesWidget(
                    imageList: consultants.map((c) => c.image ?? "https://api.ymtaz.sa/uploads/person.png").toList(),
                    totalCount: consultants.length,
                    imageRadius: 18.w,
                    imageCount: 5,
                    imageBorderWidth: 1.5.w,
                    overlapDistance: 25.w,
                  ),
                  horizontalSpace(10.w),
                  Text(
                    "(${consultants.length}) مستشار",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFFB4B4B4),
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey[400]),
                ],
              ),
            ),
            verticalSpace(20.h),
          ],

          if (widget.request.offers != null && (widget.request.status != "مكتمل" && widget.request.status != "مكتملة"))
             Row(
               children: [
                 Expanded(
                   child: _buildActionButton(
                     label: "قبول العرض",
                     color: const Color(0xFFD4AF37),
                     onTap: () => context.read<YmtazEliteCubit>().approveOffer(widget.request.offers!.id.toString(), "elite"),
                   ),
                 ),
                 horizontalSpace(12.w),
                 Expanded(
                   child: _buildActionButton(
                     label: "رفض العرض",
                     color: Colors.red[400]!,
                     onTap: () => _showRejectionDialog(),
                   ),
                 ),
               ],
             )
          else ...[
            Text(
              "خدمة نخبة",
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFFB4B4B4),
                fontFamily: 'Cairo',
              ),
            ),
            verticalSpace(8.h),
            Text(
              "تقديم حلول متنوعة وخطوات مدروسة لحل المشكلة بشكل شامل من قبل نخبة من المستشارين المتخصصين بأحدث التقنيات المتاحة",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFFB4B4B4),
                height: 1.6,
                fontFamily: 'Cairo',
              ),
            ),
          ],
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
          Text(
            widget.request.eliteServiceCategory?.name ?? "قضية جنائية",
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2D37),
              fontFamily: 'Cairo',
            ),
          ),
          verticalSpace(4.h),
          Text(
            "${getDate(widget.request.createdAt)}  ${getTime(widget.request.createdAt!)}",
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFFD4AF37),
              fontFamily: 'Cairo',
            ),
          ),
          verticalSpace(20.h),
          Divider(color: Colors.grey[50]),
          verticalSpace(10.h),
          Text(
            "الوصف",
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xFFB4B4B4),
              fontFamily: 'Cairo',
            ),
          ),
          verticalSpace(8.h),
          SizedBox(
            width: double.infinity,
            child: Text(
              widget.request.description ?? "",
              textAlign: TextAlign.justify,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFF0F2D37),
                height: 1.6,
                fontFamily: 'Cairo',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyTab() {
    String replyDetailsText = widget.request.offers?.advisoryServiceSub?.description ?? widget.request.description ?? '';
    if (replyDetailsText.isEmpty) replyDetailsText = "لا يوجد رد حتى الآن";

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
                    textDirection: TextDirection.rtl,
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

          // Approve Offer Button
          if (widget.request.offers != null &&
              (widget.request.status != "مكتمل" &&
                  widget.request.status != "مكتملة")) ...[
            Builder(builder: (context) {
              return BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      color: const Color(0xFFD4AF37),
                      onPressed: state is YmtazEliteOfferApprovalLoading
                          ? null
                          : () {
                              context.read<YmtazEliteCubit>().approveOffer(
                                    widget.request.offers!.id.toString(),
                                    "elite",
                                  );
                            },
                      child: state is YmtazEliteOfferApprovalLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "الموافقة على العرض والدفع",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  );
                },
              );
            }),
            verticalSpace(20.h),
          ],
        ],
      ),
    );
  }

  Widget _buildReplyAudioPlayer(String audioUrl) {
    audioUrl = audioUrl.replaceAll('https://ymtaz.sa/', 'https://api.ymtaz.sa/');
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
    final filePath = (file.file ?? '').replaceAll('https://ymtaz.sa/', 'https://api.ymtaz.sa/');
    final fileName = filePath.split('/').last;

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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
