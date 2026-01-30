import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/widgets/audio_player_widget.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../data/model/all_advirsory_response.dart';
import '../call_screen.dart';

class ViewOrderDetails extends StatelessWidget {
  const ViewOrderDetails(
      {super.key, required this.servicesRequirementsResponse});

  final Reservation servicesRequirementsResponse;

  void _openFileInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('تفاصيل الاستشارة',
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
        actions: [
          // Add AI Assistant button
          IconButton(
            icon: Icon(
              Icons.psychology,
              color: appColors.primaryColorYellow,
              size: 26.sp,
            ),
            onPressed: () {
              _showAIAssistantSheet(context);
            },
            tooltip: 'المساعد الذكي',
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.0.sp),
              margin: EdgeInsets.all(20.0.sp),
              width: MediaQuery.of(context).size.width,
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "تفاصيل الاستشارة",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: appColors.grey15,
                    ),
                  ),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.ticket,
                        color: appColors.primaryColorYellow,
                        size: 20.sp,
                      ),
                      horizontalSpace(10.w),
                      Text(
                        "نوع الاستشارة ",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      Text(
                        servicesRequirementsResponse.advisoryServicesSub!.name!,
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.blue100),
                      ),
                    ],
                  ),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.video_camera_solid,
                        color: appColors.primaryColorYellow,
                        size: 20.sp,
                      ),
                      horizontalSpace(10.w),
                      Text(
                        "نوع الوسيلة ",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      Text(
                        servicesRequirementsResponse
                                    .advisoryServicesSub!
                                    .generalCategory!
                                    .paymentCategoryType!
                                    .requiresAppointment ==
                                1
                            ? 'مرئية'
                            : 'مكتوبة',
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.blue100),
                      ),
                    ],
                  ),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.dollar,
                        color: appColors.primaryColorYellow,
                        size: 20.sp,
                      ),
                      horizontalSpace(10.w),
                      Text(
                        "السعر ",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      Text(
                        "${servicesRequirementsResponse.price ?? 0} ريال",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.blue100),
                      ),
                    ],
                  ),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      Icon(
                        Icons.label_important_outline_rounded,
                        color: appColors.primaryColorYellow,
                        size: 20.sp,
                      ),
                      horizontalSpace(10.w),
                      Text(
                        "مستوى الطلب",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      Text(
                        servicesRequirementsResponse.importance?.title ??
                            "مجاني",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.blue100),
                      ),
                    ],
                  ),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      Icon(
                        Icons.label_important_outline_rounded,
                        color: appColors.primaryColorYellow,
                        size: 20.sp,
                      ),
                      horizontalSpace(10.w),
                      Text(
                        "حالة الطلب",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      Text(
                        getStatusText(int.parse(
                            servicesRequirementsResponse.requestStatus!)),
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.blue100),
                      ),
                    ],
                  ),
                  verticalSpace(20.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: appColors.primaryColorYellow,
                        size: 20.sp,
                      ),
                      horizontalSpace(10.w),
                      Text(
                        "تاريخ الطلب",
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.grey15),
                      ),
                      const Spacer(),
                      Text(
                        getTimeDate(
                            servicesRequirementsResponse.createdAt.toString()),
                        style: TextStyles.cairo_12_semiBold
                            .copyWith(color: appColors.blue100),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0.sp),
              margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
              width: MediaQuery.of(context).size.width,
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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "تفاصيل الطلب",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: appColors.blue100,
                    ),
                  ),
                  verticalSpace(20.w),
                  const Text(
                    "الموضوع",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: appColors.grey15,
                    ),
                  ),
                  ReadMoreText(
                    servicesRequirementsResponse.description!,
                    trimCollapsedText: 'عرض المزيد',
                    trimExpandedText: 'عرض اقل',
                    moreStyle: TextStyles.cairo_14_bold
                        .copyWith(color: appColors.black),
                    style: TextStyles.cairo_14_semiBold
                        .copyWith(color: appColors.blue100),
                  ),
                  if (servicesRequirementsResponse.files!.isNotEmpty)
                    verticalSpace(20.w),
                  if (servicesRequirementsResponse.files!.isNotEmpty)
                    const Text(
                      "المرفقات",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: appColors.grey15,
                      ),
                    ),
                  verticalSpace(10.h),
                  if (servicesRequirementsResponse.files!.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: servicesRequirementsResponse.files!.length,
                      itemBuilder: (context, index) {
                        final file = servicesRequirementsResponse.files![index];
                        
                        if (file.isReply == 0 && file.isVoice == 0) {
                          return InkWell(
                            onTap: () => _openFileInBrowser(file.file.toString()),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attach_file,
                                  color: appColors.primaryColorYellow,
                                  size: 20.sp,
                                ),
                                horizontalSpace(10.w),
                                Text(
                                  "اضغط للمشاهدة",
                                  style: TextStyles.cairo_12_semiBold
                                      .copyWith(color: appColors.blue100),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return verticalSpace(10.h);
                      },
                    ),
                  if (servicesRequirementsResponse.files!.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: servicesRequirementsResponse.files!.length,
                      itemBuilder: (context, index) {
                        final file = servicesRequirementsResponse.files![index];
                        
                        if (file.isReply == 0 && file.isVoice == 1) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: AudioPlayerWidget(
                              audioUrl: file.file.toString(),
                              backgroundColor: appColors.white,
                              activeWaveColor: appColors.primaryColorYellow,
                              playButtonColor: appColors.primaryColorYellow,
                              indicatorColor: appColors.blue100.withOpacity(0.7),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                ],
              ),
            ),
            verticalSpace(20.h),
            ConditionalBuilder(
                condition: servicesRequirementsResponse.callId != null,
                builder: (context) => Container(
                      padding: EdgeInsets.all(20.0.sp),
                      margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
                      width: MediaQuery.of(context).size.width,
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                color: appColors.primaryColorYellow,
                                size: 20.sp,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "يوم الاستشارة",
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.grey15),
                              ),
                              const Spacer(),
                              Text(
                                getDate(servicesRequirementsResponse.from!),
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.blue100),
                              ),
                            ],
                          ),
                          verticalSpace(10.h),
                          Row(
                            children: [
                              Icon(
                                Icons.timelapse,
                                color: appColors.primaryColorYellow,
                                size: 20.sp,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "وقت  بدء المكالمة ",
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.grey15),
                              ),
                              const Spacer(),
                              Text(
                                getTime(servicesRequirementsResponse.from!),
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.blue100),
                              ),
                            ],
                          ),
                          verticalSpace(10.h),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.time,
                                color: appColors.primaryColorYellow,
                                size: 20.sp,
                              ),
                              horizontalSpace(10.w),
                              Text(
                                "مدة الاستشارة ",
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.grey15),
                              ),
                              const Spacer(),
                              Text(
                                "15 دقيقة",
                                style: TextStyles.cairo_12_semiBold
                                    .copyWith(color: appColors.blue100),
                              ),
                            ],
                          ),
                          verticalSpace(20.h),
                          CustomButton(
                            onPress: () async {
                              try {
                                var userType =
                                    CacheHelper.getData(key: 'userType');
                                if (userType == 'client') {
                                  StreamVideo.reset();
                                  StreamVideo(
                                    'd3cgunkh7jrg',
                                    user: User.regular(
                                        userId: getit<MyAccountCubit>()
                                            .clientProfile!
                                            .data!
                                            .account!
                                            .streamioId
                                            .toString(),
                                        name: getit<MyAccountCubit>()
                                            .clientProfile!
                                            .data!
                                            .account!
                                            .name),
                                    userToken: getit<MyAccountCubit>()
                                        .clientProfile!
                                        .data!
                                        .account!
                                        .streamioToken,
                                  );
                                } else {
                                  StreamVideo.reset();
                                  StreamVideo(
                                    'd3cgunkh7jrg',
                                    user: User.regular(
                                        userId: getit<MyAccountCubit>()
                                            .userDataResponse!
                                            .data!
                                            .account!
                                            .streamioId
                                            .toString(),
                                        name: getit<MyAccountCubit>()
                                            .userDataResponse!
                                            .data!
                                            .account!
                                            .name),
                                    userToken: getit<MyAccountCubit>()
                                        .userDataResponse!
                                        .data!
                                        .account!
                                        .streamioToken,
                                  );
                                }

                                var call = StreamVideo.instance.makeCall(
// type: 'default',
                                  callType: StreamCallType.custom("default"),
                                  id: servicesRequirementsResponse.callId!,
                                );

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CallScreen(call: call),
                                  ),
                                );

                                await call.getOrCreate();
                              } catch (e) {
                                debugPrint(
                                    'Error joining or creating call: $e');
                                debugPrint(e.toString());
                              }
                            },
                            title: 'بدء المكالمة',
                            height: 35.h,
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                    ),
                fallback: (context) => const SizedBox()),
            verticalSpace(20.h),
            Visibility(
              visible: servicesRequirementsResponse.replySubject != null,
              child: Container(
                padding: EdgeInsets.all(20.0.sp),
                margin: EdgeInsets.symmetric(horizontal: 20.0.sp),
                width: MediaQuery.of(context).size.width,
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
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(20.h),
                    Text(
                      "الرد على الخدمة",
                      style: TextStyles.cairo_16_bold
                          .copyWith(color: appColors.blue100),
                    ),
                    verticalSpace(10.h),
                    Container(
                      width: 130.w,
                      height: 2.h,
                      color: appColors.primaryColorYellow,
                    ),
                    verticalSpace(20.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.description,
                              color: appColors.primaryColorYellow,
                              size: 20.sp,
                            ),
                            Text(
                              "الرد ",
                              style: TextStyles.cairo_14_semiBold
                                  .copyWith(color: appColors.grey5),
                            ),
                          ],
                        ),
                        verticalSpace(10.w),
                        ReadMoreText(
                          servicesRequirementsResponse.replySubject
                                  .toString() ??
                              "",
                          trimCollapsedText: 'عرض المزيد',
                          trimExpandedText: 'عرض اقل',
                          moreStyle: TextStyles.cairo_14_bold
                              .copyWith(color: appColors.black),
                          style: TextStyles.cairo_14_semiBold
                              .copyWith(color: appColors.blue100),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            verticalSpace(50.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAIAssistantSheet(context);
        },
        backgroundColor: appColors.primaryColorYellow,
        child: Icon(
          Icons.psychology,
          color: Colors.white,
        ),
        tooltip: 'المساعد الذكي',
      ),
    );
  }

  void _showAIAssistantSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AIAssistantBottomSheet(
        orderDetails: servicesRequirementsResponse,
      ),
    );
  }
}

class AIAssistantBottomSheet extends StatefulWidget {
  final Reservation orderDetails;

  const AIAssistantBottomSheet({
    Key? key,
    required this.orderDetails,
  }) : super(key: key);

  @override
  State<AIAssistantBottomSheet> createState() => _AIAssistantBottomSheetState();
}

class _AIAssistantBottomSheetState extends State<AIAssistantBottomSheet> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;
  bool _isTyping = false;
  bool _showScrollToBottom = false;
  final ScrollController _scrollController = ScrollController();
  Timer? _typingTimer;
  String _currentTypingText = '';
  int _currentTypingIndex = 0;

  final String apiKey = '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';
  final String modelName = 'gpt-4o-mini-2024-07-18';

  // Updated system instructions to include handling of unclear requests
  final String systemInstructions = '''
    أنت مساعد ذكي متخصص في تقديم معلومات عن الأنظمة والقوانين السعودية. اتبع هذه الإرشادات:

    ### خطوات التحليل:
    1. **تقييم الطلب:** تحقق أولاً إذا كان الطلب واضحًا ويحتوي على موضوع قانوني محدد
    2. **تلخيص الطلب:** قدم ملخصًا موجزًا للاستشارة المقدمة من العميل (إذا كانت واضحة)
    3. **تحديد القوانين ذات الصلة:** حدد القوانين واللوائح السعودية المتعلقة بموضوع الاستشارة
    4. **تقديم معلومات قانونية:** اذكر المواد القانونية المحددة مع شرح مبسط لها

    ### النطاق:
    - ركز على الأنظمة والقوانين في المملكة العربية السعودية فقط
    - استخدم نصوص قانونية دقيقة وحديثة
    - قدم إجابات واضحة ومختصرة في نقاط محددة

    ### للطلبات غير الواضحة:
    - إذا كان وصف الطلب غير واضح أو لا يحدد موضوعًا قانونيًا محددًا، اشرح للمستخدم أن تفاصيل الاستشارة غير كافية
    - اطلب من المستخدم توضيح موضوع الاستشارة القانونية التي يحتاج معلومات عنها
    - قدم أمثلة لأنواع المعلومات التي يمكنك مساعدته بها

    ### الشكل المطلوب للرد:
    - للطلبات الواضحة: تلخيص موجز للاستشارة، ثم قائمة بالقوانين ذات الصلة، ثم نقاط محددة تتعلق بالقوانين المذكورة
    - للطلبات غير الواضحة: توضيح أن المعلومات غير كافية وطلب مزيد من التفاصيل

    ### ملاحظات إضافية:
    - تجنب تقديم استشارات قانونية مباشرة
    - استخدم لغة سهلة وواضحة
    - قدم المعلومات بشكل موضوعي
''';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Send initial request automatically to summarize the order
    _sendInitialSummaryRequest();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      setState(() {
        _showScrollToBottom = currentScroll < maxScroll - 100;
      });
    }
  }

  Future<void> _sendInitialSummaryRequest() async {
    setState(() {
      _isTyping = true;
      _isLoading = true;
    });

    try {
      // Prepare a summary request based on order details, with instructions to check for clarity
      final summaryRequest = '''
تحليل ومساعدة للاستشارة التالية:
- نوع الاستشارة: ${widget.orderDetails.advisoryServicesSub?.name ?? 'غير محدد'}
- نوع الوسيلة: ${widget.orderDetails.advisoryServicesSub?.generalCategory?.paymentCategoryType?.requiresAppointment == 1 ? 'مرئية' : 'مكتوبة'}
- موضوع الاستشارة: ${widget.orderDetails.description ?? 'لا يوجد وصف'}
- مستوى الطلب: ${widget.orderDetails.importance?.title ?? 'غير محدد'}

مهم: تحقق أولاً مما إذا كانت تفاصيل الاستشارة تحتوي على موضوع قانوني واضح يمكنك المساعدة فيه. 

إذا كانت التفاصيل غير واضحة أو لا تتعلق بموضوع قانوني محدد، فأوضح للمستخدم أن المعلومات غير كافية واطلب المزيد من التفاصيل.
إذا كانت التفاصيل واضحة، فقم بما يلي:
1. تلخيص موجز للاستشارة
2. تحديد القوانين واللوائح السعودية ذات الصلة بالموضوع
3. عرض مواد قانونية محددة مع شرح مبسط تتعلق بالموضوع
      ''';

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': modelName,
          'messages': [
            {'role': 'system', 'content': systemInstructions},
            {'role': 'user', 'content': summaryRequest}
          ],
          'temperature': 0.3, // Lower temperature for more consistent responses
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final aiResponse = data['choices'][0]['message']['content'];

        _startTypingAnimation(aiResponse);
      } else {
        setState(() {
          _messages.add(ChatMessage(
            text: 'عذراً، حدث خطأ في الاتصال. حاول مرة أخرى',
            isUser: false,
            isError: true,
          ));
          _isTyping = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: 'عذراً، حدث خطأ في الاتصال. حاول مرة أخرى',
          isUser: false,
          isError: true,
        ));
        _isTyping = false;
        _isLoading = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty || _isTyping) return;

    final userMessage = _messageController.text;
    _messageController.clear();

    setState(() {
      _messages.add(ChatMessage(
        text: userMessage,
        isUser: true,
      ));
      _isTyping = true;
      _isLoading = true;
    });

    try {
      // Include the order details context in every message with instructions for clarity check
      final contextEnhancedMessage = '''
استفسار المستخدم: $userMessage

معلومات الاستشارة:
- نوع الاستشارة: ${widget.orderDetails.advisoryServicesSub?.name ?? 'غير محدد'}
- موضوع الاستشارة: ${widget.orderDetails.description ?? 'لا يوجد وصف'}

تحقق ما إذا كان الاستفسار يتعلق بموضوع قانوني واضح يمكنك المساعدة فيه. إذا كان غير واضح، أطلب من المستخدم مزيد من التوضيح.
      ''';

      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': modelName,
          'messages': [
            {'role': 'system', 'content': systemInstructions},
            {'role': 'user', 'content': contextEnhancedMessage}
          ],
          'temperature': 0.3, // Lower temperature for more consistent responses
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final aiResponse = data['choices'][0]['message']['content'];

        _startTypingAnimation(aiResponse);
      } else {
        setState(() {
          _messages.add(ChatMessage(
            text: 'عذراً، حدث خطأ في الاتصال. حاول مرة أخرى',
            isUser: false,
            isError: true,
          ));
          _isTyping = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _messages.add(ChatMessage(
          text: 'عذراً، حدث خطأ في الاتصال. حاول مرة أخرى',
          isUser: false,
          isError: true,
        ));
        _isTyping = false;
        _isLoading = false;
      });
    }
  }

  // Add scroll to bottom function
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _startTypingAnimation(String fullText) {
    _currentTypingText = '';
    _currentTypingIndex = 0;

    setState(() {
      _messages.add(ChatMessage(
        text: _currentTypingText,
        isUser: false,
        isTyping: true,
      ));
    });

    _typingTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) async {
      if (_currentTypingIndex < fullText.length) {
        // Enhanced haptic feedback (lite version for better performance)
        if (_currentTypingIndex % 20 == 0) {
          await HapticFeedback.selectionClick();
        }

        setState(() {
          _currentTypingText += fullText[_currentTypingIndex];
          _messages.last = ChatMessage(
            text: _currentTypingText,
            isUser: false,
            isTyping: true,
          );
          _currentTypingIndex++;
        });

        // Scroll to bottom while typing
        _scrollToBottom();
      } else {
        timer.cancel();
        setState(() {
          _messages.last = ChatMessage(
            text: fullText,
            isUser: false,
          );
          _isTyping = false;
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          // Handle indicator
          Container(
            margin: EdgeInsets.only(top: 10.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close, color: appColors.grey15),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  'المساعد القانوني',
                  style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
                ),
                SizedBox(width: 40.w),
              ],
            ),
          ),
          // Divider
          Container(
            height: 1.h,
            color: Colors.grey[200],
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Add controller
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }
                return _messages[index];
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDot(1),
            _buildDot(2),
            _buildDot(3),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!,
        child: Container(
          width: 6.w,
          height: 6.w,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 12,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: 120.h, // Maximum height for multiple lines
              ),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: _isTyping
                      ? Colors.grey[300]!
                      : appColors.primaryColorYellow.withOpacity(0.3),
                ),
              ),
              child: TextField(
                controller: _messageController,
                enabled: !_isTyping,
                maxLines: null,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: 'Cairo',
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: _isTyping ? 'انتظر الرد...' : 'اسأل سؤال حول القوانين ذات الصلة...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                    fontFamily: 'Cairo',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            decoration: BoxDecoration(
              color: _isTyping
                  ? Colors.grey[200]
                  : appColors.primaryColorYellow,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _isTyping ? null : _sendMessage,
              icon: Icon(
                CupertinoIcons.arrow_up,
                color: _isTyping
                    ? Colors.grey[400]
                    : Colors.white,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final bool isError;
  final bool isTyping;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
    this.isError = false,
    this.isTyping = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: isUser ? Colors.white : Colors.grey[50],
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]!,
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15.r,
                  backgroundColor: isUser ? appColors.primaryColorYellow : appColors.blue100,
                  child: Icon(
                    isUser ? Icons.person : Icons.psychology,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  isUser ? 'أنت' : 'المساعد القانوني',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: isTyping
                ? _buildAnimatedText(context)
                : _buildFormattedText(context),
          ),
          if (!isUser && !isTyping) // Add actions row for AI messages only
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Row(
                children: [
                  _buildActionButton(
                    context,
                    icon: Icons.copy,
                    label: 'نسخ',
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: text));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم النسخ بنجاح'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 16.w),
                  _buildActionButton(
                    context,
                    icon: Icons.share,
                    label: 'مشاركة',
                    onTap: () {
                      Share.share(text);
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimatedText(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black87,
        fontFamily: 'Cairo',
        height: 1.5,
        fontSize: 14.sp,
      ),
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildFormattedText(BuildContext context) {
    if (isError) {
      return Text(
        text,
        style: TextStyle(
          color: Colors.red[900],
          fontFamily: 'Cairo',
          height: 1.5,
          fontSize: 14.sp,
        ),
        textDirection: TextDirection.rtl,
      );
    }

    List<TextSpan> spans = [];
    String currentText = '';
    bool isBold = false;

    for (int i = 0; i < text.length; i++) {
      if (text[i] == '*' && i + 1 < text.length && text[i + 1] == '*') {
        if (currentText.isNotEmpty) {
          spans.add(TextSpan(
            text: currentText,
            style: TextStyle(
              color: Colors.black87,
              fontFamily: 'Cairo',
              height: 1.5,
              fontSize: 14.sp,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ));
          currentText = '';
        }
        isBold = !isBold;
        i++;
      } else {
        currentText += text[i];
      }
    }

    if (currentText.isNotEmpty) {
      spans.add(TextSpan(
        text: currentText,
        style: TextStyle(
          color: Colors.black87,
          fontFamily: 'Cairo',
          height: 1.5,
          fontSize: 14.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
      textDirection: TextDirection.rtl,
    );
  }

  Widget _buildActionButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16.sp,
              color: Colors.grey[600],
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.sp,
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
