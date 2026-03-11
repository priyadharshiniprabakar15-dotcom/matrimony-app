import 'dart:math';
import 'package:flutter/material.dart';

class SendInterestScreen extends StatefulWidget {
  final String name;

  const SendInterestScreen({super.key, required this.name});

  @override
  State<SendInterestScreen> createState() =>
      _SendInterestScreenState();
}

class _SendInterestScreenState
    extends State<SendInterestScreen>
    with TickerProviderStateMixin {

  late AnimationController _heartController;
  late Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();

    _heartController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat(reverse: true);

    _heartScale = Tween<double>(begin: 0.8, end: 1.2).animate(
        CurvedAnimation(parent: _heartController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: const Color(0xFF9B1C31),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Interest Sent 💖",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Stack(
        children: [

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFD1DC),
                  Color(0xFFFFE4E1),
                ],
              ),
            ),
          ),

          /// Floating Hearts
          ...List.generate(15, (index) {
            final random = Random(index);
            return Positioned(
              top: random.nextDouble() *
                  MediaQuery.of(context).size.height,
              left: random.nextDouble() *
                  MediaQuery.of(context).size.width,
              child: const Icon(Icons.favorite,
                  color: Colors.pinkAccent, size: 18),
            );
          }),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                AnimatedBuilder(
                  animation: _heartScale,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _heartScale.value,
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.pinkAccent,
                        size: 100,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                Text(
                  "Interest Sent to ${widget.name} 💖",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "They will be notified instantly!\nHope this turns into something beautiful ✨",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // 👈 back to details
                  },
                  child: const Text("Back to Profile"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}