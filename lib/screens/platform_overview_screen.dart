import 'dart:ui';
import 'package:flutter/material.dart';

class PlatformOverviewScreen extends StatefulWidget {
  const PlatformOverviewScreen({super.key});

  @override
  State<PlatformOverviewScreen> createState() =>
      _PlatformOverviewScreenState();
}

class _PlatformOverviewScreenState
    extends State<PlatformOverviewScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _floatController;

  late Animation<double> _bgAnimation;
  late Animation<double> _floatAnimation;

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
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat(reverse: true);

    _floatAnimation =
        Tween<double>(begin: -20, end: 20).animate(_floatController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  // 💎 Stat Card
  Widget _statCard(
      String emoji, String value, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.7),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 30)),
              const SizedBox(height: 6),
              Text(value,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              Text(label,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }

  // 📊 Info Card
  Widget _infoCard(
      {required String title,
      required String subtitle}) {
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
                color: Colors.purple.withOpacity(0.15),
                blurRadius: 20,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              const SizedBox(height: 8),
              Text(subtitle,
                  style: const TextStyle(
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
        iconTheme:
            const IconThemeData(color: Colors.black),
        title: const Text("📊 Platform Overview",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      body: Stack(
        children: [

          // 🌸 Animated Light Gradient
          AnimatedBuilder(
            animation: _bgAnimation,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                          const Color(0xFFFDECEF),
                          const Color(0xFFFADADD),
                          _bgAnimation.value)!,
                      Color.lerp(
                          const Color(0xFFF8C8DC),
                          const Color(0xFFE0B0FF),
                          _bgAnimation.value)!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),

          // 🌊 Floating Soft Circles
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
                      color: Colors.pink.withOpacity(0.2),
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
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.withOpacity(0.15),
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

                  _infoCard(
                    title: "Elite Matrimony Overview 👑",
                    subtitle:
                        "Monitor user growth, revenue and engagement metrics in real-time.",
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: [
                      Expanded(
                          child: _statCard(
                              "👥", "1,245", "Total Users")),
                      const SizedBox(width: 15),
                      Expanded(
                          child: _statCard(
                              "💎", "320", "Premium Users")),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                          child: _statCard(
                              "📈", "45", "New Today")),
                      const SizedBox(width: 15),
                      Expanded(
                          child: _statCard(
                              "🚫", "18", "Blocked")),
                    ],
                  ),

                  const SizedBox(height: 30),

                  _infoCard(
                    title: "💰 Revenue Snapshot",
                    subtitle:
                        "₹2,45,000 this month • Growth +18%",
                  ),

                  const SizedBox(height: 20),

                  _infoCard(
                    title: "📝 Activity Summary",
                    subtitle:
                        "7 new reports • 3 pending approvals • 12 new matches created today.",
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