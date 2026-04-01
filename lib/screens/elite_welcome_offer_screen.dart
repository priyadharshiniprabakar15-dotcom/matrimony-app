import 'dart:math';
import 'package:flutter/material.dart';
import 'daily_recommendation_screen.dart';

class EliteWelcomeOfferScreen extends StatefulWidget {
  final String userId;

  const EliteWelcomeOfferScreen({super.key, required this.userId});

  @override
  State<EliteWelcomeOfferScreen> createState() =>
      _EliteWelcomeOfferScreenState();
}

class _EliteWelcomeOfferScreenState
    extends State<EliteWelcomeOfferScreen>
    with SingleTickerProviderStateMixin {

  final PageController _pageController =
      PageController(viewportFraction: 0.85);

  int currentPage = 0;
  late AnimationController _heartController;

  @override
  void initState() {
    super.initState();
    _heartController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat();
  }

  @override
  void dispose() {
    _heartController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFE4EC), Color(0xFFFFF6E5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Floating Hearts
          ...List.generate(5, (index) {
            return AnimatedBuilder(
              animation: _heartController,
              builder: (_, child) {
                final height = MediaQuery.of(context).size.height;
                final progress =
                    (_heartController.value + index * 0.2) % 1;
                return Positioned(
                  left: 40.0 + (index * 60),
                  top: height - (progress * height),
                  child: Opacity(
                    opacity: 1 - progress,
                    child: const Icon(Icons.favorite,
                        size: 18, color: Colors.pinkAccent),
                  ),
                );
              },
            );
          }),

          SafeArea(
            child: Column(
              children: [

                const SizedBox(height: 20),

                const Column(
                  children: [
                    Icon(Icons.card_giftcard, size: 45, color: Colors.pink),
                    SizedBox(height: 8),
                    Text(
                      "Welcome Offer",
                      style: TextStyle(
                          fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Save upto 58% + 21 Days Money Back Guarantee!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    onPageChanged: (index) =>
                        setState(() => currentPage = index),
                    itemBuilder: (context, index) => _priceCard(index),
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: currentPage == index ? 22 : 8,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? Colors.pink
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View All Packages >",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.w600),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DailyRecommendationScreen(
                            userId: widget.userId),
                      ),
                    );
                  },
                  child: const Text(
                    "Skip >",
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600),
                  ),
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceCard(int index) {
    final plans = [
      {"title": "Gold",       "discount": "27% OFF", "old": "₹ 5,500",  "price": "₹ 4,000"},
      {"title": "Prime Gold", "discount": "40% OFF", "old": "₹ 8,000",  "price": "₹ 4,800"},
      {"title": "Till U Marry","discount": "58% OFF","old": "₹ 23,700", "price": "₹ 9,900"},
    ];

    bool isActive = currentPage == index;

    return AnimatedScale(
      scale: isActive ? 1 : 0.92,
      duration: const Duration(milliseconds: 400),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.15),
                blurRadius: 20,
                spreadRadius: 3,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(plans[index]["title"]!,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)),
                Text(plans[index]["discount"]!,
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold)),
                Text(plans[index]["old"]!,
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey)),
                Text(plans[index]["price"]!,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold)),
                const Icon(Icons.favorite, color: Colors.pink, size: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Pay Now",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}