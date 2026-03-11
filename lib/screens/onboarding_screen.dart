import 'package:flutter/material.dart';
import 'elite_welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboard1.png",
      "title": "Find Your Perfect Match",
      "desc":
          "Discover meaningful connections with individuals who value tradition and commitment."
    },
    {
      "image": "assets/images/onboard2.png",
      "title": "Where Traditions Begin",
      "desc":
          "Experience a premium matrimony journey designed with elegance and trust."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingData.length,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Stack(
            children: [

              // 👑 Full Background Image
              Positioned.fill(
                child: Image.asset(
                  onboardingData[index]["image"]!,
                  fit: BoxFit.cover,
                ),
              ),

              // 🎨 Lighter Royal Overlay
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xCC9B1C31),  // Soft Maroon
                        Color(0xCCB23A48),  // Light Maroon
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),

              // ✨ Content
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Spacer(),

                      // 👑 Animated Text Section
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 600),
                        opacity: currentIndex == index ? 1 : 0,
                        child: Column(
                          children: [

                            Text(
                              onboardingData[index]["title"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFF5E1),
                                letterSpacing: 1.2,
                              ),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              onboardingData[index]["desc"]!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // 👑 Dot Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingData.length,
                          (i) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(5),
                            height: 8,
                            width: currentIndex == i ? 25 : 8,
                            decoration: BoxDecoration(
                              color: currentIndex == i
                                  ? const Color(0xFFD4AF37)
                                  : Colors.white38,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 👑 Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          minimumSize: const Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          if (currentIndex ==
                              onboardingData.length - 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                     const EliteWelcomeScreen()),
                            );
                          } else {
                            _controller.nextPage(
                              duration:
                                  const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Text(
                          currentIndex ==
                                  onboardingData.length - 1
                              ? "Get Started"
                              : "Next",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
