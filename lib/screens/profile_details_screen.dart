import 'dart:math';
import 'package:flutter/material.dart';
import 'send_interest_screen.dart';
 
class ProfileDetailsScreen extends StatefulWidget {
  final String userId;
  const ProfileDetailsScreen({super.key, required this.userId});
 
  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}
 
class _ProfileDetailsScreenState extends State<ProfileDetailsScreen>
    with TickerProviderStateMixin {
 
  late AnimationController _bubbleController;
  late AnimationController _teddyController;
  late AnimationController _meterController;
  late Animation<double> _teddyFloat;
  late Animation<double> _meterAnimation;
 
  // ── STATIC DUMMY PROFILE (no API) ───────────────────────────
  final Map<String, dynamic> profile = {
    "name":          "Madhu",
    "age":           "26",
    "location":      "Chennai",
    "image":         "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
    "profession":    "Software Engineer",
    "education":     "B.E Computer Science",
    "height":        "5'5\"",
    "religion":      "Hindu",
    "star":          "Rohini",
    "rasi":          "Taurus",
    "dosham":        "No",
    "family_status": "Middle Class",
    "about":         "Looking for a kind and caring partner 💖",
  };
 
  bool isLoading = false;
 
  @override
  void initState() {
    super.initState();
    _bubbleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat();
    _teddyController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    _meterController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _teddyFloat = Tween<double>(begin: -6, end: 6).animate(
        CurvedAnimation(parent: _teddyController, curve: Curves.easeInOut));
    _meterAnimation = Tween<double>(begin: 0, end: 0.92).animate(
        CurvedAnimation(parent: _meterController, curve: Curves.easeOut));
    _meterController.forward();
  }
 
  @override
  void dispose() {
    _bubbleController.dispose();
    _teddyController.dispose();
    _meterController.dispose();
    super.dispose();
  }
 
  Widget _floatingBubbles() {
    return AnimatedBuilder(
      animation: _bubbleController,
      builder: (context, child) => Stack(
        children: List.generate(10, (index) {
          final random   = Random(index);
          final width    = MediaQuery.of(context).size.width;
          final height   = MediaQuery.of(context).size.height;
          final left     = random.nextDouble() * width;
          final progress = (_bubbleController.value + index * 0.1) % 1;
          return Positioned(
            bottom: progress * height,
            left: left,
            child: Opacity(
              opacity: (1 - progress).clamp(0.0, 1.0),
              child: Container(
                width: 15 + random.nextDouble() * 20,
                height: 15 + random.nextDouble() * 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pinkAccent.withOpacity(0.15),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
 
  Widget _compatibilityMeter() {
    return AnimatedBuilder(
      animation: _meterAnimation,
      builder: (context, child) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 110, width: 110,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: _meterAnimation.value,
                  strokeWidth: 8,
                  backgroundColor: Colors.pink.shade100,
                  valueColor:
                      const AlwaysStoppedAnimation(Colors.pinkAccent),
                ),
                Text(
                  "${(_meterAnimation.value * 100).toInt()}%",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Text("Compatibility Match 💖",
              style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
 
  Widget _infoTile(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 6))
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.favorite, color: Colors.pinkAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text("$title: $value",
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
 
  Widget _interestButton() {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                SendInterestScreen(name: profile["name"] ?? "")),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xFFFF758C), Color(0xFFFF7EB3)]),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
                color: Colors.pinkAccent, blurRadius: 15, offset: Offset(0, 8))
          ],
        ),
        child: const Center(
          child: Text("Send Interest 💌",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ),
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
                  colors: [Color(0xFFFFF0F5), Color(0xFFFFE4E1)]),
            ),
          ),
          _floatingBubbles(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context)),
                      const Text("Profile Details 💖",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(profile["image"] ?? ""),
                  ),
                  const SizedBox(height: 12),
                  Text("${profile["name"] ?? ""} 💕",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  Text("${profile["age"] ?? ""} • ${profile["location"] ?? ""}",
                      style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 18),
                  _compatibilityMeter(),
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _teddyFloat,
                    builder: (context, child) => Transform.translate(
                      offset: Offset(0, _teddyFloat.value),
                      child: const Text("🧸", style: TextStyle(fontSize: 55)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _infoTile("Profession",    profile["profession"]    ?? ""),
                  _infoTile("Education",     profile["education"]     ?? ""),
                  _infoTile("Height",        profile["height"]        ?? ""),
                  _infoTile("Religion",      profile["religion"]      ?? ""),
                  _infoTile("Star",          profile["star"]          ?? ""),
                  _infoTile("Rasi",          profile["rasi"]          ?? ""),
                  _infoTile("Dosham",        profile["dosham"]        ?? ""),
                  _infoTile("Family Status", profile["family_status"] ?? ""),
                  _infoTile("About",         profile["about"]         ?? ""),
                  const SizedBox(height: 20),
                  _interestButton(),
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