import 'dart:math';
import 'package:flutter/material.dart';
import 'match_details_screen.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen>
    with TickerProviderStateMixin {

  late AnimationController _emojiController;
  late AnimationController _heartController;
  late Animation<double> _emojiBlink;

  final List<Map<String, dynamic>> matches = [
    {
      "name": "Ananya",
      "match": 94,
      "bio": "Loves travel & music 🎶",
      "image":
          "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e"
    },
    {
      "name": "Rohan",
      "match": 88,
      "bio": "Entrepreneur & fitness lover 💪",
      "image":
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e"
    },
  ];

  String reaction = "😍";

  @override
  void initState() {
    super.initState();

    _emojiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _emojiBlink =
        Tween<double>(begin: 0.5, end: 1).animate(_emojiController);

    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _emojiController.dispose();
    _heartController.dispose();
    super.dispose();
  }

  void changeReaction() {
    final emojis = ["😍", "🔥", "💖", "🥰", "💘"];
    setState(() {
      reaction = emojis[Random().nextInt(emojis.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// 🔴 PREMIUM APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xFF9B1C31),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // Back arrow white
        ),
        title: const Text(
          "Your Matches 💖",
          style: TextStyle(
            color: Colors.white, // Title white
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Stack(
        children: [

          /// 💕 Floating Hearts Background
          ...List.generate(6, (index) {
            return AnimatedBuilder(
              animation: _heartController,
              builder: (_, child) {
                final height = MediaQuery.of(context).size.height;
                final progress =
                    (_heartController.value + index * 0.15) % 1;

                return Positioned(
                  left: 30.0 + (index * 50),
                  top: height - (progress * height),
                  child: Opacity(
                    opacity: 1 - progress,
                    child: const Icon(
                      Icons.favorite,
                      size: 22,
                      color: Colors.pinkAccent,
                    ),
                  ),
                );
              },
            );
          }),

          Column(
            children: [

              const SizedBox(height: 20),

              /// 💖 Blinking Reaction Emoji
              FadeTransition(
                opacity: _emojiBlink,
                child: GestureDetector(
                  onTap: changeReaction,
                  child: Text(
                    reaction,
                    style: const TextStyle(fontSize: 55),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "AI Compatibility Results ✨",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF800000),
                ),
              ),

              const SizedBox(height: 15),

              /// 💍 MATCH LIST
              Expanded(
                child: ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    final match = matches[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 600),
                            pageBuilder: (_, __, ___) =>
                                MatchDetailsScreen(profile: match),
                            transitionsBuilder:
                                (_, animation, __, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFB23A48),
                              Color(0xFF9B1C31),
                            ],
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [

                              /// 👤 Hero Profile Image
                              Hero(
                                tag: match["image"],
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      NetworkImage(match["image"]),
                                ),
                              ),

                              const SizedBox(width: 15),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      match["name"],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight:
                                              FontWeight.bold),
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      match["bio"],
                                      style: const TextStyle(
                                          color: Colors.white70),
                                    ),

                                    const SizedBox(height: 8),

                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: match["match"] / 100,
                                        minHeight: 8,
                                        backgroundColor: Colors.white24,
                                        valueColor:
                                            const AlwaysStoppedAnimation(
                                                Colors.amber),
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      "AI Match: ${match["match"]}%",
                                      style: const TextStyle(
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}