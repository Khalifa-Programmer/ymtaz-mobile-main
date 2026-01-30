import 'package:flutter/material.dart';
import 'package:yamtaz/feature/layout/services/presentation/widgets/no_data_services.dart';
import 'package:yamtaz/feature/library_guide/presentation/widgets/sub_category/sub_category_body.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../data/model/books_response.dart';

class SubCategoryBooks extends StatelessWidget {
  const SubCategoryBooks({super.key, required this.data, required this.title});

  final List<SubCategory> data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title,
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: data.isEmpty
          ? const Center(
              child: NodataFound(),
            )
          : SubBooksBody(
              data: data,
            ),
    );
  }
}
