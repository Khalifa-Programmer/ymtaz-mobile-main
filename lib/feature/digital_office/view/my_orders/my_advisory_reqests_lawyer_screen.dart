import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/widgets/app_bar.dart';
import '../../logic/office_provider_cubit.dart';
import '../../logic/office_provider_state.dart';
import '../widgets/my_advisories_screen.dart';

class MyAdvisroyLawyerScreen extends StatelessWidget {
  const MyAdvisroyLawyerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfficeProviderCubit, OfficeProviderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: buildBlurredAppBar(context, 'طلبات الاستشارات'),
          body: ConditionalBuilder(
            condition: getit<OfficeProviderCubit>().clientAdvisory != null,
            builder: (BuildContext context) => MyAdvisoryScreen(
                data: getit<OfficeProviderCubit>().clientAdvisory!),
            fallback: (BuildContext context) => const Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
        );
      },
    );
  }
}
