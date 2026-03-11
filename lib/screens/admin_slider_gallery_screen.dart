import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AdminSliderGalleryScreen extends StatefulWidget {
  const AdminSliderGalleryScreen({super.key});

  @override
  State<AdminSliderGalleryScreen> createState() =>
      _AdminSliderGalleryScreenState();
}

class _AdminSliderGalleryScreenState
    extends State<AdminSliderGalleryScreen>
    with TickerProviderStateMixin {

  late PageController _pageController;
  late AnimationController _bgController;
  late AnimationController _emojiController;

  int currentPage = 0;

  // ✅ Real Wedding Couple Images
  final List<Map<String, String>> images = [
    {
      "url":
          "https://images.unsplash.com/photo-1606800052052-a08af7148866?w=1200",
      "title": "Romantic Wedding Couple 💍"
    },
    {
      "url":
          "https://images.unsplash.com/photo-1520854221256-17451cc331bf?w=1200",
      "title": "Beach Side Love 🌊"
    },
    {
      "url":
          "https://images.unsplash.com/photo-1591604466107-ec97de577aff?w=1200",
      "title": "Royal Palace Wedding 👑"
    },
    {
      "url":
          "https://images.unsplash.com/photo-1519741497674-611481863552?w=1200",
      "title": "Pre Wedding Shoot 🌸"
    },
    {
      "url":
          "https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=1200",
      "title": "Golden Hour Romance ✨"
    },
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _bgController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat(reverse: true);

    _emojiController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat();

    Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        currentPage = (currentPage + 1) % images.length;
        _pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bgController.dispose();
    _emojiController.dispose();
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
                    const Color(0xFFFFE6F0),
                    const Color(0xFFE6F0FF),
                    _bgController.value)!,
                Color.lerp(
                    const Color(0xFFFDEBFF),
                    const Color(0xFFE1F5FE),
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

  Widget floatingEmojis() {
    return AnimatedBuilder(
      animation: _emojiController,
      builder: (_, __) {
        return Stack(
          children: List.generate(8, (index) {
            final random = Random(index);
            final width = MediaQuery.of(context).size.width;
            final height = MediaQuery.of(context).size.height;

            return Positioned(
              left: random.nextDouble() * width,
              bottom:
                  (_emojiController.value * height + index * 80) % height,
              child: const Opacity(
                opacity: 0.3,
                child: Text(
                  "💕",
                  style: TextStyle(fontSize: 26),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Slider & Gallery"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Stack(
        children: [
          animatedBackground(),
          floatingEmojis(),

          SingleChildScrollView(
            child: Column(
              children: [

                const SizedBox(height: 20),

                const Text(
                  "Premium Wedding Gallery 💍",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  height: 300,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [

                              Image.network(
                                images[index]["url"]!,
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, progress) {
                                  if (progress == null) return child;
                                  return const Center(
                                    child:
                                        CircularProgressIndicator(
                                            color:
                                                Colors.pinkAccent),
                                  );
                                },
                                errorBuilder:
                                    (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.broken_image,
                                        size: 50),
                                  );
                                },
                              ),

                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black
                                          .withOpacity(0.4),
                                      Colors.transparent
                                    ],
                                    begin:
                                        Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Text(
                                  images[index]["title"]!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // ✅ 90% WIDTH CARD
                Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFFE6F0),
                          Color(0xFFE6F0FF),
                        ],
                      ),
                      borderRadius:
                          BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Colors.pink.withOpacity(0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gallery Highlights 💖",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Text("• Romantic AI Couple Poses"),
                        Text("• Beach Side Wedding Themes"),
                        Text("• Royal Mahal Night Weddings"),
                        Text("• Cinematic Pre Wedding Shoots"),
                        Text("• Luxury Destination Events"),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}