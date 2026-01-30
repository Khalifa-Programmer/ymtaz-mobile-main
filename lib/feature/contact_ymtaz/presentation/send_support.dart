import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/validators.dart';
import 'package:yamtaz/core/helpers/attachment_uploader.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/primary/text_form_primary.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/contact_ymtaz/logic/contact_ymtaz_cubit.dart';
import 'package:yamtaz/feature/contact_ymtaz/logic/contact_ymtaz_state.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/alerts.dart';
import '../../../core/widgets/custom_container.dart';
import '../../../main.dart';
import '../../../yamtaz.dart';
import '../data/models/contact_us_types.dart';

class SendSupportYmtaz extends StatefulWidget {
  const SendSupportYmtaz({super.key});

  @override
  State<SendSupportYmtaz> createState() => _SendSupportYmtazState();
}

class _SendSupportYmtazState extends State<SendSupportYmtaz> {
  final _formKey = GlobalKey<FormState>();
  
  // متغير للتحكم في حالة النموذج
  bool _isFormSubmitted = false;
  
  // متغيرات للتحكم في حالة كل حقل
  bool _validateSubject = false;
  bool _validateDetails = false;
  bool _validateType = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ContactYmtazCubit, ContactYmtazState>(
        listenWhen: (previous, current) =>
            current is ErrorSendMessage ||
            current is SuccessSendMessage ||
            current is LoadingSendMessage,
        listener: (context, state) {
          state.whenOrNull(
            loadingSendMessage: () {
              showDialog(
                context: context,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(
                    color: appColors.primaryColorYellow,
                  ),
                ),
              );
            },
            successSendMessage: (s) {
              context.pop();
              
              // تعيين متغير حالة النموذج
              _isFormSubmitted = true;
              
              // إعادة تعيين متغيرات التحقق
              _validateSubject = false;
              _validateDetails = false;
              _validateType = false;
              
              // تفريغ البيانات
              context.read<ContactYmtazCubit>().subject.clear();
              context.read<ContactYmtazCubit>().details.clear();
              context.read<ContactYmtazCubit>().attachments = null;
              context.read<ContactYmtazCubit>().contactUsTypeId = null;
              
              // عرض رسالة النجاح
              AppAlerts.showAlert(
                  context: context,
                  message: "تم ارسال الرسالة بنجاح",
                  buttonText: "استمرار",
                  type: AlertType.success);
              
              // إعادة بناء الواجهة بعد إغلاق الرسالة
              Future.delayed(const Duration(milliseconds: 300), () {
                setState(() {
                  // إعادة تعيين النموذج بعد تفريغ البيانات
                  if (_formKey.currentState != null) {
                    _formKey.currentState!.reset();
                  }
                  
                  // إعادة تعيين متغير حالة النموذج
                  _isFormSubmitted = false;
                });
              });
            },
            errorSendMessage: (e) {
              context.pop();
              AppAlerts.showAlert(
                  context: context,
                  message: e,
                  buttonText: "حاول مرة اخرى",
                  type: AlertType.error);
            },
          );
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: ConditionalBuilder(
                condition:
                    context.read<ContactYmtazCubit>().contactUsTypes != null,
                builder: (BuildContext context) {
                  return Form(
                    key: _formKey,
                    // تعطيل التحقق التلقائي تمامًا
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      children: [
                        CustomContainer(
                            title: "نوع الطلب",
                            child: CustomDropdown<ContactType>.search(
                              validator: _validateType 
                                  ? (p0) => Validators.validateNotEmpty(p0?.name)
                                  : null,
                              overlayHeight:
                                  MediaQuery.of(context).size.height * 0.5,
                              hintBuilder: (context, hint, enabled) {
                                return Text(
                                  "نوع الطلب",
                                  style: TextStyle(
                                      color: appColors.blue100,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600),
                                );
                              },
                              items: context
                                  .read<ContactYmtazCubit>()
                                  .contactUsTypes!
                                  .data!
                                  .contactTypes!,
                              onChanged: (value) {
                                setState(() {
                                  context
                                      .read<ContactYmtazCubit>()
                                      .contactUsTypeId = value?.id;
                                });
                              },
                            )),
                        CustomTextFieldPrimary(
                            hintText: "الموضوع",
                            validator: _validateSubject 
                                ? Validators.validateNotEmpty
                                : null,
                            externalController:
                                context.read<ContactYmtazCubit>().subject,
                            title: "الموضوع",
                            onChanged: (value) {
                              // تفعيل التحقق فقط لهذا الحقل عند التغيير
                              if (!_validateSubject) {
                                setState(() {
                                  _validateSubject = true;
                                });
                              }
                            },
                        ),
                        CustomTextFieldPrimary(
                            hintText: "الرسالة",
                            multiLine: true,
                            validator: _validateDetails 
                                ? Validators.validateNotEmpty
                                : null,
                            externalController:
                                context.read<ContactYmtazCubit>().details,
                            title: "الرسالة",
                            onChanged: (value) {
                              // تفعيل التحقق فقط لهذا الحقل عند التغيير
                              if (!_validateDetails) {
                                setState(() {
                                  _validateDetails = true;
                                });
                              }
                            },
                        ),
                        AttachmentPicker(
                            condition: true,
                            title: "المرفقات",
                            uploadText: "رفع ملف",
                            attachedText: "الملف المرفق",
                            attachment:
                                context.read<ContactYmtazCubit>().attachments,
                            onTap: () async {
                              hideKeyboard(navigatorKey.currentContext!);

                              context.read<ContactYmtazCubit>().attachments =
                                  await context
                                      .read<ContactYmtazCubit>()
                                      .pickFile();
                              setState(() {});
                            },
                            onRemoveFile: () {
                              context.read<ContactYmtazCubit>().attachments =
                                  null;
                              setState(() {});
                            }),
                        verticalSpace(16.sp),
                        CustomButton(
                            title: "إرسال",
                            onPress: () {
                              // إخفاء لوحة المفاتيح
                              FocusScope.of(context).unfocus();
                              
                              // تفعيل التحقق لجميع الحقول عند الضغط على زر الإرسال
                              setState(() {
                                _validateSubject = true;
                                _validateDetails = true;
                                _validateType = true;
                              });
                              
                              // التحقق من صحة النموذج قبل الإرسال
                              if (_formKey.currentState?.validate() ?? false) {
                                Map<String, dynamic> data = {
                                  "subject": context
                                      .read<ContactYmtazCubit>()
                                      .subject
                                      .text,
                                  "type": context
                                      .read<ContactYmtazCubit>()
                                      .contactUsTypeId,
                                  "details": context
                                      .read<ContactYmtazCubit>()
                                      .details
                                      .text,
                                };
                                FormData formData = FormData.fromMap(data);

                                if (context.read<ContactYmtazCubit>().attachments !=
                                    null) {
                                  formData.files.add(MapEntry(
                                      "file",
                                      MultipartFile.fromFileSync(context
                                          .read<ContactYmtazCubit>()
                                          .attachments!
                                          .path)));
                                }

                                context
                                    .read<ContactYmtazCubit>()
                                    .emitPostContactYmtazClient(formData);
                              }
                            }),
                      ],
                    ),
                  );
                },
                fallback: (BuildContext context) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
