import 'package:easy_localization/easy_localization.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_cubit.dart';
import 'package:yamtaz/feature/learning_path/logic/learning_path_state.dart';
import 'package:yamtaz/feature/learning_path/data/models/learning_paths_response.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';

class TrainingMainScreen extends StatefulWidget {
  const TrainingMainScreen({super.key});

  @override
  State<TrainingMainScreen> createState() => _TrainingMainScreenState();
}

class _TrainingMainScreenState extends State<TrainingMainScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      getit<LearningPathCubit>().getLearningPaths();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = getit<LearningPathCubit>();
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => cubit.getLearningPaths(),
            child: SingleChildScrollView(
              key: const ValueKey('training_scroll_view'),
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  const HomeHeader(),
                  const DiscountBanner(),
                  const Categories(),
                  BlocBuilder<LearningPathCubit, LearningPathState>(
                    builder: (context, state) {
                      if (state is LearningPathsLoading) {
                        return _buildShimmerSection();
                      } else if (state is LearningPathsLoaded) {
                        return Column(
                          children: [
                            Lastet(paths: state.paths.take(3).toList()),
                            SuggestedCourses(paths: state.paths.skip(3).toList()),
                          ],
                        );
                      } else if (state is LearningPathError) {
                        return Center(child: Text(state.message));
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(height: 200.h, color: Colors.grey[200]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(height: 150.h, color: Colors.grey[200]),
        ),
      ],
    );
  }
}

class SuggestedCourses extends StatelessWidget {
  final List<LearningPath> paths;
  const SuggestedCourses({super.key, required this.paths});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SectionTitle(
          title: "الدورات المقترحة",
          press: () {},
        ),
      ),
      ...paths.map((path) => ResponsiveListTile(path: path)).toList(),
    ]);
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: appColors.blue100,
                  size: 20.sp,
                ),
              ),
              Expanded(
                child: Text(
                  LocaleKeys.trainingPlatform.tr(),
                  style: TextStyles.cairo_18_bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          verticalSpace(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: SearchField()),
              const SizedBox(width: 16),
              IconBtnWithCounterIconData(
                svgSrc: Icons.filter_list,
                press: () {},
              ), // filter icon
            ],
          ),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged: (value) {},
        decoration: InputDecoration(
          filled: true,
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          fillColor: const Color(0xFF979797).withOpacity(0.1),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide.none,
          ),
          hintText: "بحث",
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}

class IconBtnWithCounterIconData extends StatelessWidget {
  const IconBtnWithCounterIconData({
    super.key,
    required this.svgSrc,
    this.numOfitem = 0,
    required this.press,
  });

  final IconData svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF979797).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(svgSrc),
          ),
          if (numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(237, 214, 166, 1),
            // Color(red: 0.93, green: 0.84, blue: 0.65)
            Color.fromRGBO(222, 184, 97, 1),
            // Color(red: 0.87, green: 0.72, blue: 0.38)
          ],
          stops: [0.08, 1.0],
          begin: Alignment(-1, -0.34),
          end: Alignment(1, 1),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "العرض الخاص\n"),
            TextSpan(
              text: "احصل على خصم 20% على دورتك الأولى",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": AppAssets.appointments, "text": "العروض"},
      {"icon": AppAssets.appointments, "text": "دوراتي"},
      {"icon": AppAssets.appointments, "text": "المفضلة"},
      {"icon": AppAssets.appointments, "text": "الاقسام"},
      {"icon": AppAssets.appointments, "text": "المزيد"},
    ];
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {},
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.icon,
    required this.text,
    required this.press,
  });

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: appColors.lightYellow10,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.asset(icon),
          ),
          const SizedBox(height: 4),
          Text(text, textAlign: TextAlign.center)
        ],
      ),
    );
  }
}

class Lastet extends StatelessWidget {
  final List<LearningPath> paths;
  const Lastet({
    super.key,
    required this.paths,
  });

  @override
  Widget build(BuildContext context) {
    if (paths.isEmpty) return const SizedBox();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: "أضيف مؤخراً",
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: paths.map((path) => CourseCard(
                  category: "الدورات",
                  image: "https://i.postimg.cc/yY2bNrmd/Image-Banner-2.png",
                  numOfBrands: 0,
                  path: path,
                  press: () {
                    Navigator.pushNamed(
                      context,
                      Routes.learningPath,
                      arguments: path.id,
                    );
                  },
                )).toList(),
          ),
        ),
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
    required this.path,
  });

  final String category, image;
  final int numOfBrands;
  final LearningPath path;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: 242.w,
        height: 280.h,
        child: Container(
          margin: EdgeInsets.all(12.sp),
          padding: EdgeInsets.all(12.sp),
          decoration: ShapeDecoration(
            color: appColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.sp),
            ),
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
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  image,
                  height: 100.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                verticalSpace(10.h),
                Text(
                  path.title,
                  style: TextStyles.cairo_12_semiBold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpace(10.h),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15.sp,
                      backgroundColor: appColors.grey1,
                      child: Icon(Icons.person, size: 20.sp, color: appColors.grey10),
                    ),
                    horizontalSpace(10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "أكاديمية يمتاز",
                          style: TextStyles.cairo_12_bold,
                        ),
                        Text(
                          "محاضر",
                          style: TextStyles.cairo_10_regular,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.press,
  });

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: press,
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: const Text("المزيد"),
        ),
      ],
    );
  }
}

class ResponsiveListTile extends StatelessWidget {
  final LearningPath path;
  const ResponsiveListTile({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.learningPath,
          arguments: path.id,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
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
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  'https://mohamedkotp.com/wp-content/uploads/2024/08/Paralegal_vs._Lawyer.jpeg.jpg',
                  // Replace with your image URL
                  height: 110.h,
                  width: 80.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'أكاديمية يمتاز',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: appColors.primaryColorYellow,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    path.title,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: appColors.blue100),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'مسار تدريبي شامل يغطي الجوانب النظرية والعملية لتطوير المهارات القانونية والمهنية.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
