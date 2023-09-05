import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/core/constants.dart';
import 'package:news_app/features/home/screens/home_tabs.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            '${AppConstants.imgPath}newsreporter.PNG',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
          ).animate().fadeIn(duration: 1.6.seconds),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * .5,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.9),
                  Colors.black,
                  Colors.black,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Stay Informed',
                  style: GoogleFonts.robotoSlab(
                      fontSize: AppConstants.heading1,
                      color: AppConstants.secondary,
                      fontWeight: FontWeight.w800),
                ).animate().fadeIn(duration: 1.seconds).slideY(
                    duration: 900.ms, begin: -1.4, curve: Curves.easeIn),
                Text(
                  'All The Day',
                  style: GoogleFonts.robotoSlab(
                      fontSize: AppConstants.heading1,
                      color: AppConstants.secondary,
                      fontWeight: FontWeight.w800),
                ).animate().fadeIn(duration: 1.seconds).slideY(
                    duration: 900.ms, begin: -1.4, curve: Curves.easeIn),
                const SizedBox(
                  height: 11,
                ),
                const Text(
                  'Discover the Latest News with our',
                  style: TextStyle(
                      fontSize: AppConstants.body1,
                      color: AppConstants.secondary,
                      fontWeight: FontWeight.bold),
                )
                    .animate()
                    .fadeIn(
                        delay: 100.ms,
                        duration: 1.1.seconds,
                        curve: Curves.easeIn)
                    .scaleX(
                        delay: 200.ms,
                        duration: 1.1.seconds,
                        curve: Curves.easeIn),
                const Text(
                  'Seamless Onboarding Experience',
                  style: TextStyle(
                      fontSize: AppConstants.body1,
                      color: AppConstants.secondary,
                      fontWeight: FontWeight.bold),
                )
                    .animate()
                    .fadeIn(
                        delay: 100.ms,
                        duration: 1.1.seconds,
                        curve: Curves.easeIn)
                    .scaleX(
                        delay: 200.ms,
                        duration: 1.1.seconds,
                        curve: Curves.easeIn),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomeTabsScreen(),
                        ),
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 17,
                        ),
                      ),
                      child: const Text(
                        'Getting Started',
                        style: TextStyle(fontSize: AppConstants.title2),
                      ),
                    ).animate(onPlay: (controller) => controller.repeat(reverse: true),).shimmer(duration: 1.8.seconds),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
