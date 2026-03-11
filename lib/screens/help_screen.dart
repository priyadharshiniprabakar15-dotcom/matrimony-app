import 'dart:ui';
import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF9B1C31),
              Color(0xFF5C1120),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [

              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Help & Support ❤️",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding:
                        const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color:
                          Colors.white.withOpacity(0.15),
                      borderRadius:
                          BorderRadius.circular(30),
                      border: Border.all(
                          color: Colors.white
                              .withOpacity(0.2)),
                    ),
                    child: Column(
                      children: const [
                        Icon(Icons.headset_mic,
                            color: Colors.white,
                            size: 50),
                        SizedBox(height: 20),
                        Text(
                          "24/7 Support Available",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Call: +91 9876543210",
                          style: TextStyle(
                              color: Colors.white70),
                        ),
                        Text(
                          "support@vivahaelite.com",
                          style: TextStyle(
                              color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
