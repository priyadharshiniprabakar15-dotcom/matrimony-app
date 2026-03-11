import 'dart:math';
import 'package:flutter/material.dart';
import 'send_interest_screen.dart';

class MatchDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> profile;

  const MatchDetailsScreen({super.key, required this.profile});

  @override
  State<MatchDetailsScreen> createState() =>
      _MatchDetailsScreenState();
}

class _MatchDetailsScreenState
    extends State<MatchDetailsScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController _heartController;

  @override
  void initState() {
    super.initState();

    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  Widget detailTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF800020),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final profile = widget.profile;

    return Scaffold(
      body: Stack(
        children: [

          /// 🌹 Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF9B1C31),
                  Color(0xFFB23A48),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 💕 Floating Hearts
          ...List.generate(6, (index) {
            return AnimatedBuilder(
              animation: _heartController,
              builder: (_, child) {
                final height = MediaQuery.of(context).size.height;
                final progress =
                    (_heartController.value + index * 0.15) % 1;

                return Positioned(
                  left: 30.0 + (index * 60),
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

                /// 🔙 Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [

                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white),
                        onPressed: () =>
                            Navigator.pop(context),
                      ),

                      Row(
                        children: const [
                          Icon(Icons.call, color: Colors.white),
                          SizedBox(width: 10),
                          Icon(Icons.message, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                /// Profile Image
                Hero(
                  tag: profile["image"],
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        NetworkImage(profile["image"]),
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  profile["name"],
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  "Compatibility: ${profile["match"]}%",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                /// Details Card
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFF8E7),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(35),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Personal Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF800020),
                            ),
                          ),
                          const SizedBox(height: 10),

                          detailTile("Age", "28 Years"),
                          detailTile("Height", "5'5\""),
                          detailTile("Religion", "Hindu"),
                          detailTile("Mother Tongue", "Tamil"),
                          detailTile("Marital Status", "Never Married"),

                          const SizedBox(height: 20),

                          const Text(
                            "Professional Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF800020),
                            ),
                          ),
                          const SizedBox(height: 10),

                          detailTile("Education", "B.Tech - IT"),
                          detailTile("Occupation", "Software Engineer"),
                          detailTile("Annual Income", "₹ 12 LPA"),

                          const SizedBox(height: 30),

                          /// 💌 Send Interest
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color(0xFFD4AF37),
                              minimumSize:
                                  const Size(double.infinity, 55),
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      SendInterestScreen(
                                    name: profile["name"],
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              "Send Interest 💌",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ],
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