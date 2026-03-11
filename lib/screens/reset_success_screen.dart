import 'package:flutter/material.dart';
import 'login_screen.dart';

class ResetSuccessScreen extends StatefulWidget {
  const ResetSuccessScreen({super.key});

  @override
  State<ResetSuccessScreen> createState() =>
      _ResetSuccessScreenState();
}

class _ResetSuccessScreenState
    extends State<ResetSuccessScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scaleAnimation =
        Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _backToLogin() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // 👑 Background Gradient
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
              opacity: 0.2,
              child: Image.asset(
                "assets/images/royal_bg.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Center(
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [

                        const Icon(
                          Icons.check_circle,
                          size: 100,
                          color: Color(0xFFD4AF37),
                        ),

                        const SizedBox(height: 30),

                        const Text(
                          "Reset Link Sent!",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFF5E1),
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          "We have sent password reset instructions to your email.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),

                        const SizedBox(height: 40),

                        // 👑 Back to Login Button
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x55D4AF37),
                                blurRadius: 25,
                                spreadRadius: 2,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFD4AF37),
                              minimumSize: const Size(
                                  double.infinity, 55),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            onPressed: _backToLogin,
                            child: const Text(
                              "Back to Login",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
