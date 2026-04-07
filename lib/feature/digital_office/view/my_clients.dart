import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/feature/digital_office/data/models/my_clients_response.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/spacing.dart';
import '../logic/office_provider_cubit.dart';
import '../logic/office_provider_state.dart';
import 'client_profile_screen.dart';
import '../../layout/services/presentation/widgets/no_data_services.dart';
import 'package:cached_network_image/cached_network_image.dart';


class MyClients extends StatelessWidget {
  const MyClients({super.key});

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
        value: getit<OfficeProviderCubit>()..getMyClients(),
        child: BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return state is LoadingMyClients
                ? const Center(child: CircularProgressIndicator())
                : state is LoadedMyClients
                    ? () {
                        final currentUserId = getit<MyAccountCubit>().userDataResponse?.data?.account?.id ?? 
                                             getit<MyAccountCubit>().clientProfile?.data?.account?.id;
                        final filteredClients = state.data.data!.clients!.where(
                          (client) => client.id.toString() != currentUserId.toString()
                        ).toList();

                        return filteredClients.isEmpty
                            ? NoProducts(text: 'عملاء')
                            : ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: filteredClients.length,
                                itemBuilder: (context, index) {
                                  return _buildCategoryItem(
                                      filteredClients, context, index);
                                },
                                separatorBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5.h),
                                    child: const Divider(
                                      thickness: 0.5,
                                    ),
                                  );
                                },
                              );
                      }()
                    : const Center(child: Text('error'));
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(
      List<Client> category, BuildContext context, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClientProfileScreen(client: category[index]),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: ShapeDecoration(
          color: Colors.white,
          shadows: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.04),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1, 
              color: index % 4 < 2 
                  ? appColors.primaryColorYellow.withOpacity(0.3) 
                  : appColors.blue90.withOpacity(0.3)
            ),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: index % 4 < 2 
                      ? appColors.primaryColorYellow 
                      : appColors.blue90,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: category[index].image ?? "https://ymtaz.sa/uploads/person.png",
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 50.w,
                    height: 50.h,
                    color: appColors.grey.withOpacity(0.3),
                    child: Icon(Icons.person, size: 25.w, color: appColors.grey),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 50.w,
                    height: 50.h,
                    color: appColors.grey.withOpacity(0.3),
                    child: Icon(Icons.person, size: 25.w, color: appColors.grey),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.0.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category[index].name ?? 'بدون اسم',
                    style: TextStyles.cairo_14_bold.copyWith(
                      color: appColors.blue100,
                    ),
                  ),
                  verticalSpace(4.h),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.location_solid,
                        color: appColors.primaryColorYellow,
                        size: 16.sp,
                      ),
                      horizontalSpace(4.w),
                      Text(
                        category[index].city?.title ?? "",
                        style: TextStyles.cairo_12_semiBold.copyWith(
                          color: appColors.grey15,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: appColors.grey,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
