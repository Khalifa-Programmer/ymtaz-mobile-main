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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is YmtazElitePricingReplyLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 8.h),
                  child: ElevatedButton(
                    onPressed: () => _showAddServiceBottomSheet(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      side: const BorderSide(color: Colors.grey),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'إضافة خدمة',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
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
    String details;

    if (request is ConsultationRequest) {
      title = 'استشارة';
      details = 'السعر: ${request.price} ريال';
    } else if (request is AppointmentRequest) {
      title = 'موعد';
      details = 'السعر: ${request.price} ريال\n${request.address}';
    } else if (request is ServiceRequest) {
      title = 'خدمة';
      details = 'السعر: ${request.price} ريال';
    } else {
      title = 'خدمة';
      details = '';
    }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: ListTile(
        title: Text(title),
        subtitle: Text(details),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: appColors.red),
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

