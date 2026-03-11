import 'dart:async';
import 'package:flutter/material.dart';

class UpgradePlanScreen extends StatefulWidget {
  const UpgradePlanScreen({super.key});

  @override
  State<UpgradePlanScreen> createState() => _UpgradePlanScreenState();
}

class _UpgradePlanScreenState extends State<UpgradePlanScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation =
        Tween<double>(begin: 0.6, end: 1).animate(_glowController);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  Widget premiumCard(
      String title,
      String price,
      IconData icon,
      List<String> features) {

    return FadeTransition(
      opacity: _glowAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFB23A48),
              Color(0xFF7A1E2C),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 3,
            )
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.amber, size: 40),
            const SizedBox(height: 15),
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(price,
                style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ...features.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    const Icon(Icons.check,
                        color: Colors.white),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        e,
                        style:
                            const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: const Text("Choose Plan"),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9B1C31),
              Color(0xFF5C1120),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [

              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Upgrade Plan 💎",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              premiumCard(
                "Gold Plan",
                "₹999 / Month",
                Icons.star,
                [
                  "Unlimited Likes 💖",
                  "See Who Viewed You 👀",
                  "Priority Support 💬",
                ],
              ),

              premiumCard(
                "Platinum Plan",
                "₹1999 / Month",
                Icons.workspace_premium,
                [
                  "AI Priority Matching 🤖",
                  "Profile Boost 🚀",
                  "Exclusive Matches 💍",
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
