import 'dart:ui';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState
    extends State<NotificationScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _floatController;

  late Animation<double> _bgAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    // Background gradient animation
    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat(reverse: true);

    _bgAnimation =
        Tween<double>(begin: 0, end: 1).animate(_bgController);

    // Floating animation
    _floatController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    _floatAnimation =
        Tween<double>(begin: -40, end: 40).animate(_floatController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  // 🔔 Notification Card
  Widget notificationCard(
      {required String title,
      required String subtitle,
      required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.15),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              border: Border.all(
                  color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(icon,
                    color: Colors.amberAccent,
                    size: 30),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      const SizedBox(height: 5),
                      Text(subtitle,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
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
            const IconThemeData(color: Colors.white),
        title: const Text("🔔 Notifications",
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),

      body: Stack(
        children: [

          // 🌌 Animated Dark Gradient
          AnimatedBuilder(
            animation: _bgAnimation,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                          const Color(0xFF1A0033),
                          const Color(0xFF33001A),
                          _bgAnimation.value)!,
                      Color.lerp(
                          const Color(0xFF000814),
                          const Color(0xFF2B0033),
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
            top: -60,
            left: -40,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Colors.purple.withOpacity(0.1),
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            bottom: -50,
            right: -40,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, _) {
                return Transform.translate(
                  offset:
                      Offset(0, -_floatAnimation.value),
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          Colors.deepPurple.withOpacity(0.1),
                    ),
                  ),
                );
              },
            ),
          ),

          // 🔔 Scrollable Notifications
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [

                  const SizedBox(height: 30),

                  notificationCard(
                    title: "New User Registered",
                    subtitle:
                        "Rahul from Chennai created a new account.",
                    icon: Icons.person_add,
                  ),

                  notificationCard(
                    title: "Premium Upgrade",
                    subtitle:
                        "Priya upgraded to Gold Membership.",
                    icon: Icons.workspace_premium,
                  ),

                  notificationCard(
                    title: "New Report Submitted",
                    subtitle:
                        "A fake profile was reported.",
                    icon: Icons.report,
                  ),

                  notificationCard(
                    title: "Payment Received",
                    subtitle:
                        "₹5,000 subscription payment completed.",
                    icon: Icons.payment,
                  ),

                  notificationCard(
                    title: "System Alert",
                    subtitle:
                        "Server response time increased.",
                    icon: Icons.warning,
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