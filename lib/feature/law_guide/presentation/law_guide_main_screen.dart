import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/feature/law_guide/logic/law_guide_cubit.dart';
import 'package:yamtaz/feature/law_guide/presentation/widgets/main_law_guide_body.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';
import 'laws_guide_search.dart';

class LawGuideMainScreen extends StatelessWidget {
  LawGuideMainScreen({super.key});

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LawGuideCubit, LawGuideState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return PopScope(
          onPopInvoked: (didPop) {
            getit<LawGuideCubit>().clearData();
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("دليل الأنظمة",
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
            ),
            body: ConditionalBuilder(
                condition: getit<LawGuideCubit>().lawGuideMainResponse == null,
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
                                placeholder: 'قم بالبحث في دليل الأنظمة',
                                placeholderStyle: TextStyles.cairo_14_semiBold
                                    .copyWith(color: appColors.grey15),
                                prefix: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    CupertinoIcons.search,
                                    color: appColors.grey15,
                                  ),
                                ),
                                focusNode: focusNode,
                                readOnly: true,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: appColors.grey15.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8)),
                                clearButtonMode: OverlayVisibilityMode.editing,
                                clearButtonSemanticLabel: 'مسح',
                                onTap: () {
                                  Map<String, String> data = {
                                    'searchTerm': '',
                                  };
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LawGuideSearch(
                                            title: 'البحث في دليل الأنظمة',
                                            data: data),
                                      ));
                                  focusNode.unfocus();
                                },
                              ),
                            ),
                            const MainLawGuideBodyWidget(),
                          ],
                        ),
                      ));
                }),
          ),
        );
      },
    );
  }
}
