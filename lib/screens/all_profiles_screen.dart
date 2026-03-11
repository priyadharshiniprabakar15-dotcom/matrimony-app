import 'dart:math';
import 'package:flutter/material.dart';
import 'send_interest_screen.dart';
import 'profile_full_details_screen.dart';


class AllProfilesScreen extends StatefulWidget {
  const AllProfilesScreen({super.key});

  @override
  State<AllProfilesScreen> createState() => _AllProfilesScreenState();
}

class _AllProfilesScreenState extends State<AllProfilesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _heartController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  final List<Map<String, String>> profiles = [
    {
      "name": "Justin",
      "location": "Chennai",
      "age": "26 yrs",
      "profession": "Software Engineer",
      "image":
          "https://images.unsplash.com/photo-1547425260-76bcadfb4f2c",
    },
    {
      "name": "Arjun",
      "location": "Coimbatore",
      "age": "28 yrs",
      "profession": "Business Analyst",
      "image":
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
    },
    {
      "name": "Ravi",
      "location": "Ramanad",
      "age": "27 yrs",
      "profession": "Entrepreneur",
      "image":
          "https://images.unsplash.com/photo-1527980965255-d3b416303d12",
    },
  ];

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 900));

    _heartController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat();

    _fadeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _slideAnimation =
        Tween<double>(begin: 40, end: 0).animate(
            CurvedAnimation(parent: _animationController, curve: Curves.easeOut));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _heartController.dispose();
    super.dispose();
  }

  /// 💓 Floating Hearts Background
  Widget _floatingHearts() {
    return AnimatedBuilder(
      animation: _heartController,
      builder: (context, child) {
        return Stack(
          children: List.generate(12, (index) {
            final random = Random(index);
            final width = MediaQuery.of(context).size.width;
            final height = MediaQuery.of(context).size.height;

            final left = random.nextDouble() * width;
            final progress =
                (_heartController.value + index * 0.08) % 1;

            return Positioned(
              bottom: progress * height,
              left: left,
              child: Opacity(
                opacity: (1 - progress).clamp(0.0, 1.0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.pinkAccent.withOpacity(0.15),
                  size: 18 + random.nextDouble() * 20,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF9B1C31),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "All Registered Profiles",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [

          /// 💖 Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFE6EC),
                  Color(0xFFFFF5E1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// 💓 Floating Hearts
          _floatingHearts(),

          /// CONTENT
          FadeTransition(
            opacity: _fadeAnimation,
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                return AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: _profileCard(profiles[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileCard(Map<String, String> profile) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFFF0F3),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [

          /// BIG CIRCLE IMAGE
          CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(profile["image"]!),
          ),

          const SizedBox(height: 20),

          Text(
            profile["name"]!,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9B1C31)),
          ),

          const SizedBox(height: 6),

          Text(
            "${profile["age"]} • ${profile["location"]}",
            style: const TextStyle(color: Colors.black54),
          ),

          const SizedBox(height: 8),

          Text(
            profile["profession"]!,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),

          const SizedBox(height: 20),

          /// Gradient Button
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFF5F6D),
                  Color.fromARGB(255, 255, 113, 241),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ProfileFullDetailsScreen(
        profile: profile,
      ),
    ),
  );
},

              child: const Text(
                "Send Interest ❤️",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 12),

          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF9B1C31),
              side: const BorderSide(color: Color(0xFF9B1C31)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () {},
            child: const Text("View Full Profile"),
          ),
        ],
      ),
    );
  }
}
