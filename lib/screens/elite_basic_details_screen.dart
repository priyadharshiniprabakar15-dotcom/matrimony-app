import 'package:flutter/material.dart';
import 'elite_personal_details_screen.dart';

class EliteBasicDetailsScreen extends StatefulWidget {
  const EliteBasicDetailsScreen({super.key});

  @override
  State<EliteBasicDetailsScreen> createState() =>
      _EliteBasicDetailsScreenState();
}

class _EliteBasicDetailsScreenState
    extends State<EliteBasicDetailsScreen>
    with SingleTickerProviderStateMixin {

  static const Color primaryMaroon = Color(0xFF800020);
  static const Color gold = Color(0xFFD4AF37);
  static const Color cream = Color(0xFFFFF8E7);

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _animation =
        Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Floating Heart
  Widget _floatingHeart(double top, double left, double size) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: top - (_animation.value * 40),
          left: left,
          child: Opacity(
            opacity: 0.10,
            child: Icon(
              Icons.favorite,
              color: gold,
              size: size,
            ),
          ),
        );
      },
    );
  }

  void _verifyAndNavigate() {

    /// Show Verified Message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("OTP Verified Successfully ✅"),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    /// After delay move to Personal Details
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration:
              const Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) =>
              const ElitePersonalDetailsScreen(),
          transitionsBuilder:
              (_, animation, __, child) {
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
      backgroundColor: cream,
      appBar: AppBar(
        backgroundColor: primaryMaroon,
        elevation: 0,
        centerTitle: true,
        iconTheme:
            const IconThemeData(color: Colors.white),
        title: const Text(
          "Basic Details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [

          /// 💛 Floating Background Hearts
          _floatingHeart(120, 30, 40),
          _floatingHeart(280, 250, 30),
          _floatingHeart(450, 100, 50),
          _floatingHeart(600, 280, 35),

          /// Main Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [

                const SizedBox(height: 20),

                _buildField("Full Name"),
                const SizedBox(height: 20),

                _buildField("Email Address"),
                const SizedBox(height: 20),

                _buildField("Create Password", obscure: true),
                const SizedBox(height: 20),

                _buildField("Mobile Number"),
                const SizedBox(height: 40),

                /// 💛 Gold Glow Get OTP Button
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x55D4AF37),
                        blurRadius: 30,
                        spreadRadius: 4,
                        offset: Offset(0, 15),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gold,
                      minimumSize:
                          const Size(double.infinity, 55),
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    onPressed: _verifyAndNavigate,
                    child: const Text(
                      "Get OTP",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(String hint,
      {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(
                horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}