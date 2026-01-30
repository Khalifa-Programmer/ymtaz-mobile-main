import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/layout/layout/view/widgets/custom_bottom_bar/custom_bottom_bar.dart';

import '../logic/layout_cubit.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutState>(
        builder: (BuildContext context, state) {
          LayoutCubit mainPagesCubit = LayoutCubit.get(context);

          return Scaffold(
            key: mainPagesCubit.scaffoldKey,
            body: mainPagesCubit.pages[mainPagesCubit.currentIndex],
            bottomNavigationBar: ClipRRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: CustomBottomAppBar(context))),
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
