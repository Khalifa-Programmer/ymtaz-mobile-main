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

class AboutYmtaz extends StatelessWidget {
  const AboutYmtaz({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<ContactYmtazCubit>()..getAboutUs(),
      child: BlocBuilder<ContactYmtazCubit, ContactYmtazState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('عن يمتاز',
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: ConditionalBuilder(
                    condition: state is LoadedAboutUs,
                    builder: (BuildContext context) {
                      final aboutData = (state as LoadedAboutUs).data;
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'من نحن',
                              style: TextStyles.cairo_14_bold.copyWith(
                                color: appColors.primaryColorYellow,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              aboutData.data!.description!,
                              style: TextStyles.cairo_14_medium.copyWith(
                                color: appColors.black,
                              ),
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
}
