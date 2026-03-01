import 'dart:async';
import 'package:adg_recruitment/presentation/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<double> scaleAnim;
  late Animation<double> fadeAnim;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    scaleAnim = Tween(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
    );

    fadeAnim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeIn),
    );

    controller.forward();

    // Navigate after 2 seconds
    Timer(const Duration(seconds: 2), () async {
      if(await AuthController().checkAuthState()){
        Get.offAllNamed('/dashboard');
      }else{
        Get.offAllNamed('/onboard');
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    const primary = Colors.indigo;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF3949AB), // indigo 600
              Color(0xFF1A237E), // indigo 900
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: FadeTransition(
            opacity: fadeAnim,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                /// Logo / Icon
                ScaleTransition(
                  scale: scaleAnim,
                  child: Container(
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.25),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: const Icon(
                      Icons.badge_rounded,
                      size: 60,
                      color: primary,
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                /// App Name
                const Text(
                  "Job Candidate",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: .6,
                  ),
                ),

                const SizedBox(height: 8),

                /// Tagline
                const Text(
                  "Find your dream career",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 40),

                /// Loading Indicator
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}