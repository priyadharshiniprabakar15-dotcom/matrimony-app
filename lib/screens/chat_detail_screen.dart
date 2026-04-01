import 'dart:math';
import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  final Map<String, dynamic> chat;

  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _heartController;

  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> messages = [];
  bool isSending = false;

  String currentUserId = "4";

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
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String get receiverName {
    return widget.chat["name"]          ??
           widget.chat["receiver_name"] ??
           widget.chat["sender_name"]   ?? "User";
  }

  String get receiverImage {
    return widget.chat["profile_picture_url"] ??
           widget.chat["image"]               ??
           widget.chat["profile_image"]       ?? "";
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty || isSending) return;

    setState(() {
      isSending = true;
      messages.add({
        "sender_id": currentUserId,
        "message":   text,
        "time":      "Just now",
        "is_mine":   true,
      });
      _messageController.clear();
      isSending = false;
    });

    scrollToBottom();
  }

  Widget animatedBackground() {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (_, __) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.lerp(const Color(0xFF6A0D2F),
                  const Color(0xFF9B1C31), _bgController.value)!,
              Color.lerp(const Color(0xFF9B1C31),
                  const Color(0xFFB23A48), _bgController.value)!,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget floatingHearts() {
    return AnimatedBuilder(
      animation: _heartController,
      builder: (_, __) => Stack(
        children: List.generate(6, (index) {
          final random = Random(index);
          final double animationValue =
              (_heartController.value + index * 0.15) % 1;
          return Positioned(
            bottom: animationValue * MediaQuery.of(context).size.height,
            left: random.nextDouble() * MediaQuery.of(context).size.width,
            child: Opacity(
              opacity: (1 - animationValue) * 0.15,
              child: Icon(Icons.favorite,
                  color: Colors.white,
                  size: 15 + random.nextDouble() * 15),
            ),
          );
        }),
      ),
    );
  }

  Widget messageBubble(Map<String, dynamic> msg) {
    final bool isMine = msg["is_mine"] == true ||
        (msg["sender_id"] ?? "").toString() == currentUserId ||
        (msg["from_user_id"] ?? "").toString() == currentUserId;

    final String text = msg["message"] ??
                        msg["msg"]     ??
                        msg["text"]    ?? "";

    final String time = msg["time"]           ??
                        msg["formatted_date"] ??
                        msg["timestamp"]      ?? "";

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        decoration: BoxDecoration(
          color: isMine
              ? const Color(0xFFFF758C)
              : Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            topLeft:     const Radius.circular(20),
            topRight:    const Radius.circular(20),
            bottomLeft:  Radius.circular(isMine ? 20 : 4),
            bottomRight: Radius.circular(isMine ? 4 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            if (time.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  time,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 10,
                  ),
                ),
              ),
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
          animatedBackground(),
          floatingHearts(),
          SafeArea(
            child: Column(
              children: [

                // ---- TOP BAR ----
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white24,
                        backgroundImage: receiverImage.isNotEmpty
                            ? NetworkImage(receiverImage)
                            : null,
                        child: receiverImage.isEmpty
                            ? const Icon(Icons.person, color: Colors.white54)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              receiverName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Online 💚",
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.white),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.videocam, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),

                // ---- MESSAGES LIST ----
                Expanded(
                  child: messages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("💌", style: TextStyle(fontSize: 50)),
                              const SizedBox(height: 12),
                              Text(
                                "Say hi to $receiverName! 👋",
                                style: const TextStyle(
                                    color: Colors.white70, fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: messages.length,
                          itemBuilder: (context, index) =>
                              messageBubble(messages[index]),
                        ),
                ),

                // ---- TEXT INPUT BAR ----
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Type a message... 💬",
                            hintStyle: TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => sendMessage(),
                        ),
                      ),
                      GestureDetector(
                        onTap: sendMessage,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF758C), Color(0xFFFF7EB3)],
                            ),
                          ),
                          child: const Icon(Icons.send, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
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