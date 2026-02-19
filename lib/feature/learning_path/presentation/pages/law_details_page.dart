import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/learning_path/logic/law_details_cubit.dart';
import 'package:yamtaz/feature/learning_path/logic/law_details_state.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_cubit.dart';

import '../../data/models/law_details_response.dart';
import '../../data/repos/learning_path_repo.dart';

class LawDetailsPage extends StatefulWidget {
  final int lawId;
  final int learningPathItemId;
  final bool isRead;
  final int pathId;
  final bool isFavourite;

  const LawDetailsPage({
    super.key,
    required this.lawId,
    required this.learningPathItemId,
    required this.isRead,
    required this.pathId,
    this.isFavourite = false,
  });

  @override
  State<LawDetailsPage> createState() => _LawDetailsPageState();
}

class _LawDetailsPageState extends State<LawDetailsPage> {
  bool _isFavourite = false;

  @override
  void initState() {
    super.initState();
    _isFavourite = widget.isFavourite;
    _loadData();
  }

  void _loadData() {
    // context.read<LawDetailsCubit>().getLawDetails(widget.lawId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LearningPathCubit(getit<LearningPathRepo>()),
        ),
        BlocProvider(
          create: (context) => LawDetailsCubit(getit<LearningPathRepo>())..getLawDetails(widget.lawId),
        ),
      ],
      child: Scaffold(
        backgroundColor: appColors.grey1,
        appBar: AppBar(
          title: Text('تفاصيل المادة', style: TextStyles.cairo_15_bold),
          centerTitle: true,
          backgroundColor: appColors.white,
          elevation: 0,
        ),
        body: BlocBuilder<LawDetailsCubit, LawDetailsState>(
          builder: (context, state) {
            if (state is LawContentLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final law = context.read<LawDetailsCubit>().law;

            if (law != null) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLawHeader(law),
                        SizedBox(height: 16.h),
                        _buildLawContent(law),
                        SizedBox(height: 100.h),
                      ],
                    ),
                  ),
                ],
              );
            }

            if (state is LawContentError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: appColors.red, size: 48.r),
                    SizedBox(height: 16.h),
                    Text(
                      state.message,
                      style: TextStyles.cairo_14_medium,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: _loadData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.primaryColorYellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
        bottomNavigationBar: BlocConsumer<LawDetailsCubit, LawDetailsState>(
          listener: (context, state) {
            if (state is MarkedAsRead) {
              Navigator.pop(context, true);
            } else if (state is MarkAsReadError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: TextStyles.cairo_14_medium.copyWith(
                      color: appColors.white,
                    ),
                  ),
                  backgroundColor: appColors.red,
                ),
              );
            } else if (state is FavouriteSuccess) {
              setState(() {
                _isFavourite = state.isFavourite;
              });
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: TextStyles.cairo_14_medium.copyWith(
                      color: appColors.white,
                    ),
                  ),
                ),
              );
            } else if (state is FavouriteError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: TextStyles.cairo_14_medium.copyWith(
                      color: appColors.white,
                    ),
                  ),
                  backgroundColor: appColors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (widget.isRead) {
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: appColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: appColors.grey10.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<LawDetailsCubit, LawDetailsState>(
                      buildWhen: (previous, current) => 
                        current is FavouriteLoading || 
                        current is FavouriteSuccess || 
                        current is FavouriteError,
                      builder: (context, state) {
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
                                _isFavourite ? Icons.favorite : Icons.favorite_border,
                                color: _isFavourite ? appColors.primaryColorYellow : null,
                              ),
                          onPressed: isLoading
                            ? null
                            : () {
                                context.read<LawDetailsCubit>().toggleFavourite(
                                  widget.learningPathItemId,
                                  _isFavourite,
                                );
                              },
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: appColors.white,
                boxShadow: [
                  BoxShadow(
                    color: appColors.grey10.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  BlocBuilder<LawDetailsCubit, LawDetailsState>(
                    buildWhen: (previous, current) => 
                      current is FavouriteLoading || 
                      current is FavouriteSuccess || 
                      current is FavouriteError,
                    builder: (context, state) {
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
                              _isFavourite ? Icons.favorite : Icons.favorite_border,
                              color: _isFavourite ? appColors.primaryColorYellow : null,
                            ),
                        onPressed: isLoading
                          ? null
                          : () {
                              context.read<LawDetailsCubit>().toggleFavourite(
                                widget.learningPathItemId,
                                _isFavourite,
                              );
                            },
                      );
                    },
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: state is MarkingAsRead
                          ? null
                          : () => context.read<LawDetailsCubit>().markAsRead(
                                widget.learningPathItemId,
                                widget.pathId,
                              ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColors.primaryColorYellow,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: state is MarkingAsRead
                          ? SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(appColors.white),
                              ),
                            )
                          : Text(
                              'تمت القراءة',
                              style: TextStyles.cairo_14_bold.copyWith(
                                color: appColors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLawHeader(LawDetails law) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: appColors.grey10.withOpacity(0.06),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            law.lawGuide.name,
            style: TextStyles.cairo_16_bold.copyWith(
              color: appColors.blue100,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            law.name,
            style: TextStyles.cairo_14_semiBold,
          ),
        ],
      ),
    );
  }

  Widget _buildLawContent(LawDetails law) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: appColors.grey10.withOpacity(0.06),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(),
          Text(
            law.law,
            style: TextStyles.cairo_14_regular,
          ),
          if (law.changes != null && law.changes!.isNotEmpty) ...[
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: appColors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'التعديلات:',
                    style: TextStyles.cairo_14_bold.copyWith(
                      color: appColors.red,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    law.changes!,
                    style: TextStyles.cairo_13_regular.copyWith(
                      color: appColors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
} 
