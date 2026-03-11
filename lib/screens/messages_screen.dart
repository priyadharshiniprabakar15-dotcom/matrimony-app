import 'dart:math';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'home_screen.dart';
import 'chat_detail_screen.dart';

class MessagesScreen extends StatefulWidget {

  final String userId;

  const MessagesScreen({super.key, required this.userId});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with TickerProviderStateMixin {

  late AnimationController _emojiController;
  late AnimationController _heartController;
  late Animation<double> _emojiBlink;

  String emoji = "💌";

  List<dynamic> chats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadChats();

    _emojiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _heartController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat();

    _emojiBlink =
        Tween<double>(begin: 0.5, end: 1).animate(_emojiController);
  }

  Future<void> loadChats() async {

    final data = await ApiService.getChats(widget.userId);

    if (!mounted) return;

    setState(() {
      chats = data;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _emojiController.dispose();
    _heartController.dispose();
    super.dispose();
  }

  void changeEmoji() {
    final emojis = ["💌", "😍", "🔥", "🥰", "💘"];
    setState(() {
      emoji = emojis[Random().nextInt(emojis.length)];
    });
  }

  void goHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
  }

  void openChat(Map<String, dynamic> chat) {

    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) =>
            ChatDetailScreen(chat: chat),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
      ),
    );
  }

  Widget buildChatCard(Map<String, dynamic> chat, int index) {

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        setState(() {
          chats.removeAt(index);
        });
      },
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.redAccent,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 25),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () => openChat(chat),
        child: Container(
          margin:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white.withOpacity(0.12),
            border: Border.all(color: Colors.white24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 25,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Row(
            children: [

              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    chat["image"] ??
                    "https://via.placeholder.com/150"),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      chat["name"] ?? "User",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      chat["message"] ?? "",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),

              Column(
                children: [

                  if (chat["match"] != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        chat["match"],
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),

                  const SizedBox(height: 6),

                  Text(
                    chat["time"] ?? "",
                    style: const TextStyle(
                        fontSize: 12, color: Colors.white60),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget floatingHearts() {

    return AnimatedBuilder(
      animation: _heartController,
      builder: (context, child) {

        return Stack(
          children: List.generate(8, (index) {

            final random = Random(index);

            final double left =
                random.nextDouble() *
                MediaQuery.of(context).size.width;

            final double animationValue =
                (_heartController.value + index * 0.15) % 1;

            return Positioned(
              bottom: animationValue *
                  MediaQuery.of(context).size.height,
              left: left,
              child: Opacity(
                opacity: 1 - animationValue,
                child: Icon(
                  Icons.favorite,
                  color: index % 2 == 0
                      ? Colors.white
                      : Colors.pinkAccent,
                  size: 18 + random.nextDouble() * 18,
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

    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6A0D2F),
                  Color(0xFF9B1C31),
                  Color.fromARGB(255, 242, 163, 173),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          floatingHearts(),

          SafeArea(
            child: Column(
              children: [

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Row(
                    children: [

                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: goHome,
                      ),

                      const Expanded(
                        child: Center(
                          child: Text(
                            "Messages 💬",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                FadeTransition(
                  opacity: _emojiBlink,
                  child: GestureDetector(
                    onTap: changeEmoji,
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 55),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                              color: Colors.white),
                        )
                      : chats.isEmpty
                          ? const Center(
                              child: Text(
                                "No messages yet 💬",
                                style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16),
                              ),
                            )
                          : ListView.builder(
                              itemCount: chats.length,
                              itemBuilder: (context, index) {

                                return buildChatCard(
                                    chats[index], index);
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