import 'dart:math';
import 'package:flutter/material.dart';
import 'notification_detail_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState
    extends State<NotificationScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;

  @override
  void initState() {
    super.initState();

    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  Widget _floatingIcons() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (context, child) {
        return Stack(
          children: List.generate(8, (index) {
            final random = Random(index);
            final width = MediaQuery.of(context).size.width;
            final height = MediaQuery.of(context).size.height;

            return Positioned(
              top: random.nextDouble() * height,
              left: random.nextDouble() * width,
              child: Icon(
                Icons.favorite,
                color: Colors.white.withOpacity(0.1),
                size: 30,
              ),
            );
          }),
        );
      },
    );
  }

  Widget _notificationTile(
    String name,
    String subtitle,
    IconData icon,
    String image,
    String message) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NotificationDetailScreen(
            name: name,
            image: image,
            message: message,
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 6))
        ],
      ),
      child: Row(
        children: [
          Hero(
            tag: name,
            child: CircleAvatar(
              backgroundImage: NetworkImage(image),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: const TextStyle(
                        color: Colors.black54)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          AnimatedBuilder(
            animation: _bgController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                          const Color(0xFFFF758C),
                          const Color(0xFFFF7EB3),
                          _bgController.value)!,
                      const Color(0xFFFFC3A0),
                    ],
                  ),
                ),
              );
            },
          ),

          _floatingIcons(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [

                  const Text(
                    "Notifications 🔔",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),

                  const SizedBox(height: 20),

                  _notificationTile(
  "Arjun",
  "liked your profile ❤️",
  Icons.favorite,
  "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
  "Arjun showed interest in your profile. You both have 85% compatibility!",
),

_notificationTile(
  "Madhu",
  "New Match Found 💍",
  Icons.star,
  "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
  "Congratulations! You and Madhu are a perfect match.",
),

_notificationTile(
  "Madhu",
  "viewed your profile 👀",
  Icons.remove_red_eye,
  "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
  "Madhu recently viewed your profile. Start a conversation now!",
),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
