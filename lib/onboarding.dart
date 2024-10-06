import 'package:flutter/material.dart';
import 'package:smartappli/onboarding/color.dart';
import 'package:smartappli/onboarding/onboardingdata.dart';
import 'package:smartappli/login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final controller = OnboardingData();
  final pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/Onboarding_bg.jpg',
            fit: BoxFit.cover,
          ),
          // Gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: GradientBackground,
            ),
          ),
          // Onboarding content
          Column(
            children: [
              Expanded(child: body()),
              buildDots(),
              button(),
            ],
          ),
        ],
      ),
    );
  }

  // Body
  Widget body() {
    return PageView.builder(
      controller: pageController,
      onPageChanged: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      itemCount: controller.items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Screen images
              Image.asset(controller.items[currentIndex].image),

              // Screen titles
              Text(
                controller.items[currentIndex].title,
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              // Descriptions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  controller.items[currentIndex].desc,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Dots
  Widget buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.items.length,
        (index) => AnimatedContainer(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: currentIndex == index ? Colors.white : Colors.white54,
          ),
          height: 7,
          width: currentIndex == index ? 30 : 7,
          duration: const Duration(milliseconds: 700),
        ),
      ),
    );
  }

  // Button
  Widget button() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextButton(
        onPressed: () {
          if (currentIndex != controller.items.length - 1) {
            setState(() {
              currentIndex++;
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            });
          } else {
            // Navigate to Login Page
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
        child: Text(
          currentIndex == controller.items.length - 1 ? "Get Started" : "Continue",
          style: TextStyle(color: const Color.fromARGB(255, 38, 83, 40), fontSize: 18),
        ),
      ),
    );
  }
}
