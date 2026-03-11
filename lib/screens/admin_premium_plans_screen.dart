import 'dart:math';
import 'package:flutter/material.dart';

class AdminPremiumPlansScreen extends StatefulWidget {
  const AdminPremiumPlansScreen({super.key});

  @override
  State<AdminPremiumPlansScreen> createState() =>
      _AdminPremiumPlansScreenState();
}

class _AdminPremiumPlansScreenState
    extends State<AdminPremiumPlansScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _bubbleController;

  @override
  void initState() {
    super.initState();

    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat(reverse: true);

    _bubbleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _bubbleController.dispose();
    super.dispose();
  }

  // 🌈 Animated Background Gradient
  Widget animatedBackground() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(
                    const Color(0xFF1A0033),
                    const Color(0xFF6A0D2F),
                    _bgController.value)!,
                Color.lerp(
                    const Color(0xFF2E0854),
                    const Color(0xFF9B1C31),
                    _bgController.value)!,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }

  // 🫧 Floating Bubbles
  Widget floatingBubbles() {
    return AnimatedBuilder(
      animation: _bubbleController,
      builder: (_, __) {
        return Stack(
          children: List.generate(15, (index) {
            final random = Random(index);
            return Positioned(
              left: random.nextDouble() *
                  MediaQuery.of(context).size.width,
              bottom: (_bubbleController.value *
                  MediaQuery.of(context).size.height),
              child: Opacity(
                opacity: 0.15,
                child: Container(
                  height: 20 + random.nextDouble() * 40,
                  width: 20 + random.nextDouble() * 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Colors.white54,
                        Colors.transparent
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  // 💎 Plan Card
  Widget planCard({
    required String title,
    required String price,
    required List<Color> colors,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 18),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.last.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, 15),
          )
        ],
      ),
      child: Column(
        children: [

          Icon(icon, size: 45, color: Colors.white),

          const SizedBox(height: 15),

          Text(
            title,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),

          const SizedBox(height: 8),

          Text(
            price,
            style: const TextStyle(
                fontSize: 18,
                color: Colors.white70),
          ),

          const SizedBox(height: 15),

          const Text(
            "✔ Unlimited matches\n"
            "✔ Priority visibility\n"
            "✔ Chat unlock\n"
            "✔ Profile boost",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                height: 1.5),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: colors.last,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 40, vertical: 12),
            ),
            onPressed: () {},
            child: const Text("Manage Plan"),
          )
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
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Colors.white),
        title: const Text(
          "Premium Plans ⭐",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Stack(
        children: [

          animatedBackground(),
          floatingBubbles(),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [

                  const SizedBox(height: 30),

                  planCard(
                    title: "Gold Plan",
                    price: "₹1999 / month",
                    icon: Icons.star,
                    colors: const [
                      Color(0xFFFFD700),
                      Color(0xFFFFA000),
                    ],
                  ),

                  planCard(
                    title: "Diamond Plan",
                    price: "₹3999 / month",
                    icon: Icons.workspace_premium,
                    colors: const [
                      Color(0xFF00C6FF),
                      Color(0xFF0072FF),
                    ],
                  ),

                  planCard(
                    title: "Elite Lifetime",
                    price: "₹14999 one-time",
                    icon: Icons.diamond,
                    colors: const [
                      Color(0xFF8E2DE2),
                      Color(0xFF4A00E0),
                    ],
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}