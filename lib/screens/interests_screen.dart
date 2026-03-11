import 'dart:math';
import 'package:flutter/material.dart';
import 'messages_screen.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _heartController;

  List<Map<String, String>> interestList = [
    {
      "name": "Arjun",
      "age": "28 yrs",
      "location": "Chennai",
      "image":
          "https://images.unsplash.com/photo-1500648767791-00dcc994a43e"
    },
    {
      "name": "Rahul",
      "age": "27 yrs",
      "location": "Coimbatore",
      "image":
          "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e"
    },
    {
      "name": "Vikram",
      "age": "29 yrs",
      "location": "Madurai",
      "image":
          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d"
    },
    {
      "name": "Karthik",
      "age": "30 yrs",
      "location": "Salem",
      "image":
          "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce"
    },
  ];

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
            ),
          ),
        );
      },
    );
  }

  Widget floatingHearts() {
    return AnimatedBuilder(
      animation: _heartController,
      builder: (_, __) {
        return Stack(
          children: List.generate(8, (index) {
            final random = Random(index);
            return Positioned(
              left: random.nextDouble() *
                  MediaQuery.of(context).size.width,
              bottom: (_heartController.value *
                      MediaQuery.of(context).size.height),
              child: Opacity(
                opacity: 0.1,
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 20 + random.nextDouble() * 20,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  void openMessages() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MessagesScreen(userId: "4")),
    );
  }

  void showCallOptions(String name) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF9B1C31),
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Call $name",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.call,
                    color: Colors.white),
                title: const Text("Voice Call",
                    style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.videocam,
                    color: Colors.white),
                title: const Text("Video Call",
                    style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget interestCard(Map<String, String> user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.15),
        border:
            Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              user["image"]!,
              height: 100,
              width: 90,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  "${user["name"]} 💕",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),

                Text(
                  "${user["age"]} • ${user["location"]}",
                  style:
                      const TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: const Text("Accept"),
                      ),
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 216, 85, 85),
                          foregroundColor:
                              Colors.white,
                        ),
                        onPressed: () {},
                        child: const Text("Reject"),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [

                    IconButton(
                      icon: const Icon(Icons.chat,
                          color: Colors.white),
                      onPressed: openMessages,
                    ),

                    IconButton(
                      icon: const Icon(Icons.call,
                          color: Colors.white),
                      onPressed: () =>
                          showCallOptions(user["name"]!),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Interest Requests 💌",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          animatedBackground(),
          floatingHearts(),
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  ...interestList.map(interestCard),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}