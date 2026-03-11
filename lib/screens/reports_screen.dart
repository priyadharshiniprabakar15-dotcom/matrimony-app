import 'dart:ui';
import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _floatController;
  late AnimationController _pulseController;

  late Animation<double> _bgAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // 🌸 Background gradient animation
    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat(reverse: true);

    _bgAnimation =
        Tween<double>(begin: 0, end: 1).animate(_bgController);

    // 🌊 Floating shapes animation
    _floatController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    _floatAnimation =
        Tween<double>(begin: -25, end: 25).animate(_floatController);

    // 🔴 Pulse animation for fake profile
    _pulseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);

    _pulseAnimation =
        Tween<double>(begin: 0.9, end: 1.1).animate(_pulseController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _floatController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  // 📝 Report Card
  Widget _reportCard({
    required String title,
    required String description,
    required String status,
    bool isCritical = false,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white.withOpacity(0.75),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withOpacity(0.15),
                blurRadius: 20,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [

                  isCritical
                      ? AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: const Icon(Icons.warning,
                                  color: Colors.red, size: 28),
                            );
                          },
                        )
                      : const Icon(Icons.report_problem,
                          color: Colors.orange, size: 26),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              Text(
                description,
                style: const TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Text("Status: ",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87)),
                  Text(
                    status,
                    style: TextStyle(
                      color: status == "Pending"
                          ? Colors.orange
                          : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 📊 Summary Card
  Widget _summaryCard(String emoji, String value, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.7),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 26)),
              const SizedBox(height: 5),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87)),
              Text(label,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("📝 Reports & Complaints",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      body: Stack(
        children: [

          // 🌸 Light Animated Gradient
          AnimatedBuilder(
            animation: _bgAnimation,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                          const Color(0xFFFFEBEE),
                          const Color(0xFFFCE4EC),
                          _bgAnimation.value)!,
                      Color.lerp(
                          const Color(0xFFE3F2FD),
                          const Color(0xFFF3E5F5),
                          _bgAnimation.value)!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),

          // 🌊 Floating soft shapes
          Positioned(
            top: -60,
            left: -40,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.withOpacity(0.1),
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            bottom: -60,
            right: -40,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, -_floatAnimation.value),
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.1),
                    ),
                  ),
                );
              },
            ),
          ),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                          child: _summaryCard("🚨", "7", "Total Reports")),
                      const SizedBox(width: 15),
                      Expanded(
                          child: _summaryCard("⏳", "3", "Pending")),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                          child: _summaryCard("✅", "2", "Resolved")),
                      const SizedBox(width: 15),
                      Expanded(
                          child: _summaryCard("🚫", "1", "Blocked Profiles")),
                    ],
                  ),

                  const SizedBox(height: 30),

                  _reportCard(
                    title: "Fake Profile Detected",
                    description:
                        "Profile ID #1024 reported for suspicious activity.",
                    status: "Pending",
                    isCritical: true,
                  ),

                  const SizedBox(height: 20),

                  _reportCard(
                    title: "Inappropriate Content",
                    description:
                        "User posted inappropriate images in profile.",
                    status: "Resolved",
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}