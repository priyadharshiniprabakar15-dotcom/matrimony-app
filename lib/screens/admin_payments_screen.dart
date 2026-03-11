import 'dart:math';
import 'package:flutter/material.dart';

class AdminPaymentsScreen extends StatefulWidget {
  const AdminPaymentsScreen({super.key});

  @override
  State<AdminPaymentsScreen> createState() =>
      _AdminPaymentsScreenState();
}

class _AdminPaymentsScreenState
    extends State<AdminPaymentsScreen>
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

  // 🌈 Animated Gradient Background
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

  // 💰 Floating Money Bubbles
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
                opacity: 0.1,
                child: Icon(
                  Icons.currency_rupee,
                  color: Colors.greenAccent,
                  size: 20 + random.nextDouble() * 25,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  // 📊 Summary Card
  Widget summaryCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.9),
              color.withOpacity(0.6),
            ],
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 8),
            Text(value,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            Text(title,
                style: const TextStyle(
                    color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  // 💳 Payment Card
  Widget paymentCard(String user, String amount) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.12),
        border: Border.all(color: Colors.white24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(user,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              const SizedBox(height: 5),
              const Text("Successful",
                  style:
                      TextStyle(color: Colors.white70)),
            ],
          ),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.end,
            children: [
              Text(amount,
                  style: const TextStyle(
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "+12%",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white),
                ),
              )
            ],
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
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Colors.white),
        title: const Text(
          "Payments 💳",
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

                  const SizedBox(height: 20),

                  // 📊 Revenue Summary
                  Row(
                    children: [
                      summaryCard(
                          "Total Revenue",
                          "₹2,49,999",
                          Icons.account_balance_wallet,
                          Colors.purple),
                      summaryCard(
                          "This Month",
                          "₹89,000",
                          Icons.trending_up,
                          Colors.blue),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Recent Transactions",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 15),

                  paymentCard("Arjun", "₹1999"),
                  paymentCard("Madhu", "₹3999"),
                  paymentCard("Rahul", "₹14999"),
                  paymentCard("Sneha", "₹3999"),
                  paymentCard("Karthik", "₹1999"),

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