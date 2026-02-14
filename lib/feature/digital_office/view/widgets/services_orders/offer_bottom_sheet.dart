import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/widgets/primary/text_form_primary.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_state.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../../logic/office_provider_cubit.dart';

class OfferBottomSheet extends StatefulWidget {
  const OfferBottomSheet({super.key, required this.id});

  final String id;

  @override
  _OfferBottomSheetState createState() => _OfferBottomSheetState();
}

class _OfferBottomSheetState extends State<OfferBottomSheet>
    with SingleTickerProviderStateMixin {
  final TextEditingController _priceController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _priceController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<OfficeProviderCubit>(),
      child: BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
        listener: (context, state) {
          state.whenOrNull(
            loadedOfferSend: (data) {
              Navigator.pop(context);
              Navigator.pop(context);

              getit<OfficeProviderCubit>().servicesRequestsPending();
            },
            errorOfferSend: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                ),
              );
            },
          );
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // يضبط المسافة مع الكيبورد
            ),
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close)),
                      Container(
                        width: 60.sp,
                        height: 4.sp,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8.sp),
                        ),
                      ),
                      SizedBox(
                        width: 50.sp,
                        height: 4.sp,
                      ),
                    ],
                  ),
                  Text(
                    'ادخل السعر الذي تريد ان تقدمه',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(8.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextFieldPrimary(
                          hintText: 'السعر',
                          externalController: _priceController,
                          type: TextInputType.number,
                          typeInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'الرجاء ادخال السعر';
                            }
                            return null;
                          },
                          title: 'السعر',
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(8.sp),
                  Text(
                    '⚡ قدم العرض الان واحصل على الخدمه بشكل اسرع',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(16.sp),
                  state.maybeWhen(
                    loadingOfferSend: () => ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.sp),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        // primary: Colors.grey[300],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.black,
                            ),
                            horizontalSpace(8.sp),
                            const Text("جاري الإرسال"),
                          ],
                        ),
                      ),
                    ),
                    orElse: () => SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        color: appColors.primaryColorYellow,
                        onPressed: () {
                          FormData data = FormData.fromMap({
                            "price": _priceController.text,
                            'id': widget.id
                          });
                          context
                              .read<OfficeProviderCubit>()
                              .replyServicesOfferProviderOfficeClient(data);
                        },
                        child: Text(
                          "ارسال الطلب",
                          style: TextStyles.cairo_12_bold
                              .copyWith(color: appColors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

// void _showLoadingDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return Dialog(
//         surfaceTintColor: Colors.transparent,
//         shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(20))),
//         child: Container(
//           padding: EdgeInsets.all(16.sp),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator(
//                 color: appColors.primaryColorYellow,
//               ),
//               horizontalSpace(16.sp),
//               const Text("جاري إرسال العرض"),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
}
