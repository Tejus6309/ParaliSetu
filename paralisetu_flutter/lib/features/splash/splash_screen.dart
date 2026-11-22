import 'package:flutter/material.dart';
import '../../core/constants.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onFinish;

  const SplashScreen({super.key, required this.onFinish});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _seedDropAnimation;
  late final Animation<double> _sproutAnimation;
  late final Animation<double> _emblemAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    );

    _seedDropAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOutBack),
    );

    _sproutAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 0.70, curve: Curves.easeInOut),
    );

    _emblemAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.70, 1.0, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) widget.onFinish();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Ambient Warm Golden Sunlight Glow
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    AppColors.brandAmberLight.withValues(alpha: 0.6),
                    Colors.white,
                  ],
                ),
              ),
            ),
          ),

          // Central Logo and Stages
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Dynamic Stage Display
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            if (_controller.value < 0.40)
                              ScaleTransition(
                                scale: _seedDropAnimation,
                                child: Image.asset(
                                  'assets/images/anim_step1.png',
                                  width: 100,
                                  height: 100,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.spa,
                                    size: 80,
                                    color: AppColors.brandSeed,
                                  ),
                                ),
                              )
                            else if (_controller.value < 0.75)
                              ScaleTransition(
                                scale: _sproutAnimation,
                                child: Image.asset(
                                  'assets/images/anim_step2.png',
                                  width: 120,
                                  height: 120,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.grass,
                                    size: 90,
                                    color: AppColors.brandGreen,
                                  ),
                                ),
                              )
                            else
                              ScaleTransition(
                                scale: _emblemAnimation,
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  width: 150,
                                  height: 150,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.eco,
                                    size: 110,
                                    color: AppColors.brandGreen,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      RichText(
                        text: const TextSpan(
                          text: 'Parali',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.5,
                          ),
                          children: [
                            TextSpan(
                              text: 'Setu',
                              style: TextStyle(
                                color: AppColors.brandSeed,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        AppConstants.tagline,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textMuted,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Skip Button
          Positioned(
            top: 48,
            right: 24,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                side: const BorderSide(color: AppColors.border),
              ),
              onPressed: widget.onFinish,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Skip', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
                  SizedBox(width: 4),
                  Icon(Icons.close, size: 14, color: AppColors.textMuted),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
