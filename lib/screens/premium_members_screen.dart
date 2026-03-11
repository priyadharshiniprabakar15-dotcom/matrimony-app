import 'dart:ui';
import 'package:flutter/material.dart';

class PremiumMembersScreen extends StatefulWidget {
  const PremiumMembersScreen({super.key});

  @override
  State<PremiumMembersScreen> createState() =>
      _PremiumMembersScreenState();
}

class _PremiumMembersScreenState
    extends State<PremiumMembersScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _floatController;
  late AnimationController _crownController;

  late Animation<double> _bgAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _crownAnimation;

  final List<Map<String, dynamic>> premiumUsers = [
    {
      "name": "Rahul",
      "location": "Chennai",
      "tier": "Gold",
      "online": true
    },
    {
      "name": "Sneha",
      "location": "Madurai",
      "tier": "Diamond",
      "online": true
    },
    {
      "name": "Vikram",
      "location": "Coimbatore",
      "tier": "Gold",
      "online": false
    },
    {
      "name": "Aishwarya",
      "location": "Bangalore",
      "tier": "Diamond",
      "online": true
    },
  ];

  @override
  void initState() {
    super.initState();

    // 🌟 Background animation
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

    // 👑 Crown pulse animation
    _crownController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);

    _crownAnimation =
        Tween<double>(begin: 0.9, end: 1.1).animate(_crownController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _floatController.dispose();
    _crownController.dispose();
    super.dispose();
  }

  // ⭐ Summary Card
  Widget _summaryCard(String emoji, String value, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.75),
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

  // 👑 Premium Card
  Widget _premiumCard(Map<String, dynamic> user) {
    final bool isDiamond = user["tier"] == "Diamond";

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.85),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.15),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        children: [

          // Profile + online indicator
          Stack(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage:
                    AssetImage("assets/images/onboard2.png"),
              ),
              if (user["online"])
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user["name"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87)),
                Text(user["location"],
                    style: const TextStyle(
                        color: Colors.black54)),
              ],
            ),
          ),

          AnimatedBuilder(
            animation: _crownAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _crownAnimation.value,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDiamond
                        ? Colors.purple
                        : Colors.amber,
                    borderRadius:
                        BorderRadius.circular(15),
                  ),
                  child: Text(
                    user["tier"],
                    style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ],
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
        title: const Text("⭐ Premium Members",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),

      body: Stack(
        children: [

          // 🌟 Light luxury animated gradient
          AnimatedBuilder(
            animation: _bgAnimation,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                          const Color(0xFFFFF8E1),
                          const Color(0xFFF3E5F5),
                          _bgAnimation.value)!,
                      Color.lerp(
                          const Color(0xFFE3F2FD),
                          const Color(0xFFFFFDE7),
                          _bgAnimation.value)!,
                    ],
                  ),
                ),
              );
            },
          ),

          // 🌊 Floating golden shapes
          Positioned(
            top: -60,
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
                      color: Colors.amber.withOpacity(0.1),
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

                  // 📊 Summary Section
                  Row(
                    children: [
                      Expanded(
                          child: _summaryCard(
                              "⭐",
                              premiumUsers.length
                                  .toString(),
                              "Total Premium")),
                      const SizedBox(width: 15),
                      Expanded(
                          child: _summaryCard(
                              "💎",
                              premiumUsers
                                  .where((u) =>
                                      u["tier"] ==
                                      "Diamond")
                                  .length
                                  .toString(),
                              "Diamond")),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // 👑 Premium List
                  ...premiumUsers
                      .map((user) =>
                          _premiumCard(user))
                      .toList(),

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