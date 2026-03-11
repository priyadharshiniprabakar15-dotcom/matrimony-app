import 'package:flutter/material.dart';
import 'login_screen.dart';

class VerificationSuccessScreen extends StatefulWidget {
  const VerificationSuccessScreen({super.key});

  @override
  State<VerificationSuccessScreen> createState() =>
      _VerificationSuccessScreenState();
}

class _VerificationSuccessScreenState
    extends State<VerificationSuccessScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _scaleAnimation =
        Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToLogin() {
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

          // 🌟 Elegant Soft Gold Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFF3D6),
                  Color(0xFFFFE4B5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
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

                        // 👑 Golden Success Icon
                        Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFD4AF37),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x55D4AF37),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 40),

                        const Text(
                          "Verification Successful!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF800000),
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          "Your account has been verified successfully.\nYou can now login and start your journey.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),

                        const SizedBox(height: 50),

                        // 👑 GOLD BUTTON WITH WHITE TEXT
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(40),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x66D4AF37),
                                blurRadius: 30,
                                spreadRadius: 3,
                                offset: Offset(0, 12),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFD4AF37),
                              minimumSize: const Size(
                                  double.infinity, 60),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(40),
                              ),
                              elevation: 0,
                            ),
                            onPressed: _goToLogin,
                            child: const Text(
                              "Continue to Login",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                    FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
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
