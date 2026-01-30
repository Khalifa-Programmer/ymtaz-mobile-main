import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/feature/library_guide/logic/library_cubit.dart';
import 'package:yamtaz/feature/library_guide/presentation/widgets/main_category/main_books_category_body.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';

class MainBooksCategoryScreen extends StatelessWidget {
  const MainBooksCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LibraryCubit, LibraryState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return PopScope(
          onPopInvoked: (didPop) {
            getit<LibraryCubit>().clearData();
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text("مكتبة يمتاز",
                  style: TextStyles.cairo_14_bold.copyWith(
                    color: appColors.black,
                  )),
            ),
            body: getit<LibraryCubit>().booksResponse == null
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : MainBooksBody(
                    data: getit<LibraryCubit>()
                        .booksResponse!
                        .data!
                        .booksMainCategories!,
                  ),
          ),
        );
      },
    );
  }
}
