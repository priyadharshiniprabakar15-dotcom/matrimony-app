import 'dart:math';
import 'package:flutter/material.dart';
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
 
  // ── DUMMY CHAT LIST (no API) ─────────────────────────────────
  List<dynamic> chats = [
    {
      "name": "Priya",
      "profile_picture_url": "",
      "last_message": "Hi, how are you? 😊",
      "formatted_date": "10:30 AM",
    },
    {
      "name": "Kavya",
      "profile_picture_url": "",
      "last_message": "Looking forward to meeting 💖",
      "formatted_date": "Yesterday",
    },
    {
      "name": "Anitha",
      "profile_picture_url": "",
      "last_message": "Thank you for connecting!",
      "formatted_date": "Mon",
    },
  ];
 
  bool isLoading    = false;
  String? errorMessage;
 
  @override
  void initState() {
    super.initState();
    _emojiController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..repeat(reverse: true);
    _heartController =
        AnimationController(vsync: this, duration: const Duration(seconds: 6))
          ..repeat();
    _emojiBlink = Tween<double>(begin: 0.5, end: 1).animate(_emojiController);
  }
 
  @override
  void dispose() {
    _emojiController.dispose();
    _heartController.dispose();
    super.dispose();
  }
 
  void changeEmoji() {
    final emojis = ["💌", "😍", "🔥", "🥰", "💘"];
    setState(() => emoji = emojis[Random().nextInt(emojis.length)]);
  }
 
  void goHome() => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen(userId: widget.userId)),
        (route) => false,
      );
 
  void openChat(Map<String, dynamic> chat) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => ChatDetailScreen(chat: chat),
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
              .animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        ),
      ),
    );
  }
 
  Widget buildChatCard(Map<String, dynamic> chat, int index) {
    final String name    = (chat["name"]                ?? "").toString();
    final String image   = (chat["profile_picture_url"] ?? "").toString();
    final String lastMsg = (chat["last_message"]        ?? "").toString();
    final String time    = (chat["formatted_date"]      ?? "").toString();
 
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => setState(() => chats.removeAt(index)),
      background: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: Colors.redAccent),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 25),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GestureDetector(
        onTap: () => openChat(chat),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white.withOpacity(0.12),
            border: Border.all(color: Colors.white24),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 25,
                  offset: const Offset(0, 10)),
            ],
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white24,
                backgroundImage: image.isNotEmpty ? NetworkImage(image) : null,
                child: image.isEmpty
                    ? const Icon(Icons.person, color: Colors.white54)
                    : null,
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name.isNotEmpty ? name : "User",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white)),
                    const SizedBox(height: 5),
                    Text(
                      lastMsg.isNotEmpty ? lastMsg : "Tap to chat 💬",
                      style: const TextStyle(color: Colors.white70),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(time, style: const TextStyle(fontSize: 11, color: Colors.white60)),
            ],
          ),
        ),
      ),
    );
  }
 
  Widget floatingHearts() {
    return AnimatedBuilder(
      animation: _heartController,
      builder: (context, child) => Stack(
        children: List.generate(8, (index) {
          final random         = Random(index);
          final double left    = random.nextDouble() * MediaQuery.of(context).size.width;
          final double animVal = (_heartController.value + index * 0.15) % 1;
          return Positioned(
            bottom: animVal * MediaQuery.of(context).size.height,
            left: left,
            child: Opacity(
              opacity: 1 - animVal,
              child: Icon(
                Icons.favorite,
                color: index % 2 == 0 ? Colors.white : Colors.pinkAccent,
                size: 18 + random.nextDouble() * 18,
              ),
            ),
          );
        }),
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
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: goHome),
                      const Expanded(
                        child: Center(
                          child: Text("Messages 💬",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                FadeTransition(
                  opacity: _emojiBlink,
                  child: GestureDetector(
                    onTap: changeEmoji,
                    child: Text(emoji, style: const TextStyle(fontSize: 55)),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: chats.isEmpty
                      ? const Center(
                          child: Text("No messages yet 💬",
                              style: TextStyle(color: Colors.white70, fontSize: 16)))
                      : ListView.builder(
                          itemCount: chats.length,
                          itemBuilder: (context, index) {
                            final chat = chats[index];
                            if (chat is Map<String, dynamic>) {
                              return buildChatCard(chat, index);
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
