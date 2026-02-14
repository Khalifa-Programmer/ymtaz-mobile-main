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
    _priceController.clear();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: ServiceSelectionContent(
            priceController: _priceController,
            onServiceAdded: _addServiceRequest,
          ),
        ),
      ),
    );
  }
}

class ServiceSelectionContent extends StatefulWidget {
  final TextEditingController priceController;
  final Function(BaseServiceRequest) onServiceAdded;

  const ServiceSelectionContent({
    super.key,
    required this.priceController,
    required this.onServiceAdded,
  });

  @override
  State<ServiceSelectionContent> createState() => _ServiceSelectionContentState();
}

class _ServiceSelectionContentState extends State<ServiceSelectionContent> {
  String selectedService = 'استشارة';

  void _handleServiceSuccess(BaseServiceRequest request) {
    widget.onServiceAdded(request);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandleBar(),

          _buildTitle(),
          SizedBox(height: 16.h),

          _buildServiceOptions(),
          SizedBox(height: 16.h),

          if (selectedService == 'استشارة')
            ConsultationForm(
              priceController: widget.priceController,
              onSuccess: _handleServiceSuccess,
            )
          else if (selectedService == 'موعد')
            AppointmentForm(
              priceController: widget.priceController,
              onSuccess: _handleServiceSuccess,
            )
          else if (selectedService == 'خدمة')
            ServiceForm(
              priceController: widget.priceController,
              onSuccess: _handleServiceSuccess,
            ),
        ],
      ),
    );
  }

  Widget _buildServiceOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceOption('موعد', AppAssets.appointments),
        _buildServiceOption('استشارة', AppAssets.advisories),
        _buildServiceOption('خدمة', AppAssets.services),
      ],
    );
  }

  Widget _buildServiceOption(String title, String icon) {
    final bool isSelected = selectedService == title;
    return InkWell(
      onTap: () {
        setState(() => selectedService = title);
      },
      child: Container(
        width: 80.w,
        height: 80.w,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFFD4AF37) : Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.circular(8.r),
          color: isSelected ? const Color(0xFFFFF8E1) : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: isSelected ? const Color(0xFFD4AF37) : appColors.grey1w5,
              width: 24.w,
              height: 24.w,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 14.sp,
                color: isSelected ? const Color(0xFFD4AF37) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      width: 40.w,
      height: 4.h,
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'إضافة خدمة',
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
