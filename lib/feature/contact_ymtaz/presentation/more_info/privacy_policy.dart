import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/themes/styles.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../logic/contact_ymtaz_cubit.dart';
import '../../logic/contact_ymtaz_state.dart';
class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<ContactYmtazCubit>()..getPrivacyPolicy(),
      child: BlocBuilder<ContactYmtazCubit, ContactYmtazState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('سياسة الخصوصية',
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: ConditionalBuilder(
                    condition: state is LoadedPrivacyPolicy,
                    builder: (BuildContext context) {
                      final privacy = (state as LoadedPrivacyPolicy).data;
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'سياسة الخصوصية',
                              style: TextStyles.cairo_18_bold.copyWith(
                                color: appColors.primaryColorYellow,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            _buildFormattedText(
                              privacy.data!.description ?? '',
                              context,
                            ),
                          ],
                        ),
                      );
                    },
                    fallback: (BuildContext context) => const Center(
                          child: CupertinoActivityIndicator(),
                        )),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormattedText(String text, BuildContext context) {
    // Split by newlines to handle each paragraph/title separately
    final List<String> lines = text.split('\n');
    final List<Widget> widgets = [];

    for (String line in lines) {
      if (line.trim().isEmpty) {
        widgets.add(SizedBox(height: 10.h));
        continue;
      }

      bool isTitle = line.trim().startsWith('(') && line.trim().endsWith(')');
      
      final spans = _getSpansForText(line.trim());

      widgets.add(
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: RichText(
            textAlign: isTitle ? TextAlign.start : TextAlign.justify,
            text: TextSpan(
              children: spans,
              style: isTitle 
                ? TextStyles.cairo_14_bold.copyWith(color: appColors.blue100, height: 1.6)
                : TextStyles.cairo_14_medium.copyWith(color: appColors.black, height: 1.6),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  List<TextSpan> _getSpansForText(String text) {
    const String targetWord = "يمتاز";
    final List<TextSpan> spans = [];
    
    // Simple split for "يمتاز" highlight within each line
    final parts = text.split(targetWord);
    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i]));
      if (i < parts.length - 1) {
        spans.add(TextSpan(
          text: targetWord,
          style: TextStyle(
            color: appColors.primaryColorYellow,
            fontWeight: FontWeight.bold,
          ),
        ));
      }
    }
    return spans;
  }
}
