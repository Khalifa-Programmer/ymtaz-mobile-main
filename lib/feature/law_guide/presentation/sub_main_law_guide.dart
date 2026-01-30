import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/feature/law_guide/presentation/widgets/sub_main_law_guide_body.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../logic/law_guide_cubit.dart';
import 'laws_guide_search.dart';

class SubMainLawGuide extends StatelessWidget {
  const SubMainLawGuide({super.key, required this.title, required this.mainId});

  final String title;
  final String mainId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<LawGuideCubit>()..getLawGuideSubFromMain(mainId),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title,
              style: TextStyles.cairo_14_bold.copyWith(
                color: appColors.black,
              )),
        ),
        body: BlocConsumer<LawGuideCubit, LawGuideState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return ConditionalBuilder(
                condition:
                    getit<LawGuideCubit>().lawGuideSubMainResponse == null,
                builder: (context) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
                fallback: (context) {
                  return Animate(
                      effects: [FadeEffect(delay: 200.ms)],
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0.w, vertical: 20.0.h),
                              child: CupertinoTextField(
                                placeholder: 'قم بالبحث في $title',
                                placeholderStyle: TextStyles.cairo_14_semiBold
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
                                    color: appColors.grey15.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8)),
                                clearButtonMode: OverlayVisibilityMode.editing,
                                clearButtonSemanticLabel: 'مسح',
                                readOnly: true,
                                onTap: () {
                                  Map<String, String> data = {
                                    'searchTerm': '',
                                    'lawGuideMainCategoryId': mainId,
                                  };

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LawGuideSearch(
                                            title: 'البحث في دليل الأنظمة',
                                            data: data),
                                      ));
                                },
                              ),
                            ),
                            SubMainLawGuideBodyWidget(
                              mainId: mainId.toString(),
                            ),
                          ],
                        ),
                      ));
                });
          },
        ),
      ),
    );
  }
}
