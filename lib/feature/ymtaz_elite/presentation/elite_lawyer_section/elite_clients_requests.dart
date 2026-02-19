import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../logic/ymtaz_elite_cubit.dart';
import 'elite_client_order_screen.dart';

class EliteClientsRequests extends StatefulWidget {
  const EliteClientsRequests({super.key});

  @override
  State<EliteClientsRequests> createState() => _EliteClientsRequestsState();
}

class _EliteClientsRequestsState extends State<EliteClientsRequests> {
  late final YmtazEliteCubit _cubit;
  
  @override
  void initState() {
    super.initState();
    _cubit = context.read<YmtazEliteCubit>();
    _loadData();
  }

  Future<void> _loadData() async {
    await _cubit.getPricingRequests();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: buildBlurredAppBar(context, 'طلبات العملاء'),
        body: RefreshIndicator(
          onRefresh: _loadData,
          child: BlocBuilder<YmtazEliteCubit, YmtazEliteState>(
            builder: (context, state) {
              if (state is YmtazEliteLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is YmtazElitePricingRequestsLoaded) {
                if (state.requests.isEmpty) {
                  return Center(child: Text('لا توجد طلبات'));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: state.requests.length,
                  itemBuilder: (context, index) {
                    final request = state.requests[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.w),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 16.h),
                      child: ListTile(
                        title: Text(request.eliteServiceCategory?.name ?? '' , style: TextStyle(fontSize: 16.sp , fontWeight: FontWeight.bold),),
                        subtitle: Text('${getTimeDate(request.createdAt!)} - ${getTime(request.createdAt! ?? '')}'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          _cubit.selectRequest(request);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: _cubit,
                                child: EliteClientOrderScreen(cubit: _cubit),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
              return Center(
                child: TextButton(
                  onPressed: _loadData,
                  child: const Text('إعادة المحاولة'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
