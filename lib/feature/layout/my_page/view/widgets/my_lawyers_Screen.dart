import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/feature/layout/my_page/data/model/my_lawyers_response.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/widgets/spacing.dart';
import '../../logic/my_page_cubit.dart';
import '../../logic/my_page_state.dart';
import '../../../../layout/services/presentation/widgets/no_data_services.dart';



class MyLawyers extends StatelessWidget {
  const MyLawyers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'عملائي',
          style: TextStyles.cairo_16_bold.copyWith(
            color: appColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocProvider.value(
        value: getit<MyPageCubit>()..getMyLawyers(),
        child: BlocConsumer<MyPageCubit, MyPageState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return state is LoadingMyClients
                ? const Center(child: CircularProgressIndicator())
                : state is LoadedMyClients
                    ? state.data.data!.clients!.isEmpty
                        ? NoProducts(text: 'عملاء')
                        : ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.data.data!.clients!.length,
                            itemBuilder: (context, index) {
                              return _buildCategoryItem(
                                  state.data.data!.clients!, context, index);
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: const Divider(
                                  thickness: 0.5,
                                ),
                              );
                            },
                          )
                    : const Center(child: Text('error'));
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      List<Client> category, BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.04),
            // Shadow color
            spreadRadius: 3,
            // Spread radius
            blurRadius: 10,
            // Blur radius
            offset: const Offset(0, 3), // Offset in x and y direction
          ),
        ],
        shape: RoundedRectangleBorder(
          // side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(category[index].image ??
                    "https://api.ymtaz.sa/uploads/person.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.0.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${category[index].name}",
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.blue100,
                  )),
              verticalSpace(6.h),
              Row(
                children: [
                  Icon(
                    CupertinoIcons.location_solid,
                    color: appColors.primaryColorYellow,
                    size: 20.sp,
                  ),
                  horizontalSpace(0.w),
                  Text(category[index].city!.title ?? "",
                      style: TextStyles.cairo_12_semiBold),
                ],
              )
            ],
          ),
          // Spacer(),
          // Container(
          //   margin: EdgeInsets.only(left: 0.w),
          //   padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          //   decoration: BoxDecoration(
          //     color: appColors.lightYellow10,
          //     borderRadius: BorderRadius.circular(6.r),
          //   ),
          //   child: Text(,
          //       style: TextStyles.cairo_12_semiBold.copyWith(
          //         color: appColors.blue100,
          //       )),
          // )
        ],
      ),
    );
  }
}
