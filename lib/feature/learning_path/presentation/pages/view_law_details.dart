import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yamtaz/feature/learning_path/data/models/law_details_response.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_path_items_response.dart';
import '../../../../config/themes/styles.dart';
import '../../../../core/constants/assets.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../core/widgets/spacing.dart';
import '../../logic/learning_path_cubit.dart';
import '../../logic/learning_path_state.dart';





class ViewLawDetails extends StatefulWidget {
  List<ItemDetails> items;
  int currentIndex;
  final int pathId;

  ViewLawDetails({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.pathId,
  });

  @override
  State<ViewLawDetails> createState() => _ViewLawDetailsState();
}

class _ViewLawDetailsState extends State<ViewLawDetails> {
  @override
  void initState() {
    super.initState();
    getit<LearningPathCubit>()
        .getLawDetails(widget.items[widget.currentIndex].id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<LearningPathCubit>(),
      child: BlocConsumer<LearningPathCubit, LearningPathState>(
        listener: (context, state) {
          if (state is ReadingStateSuccess) {
            for (var pathItem in widget.items) {
              if (pathItem.id == widget.items[widget.currentIndex].id) {
                setState(() {
                  pathItem.alreadyDone = true;
                  if (widget.currentIndex + 1 < widget.items.length) {
                    widget.items[widget.currentIndex + 1].locked = false;
                  }
                });
                break;
              }
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );

            if (widget.currentIndex + 1 < widget.items.length) {
              setState(() {
                widget.currentIndex++;
                getit<LearningPathCubit>()
                    .getLawDetails(widget.items[widget.currentIndex].id);
              });
            }
          }

          if (state is ReadingStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }

          if (state is FavouriteSuccess) {
            setState(() {
              widget.items[widget.currentIndex].isFavourite = state.isFavourite;
            });
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }

          if (state is FavouriteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          var cubit = getit<LearningPathCubit>();
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                cubit.currentLaw?.name ?? 'تفاصيل المادة',
                style: TextStyles.cairo_14_bold.copyWith(
                  color: appColors.black,
                ),
              ),
            ),
            body: ConditionalBuilder(
              condition: cubit.currentLaw != null,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(20.h),
                      SvgPicture.asset(
                        AppAssets.logo,
                        color: appColors.primaryColorYellow,
                        width: 40.w,
                        height: 40.w,
                      ),
                      verticalSpace(10.h),
                      _buildLawContent(cubit.currentLaw!),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(24.sp),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.04),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  _buildInfoRow(
                                      "الاسم", cubit.currentLaw!.lawGuide.name),
                                  SizedBox(height: 5.h),
                                  _buildInfoRow(
                                      "تاريخ الإصدار",
                                      getDate(cubit
                                          .currentLaw!.lawGuide.releasedAt
                                          .toString())),
                                  SizedBox(height: 5.h),
                                  _buildInfoRow(
                                      "تاريخ النشر",
                                      getDate(cubit
                                          .currentLaw!.lawGuide.publishedAt
                                          .toString())),
                                  SizedBox(height: 5.h),
                                  _buildInfoRow(
                                      "تاريخ الإصدار هجري",
                                      getDate(cubit
                                          .currentLaw!.lawGuide.releasedAtHijri
                                          .toString())),
                                  SizedBox(height: 5.h),
                                  _buildInfoRow(
                                      "تاريخ النشر هجري",
                                      getDate(cubit
                                          .currentLaw!.lawGuide.publishedAtHijri
                                          .toString())),
                                  SizedBox(height: 5.h),
                                  _buildInfoRow(
                                    "الحالة",
                                    cubit.currentLaw!.lawGuide.status == "1"
                                        ? "ساري"
                                        : "غير ساري",
                                    valueColor:
                                        cubit.currentLaw!.lawGuide.status == "1"
                                            ? appColors.primaryColorYellow
                                            : appColors.red,
                                  ),
                                  SizedBox(height: 5.h),
                                  _buildInfoRow("أداة إصدار النظام",
                                      cubit.currentLaw!.lawGuide.releaseTool),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              fallback: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            bottomNavigationBar: BottomAppBar(
              color: appColors.grey1,
              surfaceTintColor: appColors.grey1,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: widget.currentIndex > 0
                        ? () {
                            setState(() {
                              widget.currentIndex--;
                              context.read<LearningPathCubit>().getLawDetails(
                                widget.items[widget.currentIndex].id
                              );
                            });
                          }
                        : null,
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: (widget.currentIndex < widget.items.length - 1 &&
                            !widget.items[widget.currentIndex + 1].locked)
                        ? () {
                            setState(() {
                              widget.currentIndex++;
                              context.read<LearningPathCubit>().getLawDetails(
                                widget.items[widget.currentIndex].id
                              );
                            });
                          }
                        : null,
                  ),
                  BlocBuilder<LearningPathCubit, LearningPathState>(
                    buildWhen: (previous, current) => 
                      current is FavouriteLoading || 
                      current is FavouriteSuccess || 
                      current is FavouriteError,
                    builder: (context, state) {
                      final bool isFavourite = widget.items[widget.currentIndex].isFavourite;
                      final bool isLoading = state is FavouriteLoading;
                      
                      return IconButton(
                        icon: isLoading 
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(appColors.primaryColorYellow),
                              ),
                            )
                          : Icon(
                              isFavourite ? Icons.favorite : Icons.favorite_border,
                              color: isFavourite ? appColors.primaryColorYellow : null,
                            ),
                        onPressed: isLoading
                          ? null
                          : () {
                              context.read<LearningPathCubit>().toggleFavourite(
                                widget.items[widget.currentIndex].learningPathItemId,
                                isFavourite,
                              );
                            },
                      );
                    },
                  ),
                  Spacer(),
                  BlocBuilder<LearningPathCubit, LearningPathState>(
                    builder: (context, state) {
                      final bool isAlreadyRead = widget.items[widget.currentIndex].alreadyDone;
                      
                      return IconButton(
                        icon: state is ReadingStateLoading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeWidth: 2,
                              )
                            : Icon(
                                Icons.check,
                                color: isAlreadyRead ? appColors.grey3 : null,
                              ),
                        onPressed: (state is ReadingStateLoading || isAlreadyRead)
                            ? null
                            : () {
                                context.read<LearningPathCubit>().markAsRead(
                                  widget.items[widget.currentIndex].learningPathItemId,
                                  widget.pathId,
                                  widget.currentIndex,
                                );
                              },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLawContent(LawDetails law) {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                law.name,
                style: const TextStyle(
                  color: appColors.blue100,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  Icons.copy_rounded,
                  color: appColors.primaryColorYellow,
                ),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: """
⚖️ يمتاز | دليل الأنظمة
•⁠  ⁠اسم النظام: ${law.lawGuide.name}
•⁠  ⁠اسم المادة: ${law.name}
•⁠  ⁠نص المادة: ${law.law}

${law.changes == null || law.changes!.isEmpty ? "" : "•⁠  ⁠تعديلات المادة:\n ${law.changes}"}

⏳ تصفح تطبيق يمتاز الآن :
 https://onelink.to/bb6n4x"""));
                },
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  Icons.share_rounded,
                  color: appColors.primaryColorYellow,
                ),
                onPressed: () async {
                  final RenderBox box = context.findRenderObject() as RenderBox;
                  Share.share(
                    """
⚖️ يمتاز | دليل الأنظمة

•⁠  ⁠اسم النظام: ${law.lawGuide.name}
•⁠  ⁠اسم المادة: ${law.name}
•⁠  ⁠نص المادة: ${law.law}

${law.changes == null || law.changes!.isEmpty ? "" : "•⁠  ⁠تعديلات المادة:\n ${law.changes}"}

⏳ تصفح تطبيق يمتاز الآن :
 https://onelink.to/bb6n4x""",
                    subject: 'يمتاز',
                    sharePositionOrigin:
                        box.localToGlobal(Offset.zero) & box.size,
                  );
                },
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  Icons.translate_rounded,
                  color: appColors.primaryColorYellow,
                ),
                onPressed: () async {},
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
                Text(
                  law.name,
                  style: const TextStyle(
                    color: appColors.blue100,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  law.law,
                  style: const TextStyle(
                    color: appColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (law.changes != null && law.changes!.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Text(
                    law.changes!,
                    style: const TextStyle(
                      color: appColors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.cairo_12_semiBold.copyWith(
            color: appColors.blue100,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            value,
            style: TextStyles.cairo_12_semiBold.copyWith(
              color: valueColor ?? appColors.blue100,
            ),
            textAlign: TextAlign.end,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
