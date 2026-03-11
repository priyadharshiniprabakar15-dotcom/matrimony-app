import 'dart:ui';
import 'package:flutter/material.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() =>
      _UserManagementScreenState();
}

class _UserManagementScreenState
    extends State<UserManagementScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _floatController;
  late AnimationController _badgeController;

  late Animation<double> _bgAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _badgeAnimation;

  @override
  void initState() {
    super.initState();

    // 🌸 Background gradient animation
    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat(reverse: true);

    _bgAnimation =
        Tween<double>(begin: 0, end: 1).animate(_bgController);

    // 🌊 Floating animation
    _floatController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    _floatAnimation =
        Tween<double>(begin: -30, end: 30).animate(_floatController);

    // ⭐ Premium badge pulse
    _badgeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);

    _badgeAnimation =
        Tween<double>(begin: 0.9, end: 1.1).animate(_badgeController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _floatController.dispose();
    _badgeController.dispose();
    super.dispose();
  }

  // 👤 Summary Card
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

  // 👥 User Card
  Widget _userCard({
    required String name,
    required String location,
    required bool isPremium,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white.withOpacity(0.8),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 20,
              )
            ],
          ),
          child: Column(
            children: [

              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundImage:
                        AssetImage("assets/images/onboard1.png"),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87)),
                        Text(location,
                            style: const TextStyle(
                                color: Colors.black54)),
                      ],
                    ),
                  ),

                  if (isPremium)
                    AnimatedBuilder(
                      animation: _badgeAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _badgeAnimation.value,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade600,
                              borderRadius:
                                  BorderRadius.circular(15),
                            ),
                            child: const Text(
                              "Premium",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                children: [

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: const Text("Approve",
                        style:
                            TextStyle(color: Colors.green)),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: const Text("Reject",
                        style:
                            TextStyle(color: Colors.red)),
                  ),
                ],
              ),
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
        iconTheme:
            const IconThemeData(color: Colors.black),
        title: const Text("👥 User Management",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      body: Stack(
        children: [

          // 🌸 Light animated gradient
          AnimatedBuilder(
            animation: _bgAnimation,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                          const Color(0xFFE3F2FD),
                          const Color(0xFFF3E5F5),
                          _bgAnimation.value)!,
                      Color.lerp(
                          const Color(0xFFFFF3E0),
                          const Color(0xFFE8F5E9),
                          _bgAnimation.value)!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),

          // 🌊 Floating shapes
          Positioned(
            top: -70,
            left: -40,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withOpacity(0.1),
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            bottom: -60,
            right: -30,
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
                      color: Colors.purple.withOpacity(0.1),
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

                  // 📊 Summary
                  Row(
                    children: [
                      Expanded(
                          child: _summaryCard("👥", "1,245", "Total Users")),
                      const SizedBox(width: 15),
                      Expanded(
                          child: _summaryCard("🆕", "45", "New Today")),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                          child: _summaryCard("⭐", "320", "Premium")),
                      const SizedBox(width: 15),
                      Expanded(
                          child: _summaryCard("🚫", "18", "Blocked")),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 👤 User List (Scrollable)
                  _userCard(
                      name: "Rahul",
                      location: "Chennai",
                      isPremium: true),

                  const SizedBox(height: 20),

                  _userCard(
                      name: "Priya",
                      location: "Madurai",
                      isPremium: false),

                  const SizedBox(height: 20),

                  _userCard(
                      name: "Arjun",
                      location: "Coimbatore",
                      isPremium: true),

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