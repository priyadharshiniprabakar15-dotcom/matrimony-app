import 'package:flutter/material.dart';
import 'elite_create_profile_screen.dart';
import 'onboarding_screen.dart';
import 'login_screen.dart';

class EliteWelcomeScreen extends StatefulWidget {
  const EliteWelcomeScreen({super.key});

  @override
  State<EliteWelcomeScreen> createState() => _EliteWelcomeScreenState();
}

class _EliteWelcomeScreenState extends State<EliteWelcomeScreen>
    with TickerProviderStateMixin {

  static const Color gold = Color(0xFFD4AF37);
  static const Color cream = Color(0xFFFFF8E7);
  static const Color maroon = Color(0xFF800020);

  late AnimationController _heartController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _scaleAnimation =
        Tween<double>(begin: 0.9, end: 1.2).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.easeInOut),
    );

    _glowAnimation =
        Tween<double>(begin: 15, end: 40).animate(
      CurvedAnimation(parent: _heartController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  Widget socialButton({
    required String text,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: TextButton(
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 20),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          /// 🌈 Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF9B1C31),
                  Color(0xFFB23A48),
                  Color(0xFF800020),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 👑 Royal Overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(
                "assets/images/royal_bg.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 🔙 Back Button (Top Left)
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const OnboardingScreen(),
                    ),
                  );
                },
              ),
            ),
          ),

          /// ❤️ CENTER CONTENT (Heart + Title)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                AnimatedBuilder(
                  animation: _heartController,
                  builder: (_, __) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: gold.withOpacity(0.9),
                              blurRadius: _glowAnimation.value,
                              spreadRadius: 8,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: gold,
                          size: 90,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 15),

                const Text(
                  "Elite Matrimony 💍",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          /// 👑 BOTTOM SANDAL CARD
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                  horizontal: 25, vertical: 22),
              decoration: const BoxDecoration(
                color: cream,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Text(
                    "Begin your journey towards\nmeaningful relationships",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: maroon,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 18),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gold,
                      minimumSize:
                          const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const EliteCreateProfileScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Create Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize:
                          const Size(double.infinity, 48),
                      side: const BorderSide(color: Color.fromARGB(255, 236, 217, 4)),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Already Registered? Login",
                      style: TextStyle(color: maroon),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8),
                        child: Text("OR"),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),

                  socialButton(
                    text: "Continue with Google",
                    imagePath: "assets/images/google.png",
                  ),

                  socialButton(
                    text: "Continue with Facebook",
                    imagePath: "assets/images/facebook.png",
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "100% Verified Profiles • Secure Privacy • Trusted by Families",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}