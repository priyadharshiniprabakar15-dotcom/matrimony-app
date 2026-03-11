import 'package:flutter/material.dart';
import 'reset_success_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final TextEditingController _emailController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _goToSuccessScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration:
            const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) =>
            const ResetSuccessScreen(),
        transitionsBuilder:
            (_, animation, __, child) {
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

          // 👑 Background Illustration
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
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      // 🔙 Back Icon
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFFFFF5E1),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFF5E1),
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Enter your registered email address to receive password reset instructions.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // 📧 Email Field
                      TextField(
                        controller: _emailController,
                        style: const TextStyle(
                            color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          hintStyle:
                              const TextStyle(
                                  color:
                                      Colors.white70),
                          filled: true,
                          fillColor: Colors.white
                              .withOpacity(0.12),
                          contentPadding:
                              const EdgeInsets
                                  .symmetric(
                                      vertical: 18,
                                      horizontal: 20),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(
                                    30),
                            borderSide:
                                BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 🚀 Send Reset Button
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(
                                  30),
                          boxShadow: const [
                            BoxShadow(
                              color:
                                  Color(0x55D4AF37),
                              blurRadius: 25,
                              spreadRadius: 2,
                              offset:
                                  Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                const Color(
                                    0xFFD4AF37),
                            minimumSize:
                                const Size(
                                    double.infinity,
                                    55),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          30),
                            ),
                            elevation: 0,
                          ),
                          onPressed:
                              _goToSuccessScreen,
                          child: const Text(
                            "Send Reset Link",
                            style: TextStyle(
                              fontSize: 18,
                              color:
                                  Colors.white,
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
        ],
      ),
    );
  }
}
