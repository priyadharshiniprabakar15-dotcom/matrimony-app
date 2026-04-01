import 'dart:math';
import 'package:flutter/material.dart';
import 'messages_screen.dart';
 
class InterestsScreen extends StatefulWidget {
  final String userId;
  const InterestsScreen({super.key, required this.userId});
 
  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}
 
class _InterestsScreenState extends State<InterestsScreen>
    with TickerProviderStateMixin {
 
  late AnimationController _bgController;
  late AnimationController _heartController;
 
  // ── DUMMY DATA (no API) ──────────────────────────────────────
  List<dynamic> pendingList = [
    {
      "user_id": "10",
      "name": "Priya",
      "age": "24",
      "city": "Chennai",
      "occupation": "Teacher",
      "profile_picture_url": "",
    },
    {
      "user_id": "11",
      "name": "Kavya",
      "age": "27",
      "city": "Madurai",
      "occupation": "Doctor",
      "profile_picture_url": "",
    },
  ];
 
  List<dynamic> acceptedList = [
    {
      "user_id": "20",
      "name": "Anitha",
      "age": "25",
      "city": "Coimbatore",
      "occupation": "Engineer",
      "profile_picture_url": "",
    },
  ];
 
  bool isLoading   = false;
  String? errorMessage;
  int selectedTab  = 0;
 
  @override
  void initState() {
    super.initState();
    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);
    _heartController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat();
  }
 
  @override
  void dispose() {
    _bgController.dispose();
    _heartController.dispose();
    super.dispose();
  }
 
  // ── MOCK ACTION (no API) ─────────────────────────────────────
  void handleInterestAction(String fromUserId, String action, int index) {
    setState(() {
      if (selectedTab == 0) {
        pendingList.removeAt(index);
      } else {
        acceptedList.removeAt(index);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(action == "accept"
          ? "Interest accepted! 💖"
          : "Interest rejected."),
      backgroundColor: action == "accept" ? Colors.green : Colors.redAccent,
      behavior: SnackBarBehavior.floating,
    ));
  }
 
  Widget animatedBackground() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (_, __) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.lerp(const Color(0xFF7F1D1D),
                  const Color(0xFFB23A48), _bgController.value)!,
              Color.lerp(const Color(0xFF4C0519),
                  const Color(0xFF7F1D1D), _bgController.value)!,
            ],
          ),
        ),
      ),
    );
  }
 
  Widget floatingHearts() {
    return AnimatedBuilder(
      animation: _heartController,
      builder: (_, __) => Stack(
        children: List.generate(8, (index) {
          final random = Random(index);
          return Positioned(
            left: random.nextDouble() * MediaQuery.of(context).size.width,
            bottom: _heartController.value * MediaQuery.of(context).size.height,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.favorite,
                  color: Colors.white,
                  size: 20 + random.nextDouble() * 20),
            ),
          );
        }),
      ),
    );
  }
 
  void showCallOptions(String name) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF9B1C31),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Call $name",
                style: const TextStyle(
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.call, color: Colors.white),
              title: const Text("Voice Call", style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.videocam, color: Colors.white),
              title: const Text("Video Call", style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
 
  Widget interestCard(Map<String, dynamic> user, int index) {
    final String name   = user["name"]                ?? "Unknown";
    final String city   = user["city"]                ?? "";
    final String image  = user["profile_picture_url"] ?? "";
    final String fromId = (user["user_id"]            ?? "").toString();
    final String age    = (user["age"]                ?? "").toString();
    final String job    = user["occupation"]          ?? "";
 
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.15),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: image.isNotEmpty
                ? Image.network(image, height: 100, width: 90, fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholderAvatar())
                : _placeholderAvatar(),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$name 💕",
                    style: const TextStyle(
                        color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                if (age.isNotEmpty || city.isNotEmpty)
                  Text(
                    [if (age.isNotEmpty) "$age yrs", if (city.isNotEmpty) city].join(" • "),
                    style: const TextStyle(color: Colors.white70),
                  ),
                if (job.isNotEmpty)
                  Text(job, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                const SizedBox(height: 10),
                if (selectedTab == 0)
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white),
                          onPressed: () => handleInterestAction(fromId, "accept", index),
                          child: const Text("Accept"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 216, 85, 85),
                              foregroundColor: Colors.white),
                          onPressed: () => handleInterestAction(fromId, "reject", index),
                          child: const Text("Reject"),
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chat, color: Colors.white),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MessagesScreen(userId: widget.userId)),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.call, color: Colors.white),
                      onPressed: () => showCallOptions(name),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _placeholderAvatar() {
    return Container(
      height: 100, width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withOpacity(0.2),
      ),
      child: const Icon(Icons.person, color: Colors.white54, size: 40),
    );
  }
 
  Widget _tabButton(String label, int tabIndex, int count) {
    final bool isSelected = selectedTab == tabIndex;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = tabIndex),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          "$label ($count)",
          style: TextStyle(
            color: isSelected ? const Color(0xFF7F1D1D) : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    final List<dynamic> currentList =
        selectedTab == 0 ? pendingList : acceptedList;
 
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Interest Requests 💌",
            style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          animatedBackground(),
          floatingHearts(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      _tabButton("Pending",  0, pendingList.length),
                      const SizedBox(width: 12),
                      _tabButton("Accepted", 1, acceptedList.length),
                    ],
                  ),
                ),
                Expanded(
                  child: currentList.isEmpty
                      ? Center(
                          child: Text(
                            selectedTab == 0
                                ? "No pending requests 💌"
                                : "No accepted requests yet",
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 50),
                          itemCount: currentList.length,
                          itemBuilder: (context, index) {
                            final user = currentList[index];
                            if (user is Map<String, dynamic>) {
                              return interestCard(user, index);
                            }
                            return const SizedBox.shrink();
                          },
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
