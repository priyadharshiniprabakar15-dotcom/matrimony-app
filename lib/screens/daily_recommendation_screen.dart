import 'package:flutter/material.dart';
import 'home_screen.dart';

class DailyRecommendationScreen extends StatefulWidget {
  final String userId;

  const DailyRecommendationScreen({super.key, required this.userId});

  @override
  State<DailyRecommendationScreen> createState() =>
      _DailyRecommendationScreenState();
}

class _DailyRecommendationScreenState
    extends State<DailyRecommendationScreen>
    with TickerProviderStateMixin {

  static const Color gold = Color(0xFFD4AF37);

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late AnimationController _heartController;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _heartController.dispose();
    super.dispose();
  }

  void _goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(userId: widget.userId),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: Stack(
        children: [

          // 💖 Floating Pink Hearts
          ...List.generate(6, (index) {
            return AnimatedBuilder(
              animation: _heartController,
              builder: (_, child) {
                final height = MediaQuery.of(context).size.height;
                final progress = (_heartController.value + index * 0.15) % 1;
                return Positioned(
                  left: 30.0 + (index * 50),
                  top: height - (progress * height),
                  child: Opacity(
                    opacity: 1 - progress,
                    child: const Icon(
                      Icons.favorite,
                      size: 20,
                      color: Colors.pinkAccent,
                    ),
                  ),
                );
              },
            );
          }),

          SafeArea(
            child: Column(
              children: [

                // APP BAR
                AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  title: const Text(
                    "Daily Recommendation (1/14)",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: _goToHome,
                    )
                  ],
                ),

                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [

                            // PROFILE CARD
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 15,
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  // MEMBER IMAGE
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                        child: Image.network(
                                          "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg",
                                          height: 380,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.black87,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(Icons.bookmark_border,
                                                  color: Colors.white, size: 16),
                                              SizedBox(width: 4),
                                              Text("Shortlist",
                                                  style: TextStyle(color: Colors.white))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 12),

                                  // VERIFIED
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      children: [
                                        Icon(Icons.verified, color: Colors.blue, size: 18),
                                        SizedBox(width: 5),
                                        Text("Verified",
                                            style: TextStyle(color: Colors.blue)),
                                        SizedBox(width: 15),
                                        Icon(Icons.support_agent,
                                            color: Colors.green, size: 18),
                                        SizedBox(width: 5),
                                        Text("Assisted Service",
                                            style: TextStyle(color: Colors.green)),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      "Sushil Rajs",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: Text(
                                      "32 Yrs • 5'5\" • MS (Engineering) • Analyst\n₹ 25 - 30 lakhs per annum • Chennai",
                                      style: TextStyle(
                                          color: Colors.black87, height: 1.5),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // GOLD BUTTONS
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(color: gold),
                                            ),
                                            onPressed: () {},
                                            child: const Text(
                                              "Don't Show",
                                              style: TextStyle(color: gold),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: gold,
                                              foregroundColor: Colors.white,
                                            ),
                                            onPressed: () {},
                                            icon: const Icon(Icons.mail),
                                            label: const Text(
                                              "Send Message",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}