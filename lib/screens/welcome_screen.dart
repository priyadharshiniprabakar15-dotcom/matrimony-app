import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _welcomeSlide;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scaleAnimation =
        Tween<double>(begin: 0.8, end: 1.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
        );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        );

    _welcomeSlide =
        Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (_, __, ___) => const LoginScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // 👑 Softer Royal Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF9B1C31),
                  Color(0xFFB23A48),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 👑 Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.25,
              child: Image.asset(
                "assets/images/royal_bg.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [

                const SizedBox(height: 40),

                // ✨ Animated Welcome Text
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _welcomeSlide,
                    child: const Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFFD4AF37),
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            // 💍 Gold Circle Logo
                            Container(
                              height: 120,
                              width: 120,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFD4AF37),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFFD4AF37),
                                    blurRadius: 20,
                                    spreadRadius: 2,
                                  )
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.favorite,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(height: 40),

                            // 👑 Animated Elite Text
                            SlideTransition(
                              position: _slideAnimation,
                              child: const Text(
                                "Elite",
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFF5E1),
                                  letterSpacing: 2,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 20,
                                      color: Color(0xFFD4AF37),
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            const Text(
                              "Where Traditions Meet Destiny",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontStyle: FontStyle.italic,
                              ),
                            ),

                            const SizedBox(height: 60),

                            // 🚀 Get Started Button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD4AF37),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 10,
                              ),
                              onPressed: _goToLogin,
                              child: const Text(
                                "Get Started",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
