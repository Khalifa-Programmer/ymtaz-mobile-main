import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/feature/law_guide/presentation/laws_guide_search.dart';
import 'package:yamtaz/feature/law_guide/presentation/widgets/laws_guide_body.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/network/local/cache_helper.dart';
import '../../../core/widgets/spacing.dart';
import '../../../core/widgets/webview_pdf.dart';
import '../../layout/account/presentation/guest_screen.dart';
import '../logic/law_guide_cubit.dart';
import 'law_data_screen.dart';

class LawsFromSub extends StatelessWidget {
  LawsFromSub(
      {super.key,
      required this.title,
      required this.subId,
      this.arPdfUrl,
      this.enPdfUrl,
      this.enwordUrl,
      this.arwordUrl});

  final String title;
  final String subId;

  String? arPdfUrl;
  String? enPdfUrl;
  String? enwordUrl;
  String? arwordUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: getit<LawGuideCubit>()..getLawsGuideSubFromSub(subId),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(title,
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.black,
                )),
          ),
          body: BlocConsumer<LawGuideCubit, LawGuideState>(
            listener: (context, state) {},
            builder: (context, state) {
              var userType = CacheHelper.getData(key: 'userType');
              return userType == "guest"
                  ? const GestScreen()
                  : ConditionalBuilder(
                      condition: getit<LawGuideCubit>().lawResponse == null,
                      builder: (context) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      },
                      fallback: (context) {
                        return Animate(
                            effects: [FadeEffect(delay: 200.ms)],
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20.0.w, vertical: 20.0.h),
                                    child: CupertinoTextField(
                                      placeholder: 'قم بالبحث في $title',
                                      placeholderStyle: TextStyles
                                          .cairo_14_semiBold
                                          .copyWith(color: appColors.grey15),
                                      prefix: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(
                                          CupertinoIcons.search,
                                          color: appColors.grey15,
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          color:
                                              appColors.grey15.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      clearButtonMode:
                                          OverlayVisibilityMode.editing,
                                      clearButtonSemanticLabel: 'مسح',
                                      readOnly: true,
                                      onTap: () {
                                        Map<String, String> data = {
                                          'searchTerm': '',
                                          'lawGuideSubCategoryId': subId,
                                        };

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LawGuideSearch(
                                                      title:
                                                          'البحث في دليل الأنظمة',
                                                      data: data),
                                            ));
                                      },
                                    ),
                                  ),
                                  const LawsGuideBodyWidget(),
                                ],
                              ),
                            ));
                      });
            },
          ),
          floatingActionButton: BlocBuilder<LawGuideCubit, LawGuideState>(
            builder: (context, state) {
              return ConditionalBuilder(
                condition: getit<LawGuideCubit>().lawResponse != null,
                builder: (BuildContext context) => Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      heroTag: 'fab1',
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                      onPressed: () {
                        // open bottom sheet
                        showBottomModalDialog(
                            context: context,
                            isLight: true,
                            children: [
                              verticalSpace(10.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 50.w,
                                      height: 5.h,
                                      decoration: BoxDecoration(
                                          color: appColors.grey5,
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                ],
                              ),
                              verticalSpace(10.h),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.0.w),
                                child: Text('تحميل القانون',
                                    style: TextStyles.cairo_14_bold.copyWith(
                                      color: appColors.blue100,
                                    )),
                              ),
                              verticalSpace(10.h),
                              ListTile(
                                title: Text('النسخه العربية - PDF',
                                    style:
                                        TextStyles.cairo_14_semiBold.copyWith(
                                      color: appColors.black,
                                    )),
                                onTap: () {
                                  if (arPdfUrl != null) {
                                    print(arPdfUrl);
                                    // open pdf
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PdfWebView(
                                            link: arPdfUrl!,
                                          ),
                                        ));
                                  } else {
                                    context.pop();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('لا يوجد ملف PDF'),
                                      ),
                                    );
                                  }
                                },
                                leading: const Icon(
                                  FontAwesomeIcons.filePdf,
                                  color: Colors.red,
                                ),
                              ),
                              ListTile(
                                title: Text('النسخه الانجليزية - PDF',
                                    style:
                                        TextStyles.cairo_14_semiBold.copyWith(
                                      color: appColors.black,
                                    )),
                                leading: const Icon(
                                  FontAwesomeIcons.filePdf,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  if (enPdfUrl != null) {
                                    print(enPdfUrl);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PdfWebView(
                                            link: enPdfUrl!,
                                          ),
                                        ));
                                  } else {
                                    context.pop();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('لا يوجد ملف PDF'),
                                      ),
                                    );
                                  }
                                },
                              ),
                              ListTile(
                                title: Text('Word - النسخه العربية',
                                    style:
                                        TextStyles.cairo_14_semiBold.copyWith(
                                      color: appColors.black,
                                    )),
                                onTap: () {
                                  if (arwordUrl != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PdfWebView(
                                            link: arwordUrl!,
                                          ),
                                        ));
                                  } else {
                                    context.pop();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('لا يوجد ملف WORD'),
                                      ),
                                    );
                                  }
                                },
                                leading: const Icon(
                                  FontAwesomeIcons.noteSticky,
                                  color: Colors.blueAccent,
                                ),
                              ),
                              ListTile(
                                title: Text('Word - النسخه الانجليزية',
                                    style:
                                        TextStyles.cairo_14_semiBold.copyWith(
                                      color: appColors.black,
                                    )),
                                onTap: () {
                                  if (enwordUrl != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PdfWebView(
                                            link: enwordUrl!,
                                          ),
                                        ));
                                  } else {
                                    context.pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('لا يوجد ملف WORD'),
                                      ),
                                    );
                                  }
                                },
                                leading: const Icon(FontAwesomeIcons.noteSticky,
                                    color: Colors.blueAccent),
                              ),
                            ]);
                      },
                      backgroundColor: appColors.primaryColorYellow,
                      child: const Icon(
                        FontAwesomeIcons.filePdf,
                        color: Colors.white,
                      ),
                    ),
                    verticalSpace(10.h),
                    FloatingActionButton(
                      heroTag: 'fab2',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LawsDataScreen(
                                title: title,
                              ),
                            ));
                      },
                      backgroundColor: appColors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45),
                      ),
                      child: const Icon(
                        CupertinoIcons.eye_solid,
                        color: appColors.primaryColorYellow,
                      ),
                    ),
                  ],
                ),
                fallback: (BuildContext context) {
                  return const SizedBox();
                },
              );
            },
          ),
        ));
  }

  showBottomModalDialog({
    required BuildContext context,
    required bool isLight,
    required List<Widget> children,
  }) {
    showCupertinoModalPopup(
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        context: context,
        builder: (BuildContext modalContext) => Container(
            height: 300.h,
            decoration: const BoxDecoration(
              color: appColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            child: Material(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25.0)),
                color: appColors.white,
                child: Column(
                    mainAxisSize: MainAxisSize.max, children: children))));
  }
}
