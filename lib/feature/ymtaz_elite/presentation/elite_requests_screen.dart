import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/app_bar.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/ymtaz_elite_cubit.dart';

import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';

class EliteRequestsScreen extends StatelessWidget {
  const EliteRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<YmtazEliteCubit>()..getEliteRequests(),
      child: Scaffold(
        extendBody: true,
        appBar: buildBlurredAppBar(context, "طلبات هيئة المستشارين"),
        body: BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
          builder: (context, state) {
            if (state is YmtazEliteLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is YmtazEliteRequestsLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: state.requests.length,
                itemBuilder: (context, index) {
                  final request = state.requests[index];
                  return InkWell(
                    onTap: () {
                      context.pushNamed(
                        Routes.eliteRequestDetails,
                        arguments: request,
                      );

                      print(request.offers);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: appColors.grey15.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                request.eliteServiceCategory!.name!,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: appColors.blue100,
                                ),
                              ),
                              horizontalSpace(5.w),
                              Text(
                                getDate(request.createdAt),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFDF6E9),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: const Color(0xFFCEAD6B),
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      'بانتظار التسعير',
                                      style: TextStyle(
                                        color: Color(0xFFCEAD6B),
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Divider(
                            color: appColors.grey15.withOpacity(0.3),
                            thickness: 1,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    AssetImage("assets/svgs/elite.png"),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "فزيق استشاري",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B3149),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is YmtazEliteError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No requests found.'));
            }
          },
        ),
      ),
    );
  }
}
