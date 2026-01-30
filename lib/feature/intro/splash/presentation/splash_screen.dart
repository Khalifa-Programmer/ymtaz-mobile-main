import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upgrader/upgrader.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/network/error/api_result.dart';
import 'package:yamtaz/core/network/remote/api_service.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/intro/splash/model/splash_response.dart';
import 'package:yamtaz/feature/layout/account/logic/my_account_cubit.dart';
import 'package:yamtaz/feature/layout/layout/view/layout_screen.dart';

import '../../../../core/network/local/cache_helper.dart';
import '../../on_board/presentation/view/on_board_screen.dart';

class CircleClipper extends CustomClipper<Path> {
  final double progress;
  final Offset center;

  CircleClipper({
    required this.progress,
    required this.center,
  });

  @override
  Path getClip(Size size) {
    // Calculate the maximum radius needed to cover the entire screen
    final maxRadius = (size.width + size.height) * 1.5;
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: center,
          radius: maxRadius * progress,
        ),
      );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final Upgrader upgrader;
  late AnimationController _animationController;
  late Animation<double> _animation;
  Widget? _nextScreen;
  bool _isAnimating = false;
  bool _hasNavigated = false;
  late AnimationController _gradientController;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    super.initState();
    _initAnimationController();
    _initGradientAnimation();
    getit<MyAccountCubit>().loading();
    // _initUpgrader();
    _initSplashScreen(); // Call _initSplashScreen here
  }

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Navigate after animation completes
        // _actualNavigation();
      }
    });
  }

  void _initGradientAnimation() {
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _colorTween = ColorTween(
      begin: appColors.blue100,
      end: appColors.blue70,
    ).animate(_gradientController);
  }

  void _initUpgrader() {
    upgrader = Upgrader(
      debugLogging: true,
      messages: UpgraderMessages(code: 'ar'),
      durationUntilAlertAgain: const Duration(minutes: 3),
    );
  }

  Future<void> _initSplashScreen() async {
    Timer(
      const Duration(seconds: 2),
      () async {
        await _prepareNavigation();
      },
    );
  }

  Future<void> _prepareNavigation() async {
    if (_isAnimating || _hasNavigated) return; // Check if already navigating
    _isAnimating = true;

    var rememberMe = CacheHelper.getData(key: 'token');
    Widget nextScreen =
        const OnboardingScreen(); // Initialize with a default value

    if (rememberMe == null) {
      // Prepare OnBoard screen
      nextScreen =
          const OnboardingScreen(); // Replace with your actual OnBoard screen widget
    } else {
      final response = await profile();
      await response.when(
        success: (loginResponse) async {
          getit<MyAccountCubit>().sendFcmToken();
          // await getit<NotificationCubit>().getNotifications();
          nextScreen =
              const LayoutScreen(); // Replace with your actual Home layout widget
        },
        failure: (fail) {
          nextScreen =
              const OnboardingScreen(); // Replace with your actual Login screen widget
        },
      );
    }

    setState(() {
      _nextScreen = nextScreen;
    });

    // Start the circle animation only if _nextScreen is not null
    if (_nextScreen != null) {
      await _animationController.forward();
    }
  }

  void _actualNavigation() {
    if (_nextScreen != null && !_hasNavigated) {
      _hasNavigated = true;
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => _nextScreen!,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        (route) => false,
      );
    }
  }

  Future<ApiResult<SplashResponse>> profile() async {
    ApiService apiService = getit<ApiService>();
    var token = CacheHelper.getData(key: 'token');
    var userType = CacheHelper.getData(key: 'userType');
    try {
      final SplashResponse response;
      if (userType == "client") {
        response = await apiService.checkClient(token);
      } else {
        response = await apiService.checkProvider(token);
      }
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(error);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final center = Offset(screenSize.width / 2, screenSize.height / 2);

    return Scaffold(
      body: Stack(
        children: [
          // Animated Gradient Background
          AnimatedBuilder(
            animation: _colorTween,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _colorTween.value!,
                      appColors.blue100,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),
          // Main Splash Content
          Animate(
            effects: [FadeEffect(delay: 500.ms, duration: 1000.ms)],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                verticalSpace(350.h),
                Center(
                  child: SvgPicture.asset(
                    AppAssets.mainLogo, // Replace with your SVG path
                    height: 140,
                    colorFilter: ColorFilter.mode(
                        appColors.primaryColorYellow, BlendMode.srcIn),
                  )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .scale(
                        begin: const Offset(0.5, 0.5),
                        end: const Offset(1, 1),
                        duration: 600.ms,
                      )
                      .then()
                      .then(),
                ),
                const Spacer(),
                Center(
                  child: Text(
                    " © أركان الطيف ${DateTime.now().year}",
                    style: TextStyles.cairo_14_light
                        .copyWith(color: appColors.primaryColorYellow),
                  ),
                ),
                Center(
                  child: Text(
                    "جميع الحقوق محفوظة ",
                    style: TextStyles.cairo_14_light
                        .copyWith(color: appColors.primaryColorYellow),
                  ),
                ),
                verticalSpace(20.h),
              ],
            ),
          ),
          // Next Screen with Circle Clip
          if (_nextScreen != null)
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return ClipPath(
                  clipper: CircleClipper(
                    progress: _animation.value,
                    center: center,
                  ),
                  child: _nextScreen ??
                      Container(), // Ensure _nextScreen is not null
                );
              },
            ),
        ],
      ),
    );
  }
}
