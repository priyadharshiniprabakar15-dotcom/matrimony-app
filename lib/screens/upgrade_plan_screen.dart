import 'dart:math';
import 'package:flutter/material.dart';

class UpgradePlanScreen extends StatefulWidget {
  const UpgradePlanScreen({super.key});

  @override
  State<UpgradePlanScreen> createState() =>
      _UpgradePlanScreenState();
}

class _UpgradePlanScreenState
    extends State<UpgradePlanScreen>
    with TickerProviderStateMixin {

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _premiumCard(
      String title, String price, List<String> features) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
              color: Colors.orangeAccent,
              blurRadius: 15,
              offset: Offset(0, 8))
        ],
      ),
      child: Column(
        children: [

          Text(title,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),

          const SizedBox(height: 10),

          Text(price,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),

          const SizedBox(height: 15),

          ...features.map((f) => Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4),
                child: Text("✔ $f",
                    style: const TextStyle(
                        color: Colors.white)),
              )),

          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30)),
            ),
            onPressed: () {},
            child: const Text(
              "Upgrade Now 🚀",
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.lerp(
                      const Color(0xFF8E2DE2),
                      const Color(0xFF4A00E0),
                      _animationController.value)!,
                  const Color(0xFFFFA500),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [

                    const Text(
                      "Go Premium 👑",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),

                    const SizedBox(height: 20),

                    _premiumCard(
                      "Gold Plan",
                      "₹999 / Month",
                      [
                        "Unlimited Matches",
                        "See Who Viewed You",
                        "Priority Support",
                      ],
                    ),

                    _premiumCard(
                      "Platinum Plan",
                      "₹1999 / Month",
                      [
                        "All Gold Features",
                        "Direct Messaging",
                        "AI Compatibility Boost",
                        "Profile Highlight",
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
