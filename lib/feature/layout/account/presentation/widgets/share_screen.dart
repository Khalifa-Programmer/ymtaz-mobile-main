import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_state.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../logic/my_account_cubit.dart';

class ShareScreen extends StatelessWidget {
  ShareScreen(
      {super.key, required this.appWelcomeMessage, required this.codeRef});

  final String appWelcomeMessage;
  final String codeRef;
  final TextEditingController controller = TextEditingController();

  // استخدم ValueNotifier لتتبع حالة رسالة الخطأ
  final ValueNotifier<String?> errorMessageNotifier =
      ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<MyAccountCubit>()..getInvitations(),
      child: BlocConsumer<MyAccountCubit, MyAccountState>(
        listener: (context, state) {
          if (state is SuccessSendInvite) {
            AnimatedSnackBar.material(
              "تم إرسال الدعوة بنجاح",
              type: AnimatedSnackBarType.success,
            ).show(context);
          }

          if (state is LoadingSendInvite) {
            AnimatedSnackBar.material(
              "جاري إرسال الدعوة",
              type: AnimatedSnackBarType.info,
            ).show(context);
          }

          if (state is ErrorSendInvite) {
            AnimatedSnackBar.material(
              state.error,
              type: AnimatedSnackBarType.error,
            ).show(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            CupertinoIcons.xmark_circle_fill,
                            color: appColors.grey.withOpacity(0.5),
                            size: 30.sp,
                          ))
                    ],
                  ),
                  QrImageView(
                    data: 'https://onelink.to/bb6n4x',
                    version: QrVersions.auto,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: appColors.black,
                    ),
                    size: 120.0,
                  ),
                  Text(
                    'رمز الدعوة',
                    style: TextStyles.cairo_12_bold,
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: codeRef));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم نسخ الرمز بنجاح'),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.copy_rounded,
                          color: appColors.grey20,
                        ),
                        horizontalSpace(5.w),
                        Text(
                          codeRef,
                          style: TextStyles.cairo_12_semiBold,
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(10.h),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      final RenderBox box =
                          context.findRenderObject() as RenderBox;
                      Share.share(
                        '$appWelcomeMessage\n $codeRef',
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: appColors.primaryColorYellow.withOpacity(0.3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 4,
                            blurRadius: 9,
                            offset: const Offset(3, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "مشاركة التطبيق",
                            style: TextStyles.cairo_12_bold,
                          ),
                          horizontalSpace(10.w),
                          const Icon(
                            Icons.share,
                            color: appColors.blue100,
                          ),
                        ],
                      ),
                    ),
                  ),
                  verticalSpace(5.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // يمكنك هنا وضع دالة التحقق من صحة البريد الإلكتروني أو رقم الهاتف
  bool isEmail(String input) {
    // التحقق من البريد الإلكتروني
    return RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input);
  }

  bool isSaudiPhoneNumber(String input) {
    // التحقق من رقم الهاتف السعودي
    return RegExp(r"^(\+966|0)?5\d{8}$").hasMatch(input);
  }
}

class InviteUserScreen extends StatelessWidget {
  InviteUserScreen({super.key});

  final TextEditingController controller = TextEditingController();

  // استخدم ValueNotifier لتتبع حالة رسالة الخطأ
  final ValueNotifier<String?> errorMessageNotifier =
      ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<MyAccountCubit>()..getInvitations(),
      child: BlocConsumer<MyAccountCubit, MyAccountState>(
        listener: (context, state) {
          if (state is SuccessSendInvite) {
            AnimatedSnackBar.material(
              "تم إرسال الدعوة بنجاح",
              type: AnimatedSnackBarType.success,
            ).show(context);
          }

          if (state is LoadingSendInvite) {
            AnimatedSnackBar.material(
              "جاري إرسال الدعوة",
              type: AnimatedSnackBarType.info,
            ).show(context);
          }

          if (state is ErrorSendInvite) {
            AnimatedSnackBar.material(
              state.error,
              type: AnimatedSnackBarType.error,
            ).show(context);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            CupertinoIcons.xmark_circle_fill,
                            color: appColors.grey.withOpacity(0.5),
                            size: 30.sp,
                          ))
                    ],
                  ),
                  verticalSpace(5.h),
                  Row(
                    children: [
                      Text(
                        'دعوة الأصدقاء',
                        style: TextStyles.cairo_12_bold,
                      ),
                    ],
                  ),
                  verticalSpace(10.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CupertinoTextField(
                              placeholder:
                                  'أدخل رقم الجوال أو البريد الإلكتروني',
                              padding: EdgeInsets.all(10),
                              controller: controller,
                              decoration: BoxDecoration(
                                color: appColors.grey10.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              suffix: CupertinoButton(
                                padding: const EdgeInsets.all(10),
                                child: CircleAvatar(
                                  radius: 10.r,
                                  backgroundColor: appColors.primaryColorYellow,
                                  child: const Icon(
                                    CupertinoIcons.arrow_up,
                                    size: 15,
                                    color: CupertinoColors.white,
                                  ),
                                ),
                                onPressed: () {
                                  String input = controller.text.trim();

                                  if (input.isNotEmpty) {
                                    if (isEmail(input)) {
                                      // النص هو بريد إلكتروني صالح
                                      errorMessageNotifier.value = null;

                                      Map<String, String> data = {
                                        'email': input,
                                      };
                                      getit<MyAccountCubit>().inviteUser(data);
                                    } else if (isSaudiPhoneNumber(input)) {
                                      // النص هو رقم هاتف سعودي صالح
                                      errorMessageNotifier.value = null;
                                      Map<String, String> data = {
                                        'phone': input,
                                        'phone_code': '966'
                                      };
                                      getit<MyAccountCubit>().inviteUser(data);
                                    } else {
                                      // عرض رسالة خطأ إذا كان الإدخال غير صالح
                                      errorMessageNotifier.value =
                                          'المدخل غير صحيح. يرجى إدخال رقم جوال سعودي أو بريد إلكتروني صالح.';
                                    }
                                  } else {
                                    // عرض رسالة خطأ إذا كان الحقل فارغ
                                    errorMessageNotifier.value =
                                        'الرجاء إدخال رقم جوال أو بريد إلكتروني.';
                                  }
                                },
                              ),
                            ),

                            // عرض رسالة الخطأ تحت الحقل باستخدام ValueListenableBuilder
                            ValueListenableBuilder<String?>(
                              valueListenable: errorMessageNotifier,
                              builder: (context, errorMessage, _) {
                                if (errorMessage != null) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      errorMessage,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 12),
                                    ),
                                  );
                                } else {
                                  return Container(); // لا تعرض شيئًا إذا لم يكن هناك رسالة خطأ
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10.h),
                  state is LoadingInvitations
                      ? const Center(child: CircularProgressIndicator())
                      : ConditionalBuilder(
                          condition: state is SuccessInvitations,
                          builder: (context) => ExpansionTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            collapsedShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            iconColor: appColors.primaryColorYellow,
                            collapsedIconColor: appColors.primaryColorYellow,
                            tilePadding: EdgeInsets.symmetric(horizontal: 10.w),
                            collapsedBackgroundColor:
                                appColors.primaryColorYellow.withOpacity(0.1),
                            title: Text(
                              'الأصدقاء المدعوون',
                              // يمكنك تغيير النص هنا ليكون العنوان المناسب
                              style: TextStyles
                                  .cairo_12_bold, // يمكنك استخدام نمط النص المناسب
                            ),
                            children: [
                              SizedBox(
                                // يمكنك استخدام SizedBox لتحديد ارتفاع المحتوى داخل ExpansionTile
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state is SuccessInvitations
                                      ? (state).data.data!.length
                                      : 0,
                                  separatorBuilder: (context, index) =>
                                      verticalSpace(10.h),
                                  itemBuilder: (context, index) {
                                    var data = (state as SuccessInvitations)
                                        .data
                                        .data![index];
                                    return ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        data.email ?? data.phone ?? '',
                                        style: TextStyles.cairo_12_semiBold,
                                      ),
                                      subtitle: Text(
                                        data.status == 1
                                            ? 'تم إرسال الدعوة'
                                            : 'تم قبول الدعوة',
                                        style: TextStyles.cairo_12_semiBold,
                                      ),
                                      leading: const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://api.ymtaz.sa/uploads/person.png'),
                                      ),
                                      trailing: Icon(
                                        data.status == 1
                                            ? Icons.watch_later_rounded
                                            : CupertinoIcons
                                                .checkmark_circle_fill,
                                        color: data.status == 1
                                            ? appColors.blue90
                                            : appColors.green,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          fallback: (context) => const Center(
                            child: Text('لا توجد دعوات.'),
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

  // Future<void> _pickContact(BuildContext context) async {
  //   PermissionStatus permission = await Permission.contacts.request();
  //   if (permission.isGranted) {
  //     // Fetch contacts
  //     Iterable<Contact> contacts = await ContactsService.getContacts();
  //
  //     // Show contacts in a dialog for user to select
  //     showModalBottomSheet(
  //       context: context,
  //       builder: (context) {
  //         return ListView.builder(
  //           itemCount: contacts.length,
  //           itemBuilder: (context, index) {
  //             final contact = contacts.elementAt(index);
  //             return ListTile(
  //               title: Text(contact.displayName ?? ''),
  //               onTap: () {
  //                 if (contact.phones!.isNotEmpty) {
  //                   // Set the selected phone number in the text field
  //                   controller.text = contact.phones!.first.value!;
  //                 }
  //                 Navigator.pop(context);
  //               },
  //             );
  //           },
  //         );
  //       },
  //     );
  //   } else {
  //     // Handle permission denied
  //     AnimatedSnackBar.material(
  //       "Permission to access contacts is required.",
  //       type: AnimatedSnackBarType.error,
  //     ).show(context);
  //   }
  // }

  // يمكنك هنا وضع دالة التحقق من صحة البريد الإلكتروني أو رقم الهاتف
  bool isEmail(String input) {
    // التحقق من البريد الإلكتروني
    return RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input);
  }

  bool isSaudiPhoneNumber(String input) {
    // التحقق من رقم الهاتف السعودي
    return RegExp(r"^(\+966|0)?5\d{8}$").hasMatch(input);
  }
}
