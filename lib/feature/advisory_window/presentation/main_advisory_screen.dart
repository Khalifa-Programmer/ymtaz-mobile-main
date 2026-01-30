import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/advisory_window/presentation/advisor_time_selection.dart';
import 'package:yamtaz/feature/advisory_window/presentation/select_lawyer_screen.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/colors.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/custom_stepper.dart';
import '../logic/advisory_cubit.dart';
import 'advisory_accurate_type.dart';
import 'advisory_general_type.dart';
import 'advisory_payment_screen.dart';
import 'advisory_request_details_screen.dart';
import 'advisory_type.dart';

class MainAdvisoryScreen extends StatefulWidget {
  const MainAdvisoryScreen({super.key});

  @override
  _MainAdvisoryScreenState createState() => _MainAdvisoryScreenState();
}

class _MainAdvisoryScreenState extends State<MainAdvisoryScreen>
    with TickerProviderStateMixin {
  final List<StepItem> _steps = [
    StepItem(
      title: Text(' '),
      content: AdvisoryType(),
      isActive: true,
    ),
    StepItem(
      title: Text(''),
      content: AdvisoryGeneralType(),
      isActive: true,
    ),
    StepItem(
      title: Text(''),
      content: AdvisoryAccurateType(),
      isActive: true,
    ),
    StepItem(
      title: Text(''),
      content: AdvisoryRequestDetailsScreen(key: UniqueKey()),
      isActive: true,
    ),
    StepItem(
      title: Text(''),
      content: SelectLawyerScreen(),
      isActive: true,
    ),
    StepItem(
      title: Text(''),
      content: AdvisoryPaymentScreen(),
      isActive: true,
    ),
  ];

  late AdvisoryCubit _advisoryCubit;
  late AnimationController _animationController;
  late Animation<double> _animation;
  int _previousStep = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _advisoryCubit = context.read<AdvisoryCubit>();
    if (_advisoryCubit.currentStep == 0) {
      _advisoryCubit.getAdvisoriesTypes();
    }
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    // Initialize the animation with default values
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _advisoryCubit.resetSteps();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الاستشارات',
          style: TextStyles.cairo_16_bold.copyWith(color: appColors.blue100),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: BlocBuilder<AdvisoryCubit, AdvisoryState>(
            builder: (context, state) {
              int currentStep = context.watch<AdvisoryCubit>().currentStep;
              double progress = (currentStep + 1) / _steps.length;

              if (state is AdvisoryStepChanged) {
                _animation = Tween<double>(
                  begin: (_previousStep + 1) / _steps.length,
                  end: progress,
                ).animate(_animationController);
                _animationController.forward(from: 0);
                _previousStep = currentStep;
              } else if (currentStep == 0) {
                _animation = Tween<double>(
                  begin: 1 / _steps.length,
                  end: 1 / _steps.length,
                ).animate(_animationController);

                if (!_animationController.isAnimating) {
                  _animationController.forward(from: 0);
                }
              }

              return AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return LinearProgressIndicator(
                    value: _animation.value,
                    backgroundColor: appColors.grey3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        appColors.primaryColorYellow),
                  );
                },
              );
            },
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            var oldStep = _advisoryCubit.currentStep;
            if (_advisoryCubit.currentStep == 0) {
              Navigator.pop(context);
            } else if (_advisoryCubit.currentStep == 3) {
              setState(() {
                _steps[3] = StepItem(
                  title: Text(''),
                  content: AdvisoryRequestDetailsScreen(key: UniqueKey()),
                  isActive: true,
                );
              });
              _advisoryCubit.previousStep();
            } else if (_advisoryCubit.currentStep == 5 &&
                _advisoryCubit.isNeedAppointment) {
              getit<AdvisoryCubit>().availableDatesResponse = null;
              setState(() {
                _steps[5] = StepItem(
                  title: Text(''),
                  content: AdvisorTimeSelection(),
                  isActive: true,
                );
              });
              _advisoryCubit.previousStep();
            } else {
              _advisoryCubit.previousStep();
            }
          },
        ),
      ),
      body: BlocBuilder<AdvisoryCubit, AdvisoryState>(
        builder: (context, state) {
          int currentStep = context.watch<AdvisoryCubit>().currentStep;
          print(_steps.length);
          if (_advisoryCubit.isNeedAppointment && _steps.length == 6) {
            _steps.insert(
                5,
                StepItem(
                  title: Text(''),
                  content: AdvisorTimeSelection(),
                  isActive: true,
                ));
          }
          if (_advisoryCubit.isNeedAppointment == false && _steps.length == 7) {
            _steps.removeAt(5);
          }

          if (state is AdvisoryStepChanged) {
            if (currentStep == 1) {
              _advisoryCubit.getGeneralTypesByAdvisoryId(
                  _advisoryCubit.selectedAdvisoryType.toString());
            } else if (currentStep == 2) {
              _advisoryCubit.getAccurateTypesByGeneralAndAdvisoryId(
                  _advisoryCubit.selectedAdvisoryType.toString(),
                  _advisoryCubit.selectedGeneralType.toString());
            } else if (currentStep == 3) {
            } else if (currentStep == 4) {
              _advisoryCubit.advisoryLawyersById(
                getit<AdvisoryCubit>().selectedAccurateData!.id.toString(),
                getit<AdvisoryCubit>().selectedLevel!.level!.id.toString(),
              );
            } else if (currentStep == 5 && _advisoryCubit.isNeedAppointment) {
              _advisoryCubit.getAvailableTimes(
                  getit<AdvisoryCubit>().selectedLawyer!.lawyer!.id.toString());
            }
          }
          return CustomStepper(
            currentStep: currentStep,

            steps: _steps,
            // controlsBuilder: (BuildContext context, ControlsDetails details) {
            //   return Container(); // Remove default controls
            // },
          );
        },
      ),
    );
  }
}
