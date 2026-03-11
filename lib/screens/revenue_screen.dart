import 'dart:ui';
import 'package:flutter/material.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({super.key});

  @override
  State<RevenueScreen> createState() =>
      _RevenueScreenState();
}

class _RevenueScreenState
    extends State<RevenueScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _floatController;

  late Animation<double> _bgAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    // 🌸 Gradient animation
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
        Tween<double>(begin: -25, end: 25).animate(_floatController);
  }

  @override
  void dispose() {
    _bgController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  // 💰 Revenue Card
  Widget _revenueCard(
      String title, String amount, String growth) {
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
                color: Colors.green.withOpacity(0.15),
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
                      fontSize: 16,
                      color: Colors.black54)),
              const SizedBox(height: 8),
              Text(amount,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
              const SizedBox(height: 5),
              Text("Growth: $growth",
                  style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  // 📊 Small Insight Card
  Widget _insightCard(
      String emoji, String value, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.7),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.15),
                blurRadius: 15,
              )
            ],
          ),
          child: Column(
            children: [
              Text(emoji,
                  style: const TextStyle(fontSize: 26)),
              const SizedBox(height: 6),
              Text(value,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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
        iconTheme:
            const IconThemeData(color: Colors.black),
        title: const Text("💰 Revenue Analytics",
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
                          const Color(0xFFE8F5E9),
                          const Color(0xFFD1C4E9),
                          _bgAnimation.value)!,
                      Color.lerp(
                          const Color(0xFFFFF3E0),
                          const Color(0xFFE1F5FE),
                          _bgAnimation.value)!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),

          // 🌊 Floating Soft Shapes
          Positioned(
            top: -60,
            left: -40,
            child: AnimatedBuilder(
              animation: _floatAnimation,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, _floatAnimation.value),
                  child: Container(
                    width: 230,
                    height: 230,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.withOpacity(0.15),
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
                      color: Colors.blue.withOpacity(0.15),
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

                  _revenueCard(
                      "Total Monthly Revenue",
                      "₹2,45,000",
                      "+18%"),

                  const SizedBox(height: 20),

                  _revenueCard(
                      "Premium Subscriptions",
                      "₹1,20,000",
                      "+12%"),

                  const SizedBox(height: 20),

                  _revenueCard(
                      "Advertisement Revenue",
                      "₹75,000",
                      "+8%"),

                  const SizedBox(height: 30),

                  const Text(
                    "📊 Revenue Insights",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(child: _insightCard("👑", "320", "Premium Users")),
                      const SizedBox(width: 15),
                      Expanded(child: _insightCard("📈", "18%", "Growth Rate")),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(child: _insightCard("💳", "1,024", "Transactions")),
                      const SizedBox(width: 15),
                      Expanded(child: _insightCard("🗓", "30 Days", "Billing Cycle")),
                    ],
                  ),

                  const SizedBox(height: 30),

                  _revenueCard(
                      "Quarterly Projection",
                      "₹7,80,000",
                      "Estimated +22%"),

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