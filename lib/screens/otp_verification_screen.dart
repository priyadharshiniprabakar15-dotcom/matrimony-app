import 'package:flutter/material.dart';
import 'verification_success_screen.dart';

class OtpVerificationScreen extends StatefulWidget {

  final String name;
  final String email;
  final String password;

  const OtpVerificationScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState
    extends State<OtpVerificationScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  bool _isLoading = false;

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
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(CurvedAnimation(
                parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Widget _buildOtpBox(int index) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33D4AF37),
            blurRadius: 15,
            spreadRadius: 1,
          )
        ],
      ),
      child: TextField(
        controller: _controllers[index],
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF800000),
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && index < 3) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  // 🔐 VERIFY OTP
  void _verifyOtp() {

    String otp = "";

    for (var controller in _controllers) {
      otp += controller.text;
    }

    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter complete OTP"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    print("OTP ENTERED: $otp");
    print("NAME: ${widget.name}");
    print("EMAIL: ${widget.email}");
    print("PASSWORD: ${widget.password}");

    setState(() => _isLoading = true);

    // For now navigating directly
    Future.delayed(const Duration(seconds: 1), () {

      setState(() => _isLoading = false);

      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (_, __, ___) =>
              const VerificationSuccessScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [

          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [
                  Color(0xFFFFE8B6),
                  Color(0xFF9B1C31),
                ],
              ),
            ),
          ),

          SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius:
                            BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 30,
                            offset: Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Color(0xFF800000),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Icon(
                            Icons.lock_outline,
                            size: 60,
                            color: Color(0xFFD4AF37),
                          ),

                          const SizedBox(height: 20),

                          const Text(
                            "OTP Verification",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF800000),
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            "Enter the 4-digit code sent to ${widget.email}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),

                          const SizedBox(height: 30),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildOtpBox(0),
                              _buildOtpBox(1),
                              _buildOtpBox(2),
                              _buildOtpBox(3),
                            ],
                          ),

                          const SizedBox(height: 40),

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
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(30),
                                ),
                              ),
                              onPressed:
                                  _isLoading ? null : _verifyOtp,
                              child: _isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white)
                                  : const Text(
                                      "Verify OTP",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Resend Code",
                              style: TextStyle(
                                color: Color(0xFFD4AF37),
                                fontWeight:
                                    FontWeight.bold,
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
          ),
        ],
      ),
    );
  }
}