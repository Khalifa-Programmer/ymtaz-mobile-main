import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../layout/services/presentation/widgets/no_data_services.dart';
import '../../data/model/law_response.dart';
import '../../logic/law_guide_cubit.dart';

class LawsDataBody extends StatelessWidget {
  const LawsDataBody({super.key, required this.data, required this.index});

  final List<Datum> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(delay: 200.ms),
      ],
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data[index].name!,
                    maxLines: 5,
                    style: const TextStyle(
                      color: appColors.blue100,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.bold,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          Icons.copy_rounded,
                          color: appColors.primaryColorYellow,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: """
⚖️ يمتاز | دليل الأنظمة
•⁠  ⁠ ${context.read<LawGuideCubit>().lawResponse!.data!.lawGuide!.name}
                    •⁠  ⁠ ${data[index].name}
                    •⁠  ⁠ ${data[index].law}
                    
                    ${data[index].changes == null || data[index].changes!.isEmpty ? "" : "•⁠  ⁠تعديلات المادة:\n ${data[index].changes}"}
                    
                    ⏳ تصفح تطبيق يمتاز الآن :
                     https://onelink.to/bb6n4x"""));
                        }),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          Icons.share_rounded,
                          color: appColors.primaryColorYellow,
                        ),
                        onPressed: () async {
                          final RenderBox box =
                              context.findRenderObject() as RenderBox;
                          Share.share(
                            """
                    ⚖️ يمتاز | دليل الأنظمة
                    
                    •⁠  ⁠ا ${context.read<LawGuideCubit>().lawResponse!.data!.lawGuide!.name}
                    •⁠  ⁠ا ${data[index].name}
                     •⁠  ⁠ ${data[index].law}
                    
                    ${data[index].changes == null || data[index].changes!.isEmpty ? "" : "•⁠  ⁠تعديلات المادة:\n ${data[index].changes}"}
                    
                    ⏳ تصفح تطبيق يمتاز الآن :
                     https://onelink.to/bb6n4x""",
                            subject: 'يمتاز',
                            sharePositionOrigin:
                                box.localToGlobal(Offset.zero) & box.size,
                          );
                        }),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: const Icon(
                          Icons.translate_rounded,
                          color: appColors.primaryColorYellow,
                        ),
                        onPressed: () async {}),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: appColors.grey1,
                border: Border.all(color: appColors.grey2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data[index].law!,
                      style: const TextStyle(
                        color: appColors.blue100,
                        fontSize: 14,
                      )),
                  const SizedBox(height: 10),
                  Text(data[index].changes ?? "",
                      style: const TextStyle(
                        color: appColors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllLawsDataBody extends StatelessWidget {
  const AllLawsDataBody({super.key});

  @override
  Widget build(BuildContext context) {
    final lawGuideCubit = getit<LawGuideCubit>();

    return BlocProvider.value(
      value: lawGuideCubit,
      child: BlocConsumer<LawGuideCubit, LawGuideState>(
        listener: (context, state) {},
        builder: (context, state) {
          return RefreshIndicator(
            color: appColors.primaryColorYellow,
            onRefresh: () async {
              await lawGuideCubit.getLawsGuideSubFromSub(
                lawGuideCubit.lawResponse!.data!.lawGuide!.id!.toString(),
              );
            },
            child: lawGuideCubit.lawResponse == null ||
                    lawGuideCubit
                        .lawResponse!.data!.lawGuide!.laws!.data!.isEmpty
                ? const NodataFound()
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!lawGuideCubit.isLoading &&
                            !lawGuideCubit.isLoadingMore &&
                            scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent - 100) {
                          lawGuideCubit.getLawsGuideSubFromSub(
                            lawGuideCubit.lawResponse!.data!.lawGuide!.id!
                                .toString(),
                            loadMore: true,
                          );
                        }
                        return true;
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: lawGuideCubit.lawResponse!.data!
                                      .lawGuide!.laws!.data!.length +
                                  (lawGuideCubit.isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                if (lawGuideCubit.isLoadingMore &&
                                    index ==
                                        lawGuideCubit.lawResponse!.data!
                                            .lawGuide!.laws!.data!.length) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 40),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                }

                                return _buildLawItem(context, index);
                              },
                            ),
                          ),
                          if (lawGuideCubit.isLoading)
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        appColors.primaryColorYellow),
                                  ),
                                  SizedBox(height: 16),
                                  Text("جارٍ تحميل المحتوى...",
                                      style:
                                          TextStyle(color: appColors.grey15)),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildLawItem(BuildContext context, int index) {
    final lawGuideCubit = getit<LawGuideCubit>();
    final law = lawGuideCubit.lawResponse!.data!.lawGuide!.laws!.data![index];

    return Container(
      // padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.1),
        //     spreadRadius: 1,
        //     blurRadius: 3,
        //     offset: Offset(0, 2),
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${law.name!}:",
            style: TextStyle(
              color: appColors.primaryColorYellow,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            law.law!,
            style: TextStyle(
              color: appColors.blue100,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          if (law.changes != null && law.changes!.isNotEmpty)
            Text(
              law.changes!,
              style: TextStyle(
                color: appColors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}
