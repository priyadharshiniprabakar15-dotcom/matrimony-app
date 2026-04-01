import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
 
class ShortlistedScreen extends StatefulWidget {
  const ShortlistedScreen({super.key});
 
  @override
  State<ShortlistedScreen> createState() => _ShortlistedScreenState();
}
 
class _ShortlistedScreenState extends State<ShortlistedScreen>
    with TickerProviderStateMixin {
 
  late AnimationController _heartBeatController;
  late AnimationController _floatingController;
  late Animation<double> _heartScale;
  late Animation<double> _heartGlow;
 
  final List<Map<String, String>> shortlisted = [
    {
      "name": "Rohan",
      "profession": "Engineer",
      "location": "Coimbatore",
      "image": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
    },
    {
      "name": "Arjun",
      "profession": "Architect",
      "location": "Chennai",
      "image": "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d",
    },
  ];
 
  @override
  void initState() {
    super.initState();
 
    _heartBeatController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
          ..repeat(reverse: true);
 
    _heartScale = Tween<double>(begin: 0.9, end: 1.1).animate(
        CurvedAnimation(parent: _heartBeatController, curve: Curves.easeInOut));
 
    _heartGlow = Tween<double>(begin: 8, end: 25).animate(
        CurvedAnimation(parent: _heartBeatController, curve: Curves.easeInOut));
 
    _floatingController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat();
  }
 
  @override
  void dispose() {
    _heartBeatController.dispose();
    _floatingController.dispose();
    super.dispose();
  }
 
  Widget _floatingHearts() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Stack(
          children: List.generate(8, (index) {
            final random       = Random(index);
            final screenWidth  = MediaQuery.of(context).size.width;
            final screenHeight = MediaQuery.of(context).size.height;
            final left         = random.nextDouble() * screenWidth;
            final animVal      = (_floatingController.value + index * 0.15) % 1;
            final opacity      = (1 - animVal).clamp(0.0, 1.0);
 
            return Positioned(
              bottom: animVal * screenHeight,
              left: left,
              child: Opacity(
                opacity: opacity * 0.6,
                child: Icon(
                  Icons.favorite,
                  color: index % 2 == 0 ? Colors.white : Colors.pinkAccent,
                  size: 16 + random.nextDouble() * 14,
                ),
              ),
            );
          }),
        );
      },
    );
  }
 
  Widget _beatingHeart() {
    return AnimatedBuilder(
      animation: _heartBeatController,
      builder: (context, child) {
        return Transform.scale(
          scale: _heartScale.value,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.pinkAccent.withOpacity(0.5),
                  blurRadius: _heartGlow.value,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(Icons.favorite, color: Colors.pinkAccent, size: 85),
          ),
        );
      },
    );
  }
 
  Widget _glassCard(Map<String, String> person) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.12),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white24,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: person["image"]!,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 300),
                placeholder: (context, url) => const SizedBox(
                  width: 20, height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                ),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(person["name"]!,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                Text("${person["profession"]} • ${person["location"]}",
                    style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 6),
                const Text("Compatibility: 92% 💖",
                    style: TextStyle(color: Colors.white60)),
              ],
            ),
          ),
        ],
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A0D2F), Color(0xFF9B1C31), Color(0xFFB23A48)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          _floatingHearts(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text("Shortlisted 💕",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(child: _beatingHeart()),
                  const SizedBox(height: 15),
                  const Text("Your Heart Has Chosen Wisely 💎",
                      style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white.withOpacity(0.12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Text("2",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                          Text("Shortlisted", style: TextStyle(color: Colors.white70)),
                        ]),
                        Column(children: [
                          Text("92%",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                          Text("Avg Match", style: TextStyle(color: Colors.white70)),
                        ]),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  ...shortlisted.map((e) => _glassCard(e)),
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
 