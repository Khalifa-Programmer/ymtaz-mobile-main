import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../../../core/constants/colors.dart';
import 'widgets/consultation_form.dart';
import 'widgets/service_form.dart';
import 'widgets/appointment_form.dart';
import 'models/service_request.dart';
import 'add_service_screen.dart';
import '../../../../core/widgets/spacing.dart';
import '../../../../core/widgets/alerts.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  final List<BaseServiceRequest> serviceRequests = [];
  final TextEditingController _priceController = TextEditingController();

  void _addServiceRequest(BaseServiceRequest request) {
    setState(() {
      serviceRequests.add(request);
    });
  }

  void _removeServiceRequest(int index) {
    setState(() {
      serviceRequests.removeAt(index);
    });
  }

  @override
  void initState() {
    super.initState();
    // Automatically show add service screen on first load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (serviceRequests.isEmpty) {
        _showAddServiceBottomSheet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildBlurredAppBar(context, 'طلب النخبة'),
      body: BlocConsumer<YmtazEliteCubit, YmtazEliteState>(
        listener: (context, state) {
          if (state is YmtazElitePricingReplySuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم إرسال التسعير بنجاح')),
            );
            Navigator.of(context).pop();
          } else if (state is YmtazElitePricingReplyError) {
            AppAlerts.showAlert(
              context: context,
              message: state.message,
              buttonText: 'حسناً',
              type: AlertType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is YmtazElitePricingReplyLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final request = context.read<YmtazEliteCubit>().selectedRequest;
          
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                if (request != null) ...[
                  verticalSpace(16.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          request.status == 'pending-pricing' ? 'قيد التسعير' : request.status ?? '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'إضافة تفاصيل التسعير',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[600],
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ],
                if (serviceRequests.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: InkWell(
                      onTap: () {
                        if (request?.status == 'pending-pricing') {
                          _showAddServiceBottomSheet();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('لا يمكن إضافة خدمات لطلب غير متاح للتسعير')),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(16.r),
                      child: Container(
                        width: double.infinity,
                        height: 100.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF6E9).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: const Color(0xFFD4AF37).withOpacity(0.3),
                            width: 1.5,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD4AF37).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.add_rounded,
                                color: const Color(0xFFD4AF37),
                                size: 28.sp,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'إضافة خدمة جديدة',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF8B7355),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: serviceRequests.length,
                    itemBuilder: (context, index) {
                      final request = serviceRequests[index];
                      return _buildServiceCard(request, index);
                    },
                  ),
                ),
                CustomButton(
                  title: 'إرسال الطلب',
                  onPress: () {
                    if (request?.status != 'pending-pricing') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('عذراً، هذا الطلب لم يعد متاحاً للتسعير')),
                      );
                      return;
                    }
                    
                    if (serviceRequests.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('برجاء إضافة خدمة واحدة على الأقل')),
                      );
                      return;
                    }
                    
                    context.read<YmtazEliteCubit>().submitPricingReply(serviceRequests);
                  },
                ),
                SizedBox(height: 40.h),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(BaseServiceRequest request, int index) {
    String title;
    IconData icon;
    String details;

    if (request is ConsultationRequest) {
      title = 'استشارة';
      icon = Icons.chat_bubble_outline;
      details = 'السعر: ${request.price} ريال';
    } else if (request is AppointmentRequest) {
      title = 'موعد';
      icon = Icons.calendar_today;
      details = 'السعر: ${request.price} ريال\n${request.address}';
    } else if (request is ServiceRequest) {
      title = 'خدمة';
      icon = Icons.grid_view;
      String serviceName = request.serviceName ?? '';
      String levelName = request.levelName != null ? ' - ${request.levelName}' : '';
      details = '${serviceName}${levelName}\nالسعر: ${request.price} ريال';
    } else {
      title = 'خدمة';
      icon = Icons.grid_view;
      details = '';
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF6E9),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: const Color(0xFFD4AF37)),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2D37),
            fontFamily: 'Cairo',
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.h),
          child: Text(
            details,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[600],
              height: 1.5,
              fontFamily: 'Cairo',
            ),
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: () => _removeServiceRequest(index),
        ),
      ),
    );
  }

  void _showAddServiceBottomSheet() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddServiceScreen(
          onServiceAdded: _addServiceRequest,
        ),
      ),
    );
  }
}

