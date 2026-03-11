import 'dart:math';
import 'package:flutter/material.dart';
import 'messages_screen.dart';

class ProfileFullDetailsScreen extends StatefulWidget {
  final Map<String, String> profile;

  const ProfileFullDetailsScreen({
    super.key,
    required this.profile,
  });

  @override
  State<ProfileFullDetailsScreen> createState() =>
      _ProfileFullDetailsScreenState();
}

class _ProfileFullDetailsScreenState
    extends State<ProfileFullDetailsScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _heartController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    _heartController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat();

    _fadeController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _fadeController.forward();
  }

  @override
  void dispose() {
    _bgController.dispose();
    _heartController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  // 🌈 Animated Background
  Widget animatedBackground() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (_, __) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.lerp(
                    const Color(0xFF7F1D1D),
                    const Color(0xFFB23A48),
                    _bgController.value)!,
                Color.lerp(
                    const Color(0xFF4C0519),
                    const Color(0xFF7F1D1D),
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

  // 💓 Floating Hearts
  Widget floatingHearts() {
    return AnimatedBuilder(
      animation: _heartController,
      builder: (_, __) {
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
                  color: Colors.pinkAccent.withOpacity(0.12),
                  size: 20 + random.nextDouble() * 20,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget detailTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white70),
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme:
            const IconThemeData(color: Colors.white),
        title: const Text(
          "Profile Details 💕",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [

          animatedBackground(),
          floatingHearts(),

          FadeTransition(
            opacity: _fadeAnimation,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    /// PROFILE IMAGE
                    CircleAvatar(
                      radius: 90,
                      backgroundImage:
                          NetworkImage(profile["image"]!),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      profile["name"]!,
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),

                    const SizedBox(height: 10),

                    detailTile("Age", profile["age"]!),
                    detailTile("Location", profile["location"]!),
                    detailTile("Profession", profile["profession"]!),

                    const SizedBox(height: 15),

                    const Text(
                      "About",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Kind-hearted and career-oriented individual looking for a meaningful relationship and lifelong partner. Loves travel, music, and family time.",
                      style: TextStyle(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 25),

                    /// ACTION BUTTONS
                    Row(
                      children: [

                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MessagesScreen(userId: "4"),
                                ),
                              );
                            },
                            icon: const Icon(Icons.chat, color: Colors.white),
                            label: const Text("Message",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.call, color: Colors.white),
                            label: const Text("Call",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFD700),
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Send Interest ❤️",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}