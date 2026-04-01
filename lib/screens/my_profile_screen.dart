import 'dart:math';
import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

class MyProfileScreen extends StatefulWidget {
  final String userId; // ✅ ADD THIS

  const MyProfileScreen({
    super.key,
    required this.userId,
  });

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _heartController;
  late Animation<double> _heartFloat;

  @override
  void initState() {
    super.initState();

    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat(reverse: true);

    _heartController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);

    _heartFloat = Tween<double>(begin: -10, end: 10).animate(
        CurvedAnimation(parent: _heartController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _bgController.dispose();
    _heartController.dispose();
    super.dispose();
  }

  Widget _floatingHearts() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (context, child) {
        return Stack(
          children: List.generate(10, (index) {
            final random = Random(index);
            final width = MediaQuery.of(context).size.width;
            final height = MediaQuery.of(context).size.height;

            final left = random.nextDouble() * width;
            final progress =
                (_bgController.value + index * 0.1) % 1;

            return Positioned(
              bottom: progress * height,
              left: left,
              child: Opacity(
                opacity: (1 - progress).clamp(0.0, 1.0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.pinkAccent.withOpacity(0.2),
                  size: 18,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _infoCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 6))
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: Colors.pinkAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$title: $value",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pinkAccent)),
        Text(label, style: const TextStyle(color: Colors.black54))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [

          /// Animated Background
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                          const Color(0xFFFFF0F5),
                          const Color(0xFFFFE4E1),
                          _bgController.value)!,
                      const Color(0xFFFFD1DC),
                    ],
                  ),
                ),
              );
            },
          ),

          _floatingHearts(),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [

                  const Text(
                    "My Profile 💖",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e"),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Madhu 💎",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),

                  const Text(
                    "26 yrs • Chennai",
                    style: TextStyle(color: Colors.black54),
                  ),

                  const SizedBox(height: 20),

                  AnimatedBuilder(
                    animation: _heartFloat,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _heartFloat.value),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.pinkAccent,
                          size: 40,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 25),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: Offset(0, 8))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: [
                        _statItem("120", "Views"),
                        _statItem("35", "Interests"),
                        _statItem("12", "Matches"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  _infoCard("Profession", "Software Engineer"),
                  _infoCard("Education", "B.E Computer Science"),
                  _infoCard("Height", "5'5\""),
                  _infoCard("Religion", "Hindu"),
                  _infoCard("Star", "Rohini"),
                  _infoCard("Rasi", "Taurus"),

                  const SizedBox(height: 30),

                  /// ✅ FIXED BUTTON
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProfileScreen(
                            userId: widget.userId, // ✅ PASS HERE
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Edit Profile ✏️",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}