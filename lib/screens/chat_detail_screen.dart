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

  late AnimationController _typingController;
  late AnimationController _heartController;

  final TextEditingController _messageController =
      TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    super.initState();

    messages = [
      {"text": "Hello Madhu 😊", "isMe": false},
      {"text": "Nice to meet you 💖", "isMe": true},
    ];

    _typingController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();

    _heartController =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat();
  }

  @override
  void dispose() {
    _typingController.dispose();
    _heartController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add({
        "text": _messageController.text.trim(),
        "isMe": true
      });
    });

    _messageController.clear();
  }

  /// 💗 Floating Heart Particles
  Widget floatingHearts() {
    return AnimatedBuilder(
      animation: _heartController,
      builder: (context, child) {
        return Stack(
          children: List.generate(8, (index) {
            double progress =
                (_heartController.value + index * 0.12) % 1;

            return Positioned(
              bottom: progress * MediaQuery.of(context).size.height,
              left: 20 + index * 45,
              child: Opacity(
                opacity: 0.25,
                child: Text(
                  index % 2 == 0 ? "💗" : "🤍",
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  /// 💬 Typing Indicator
  Widget typingIndicator() {
    return AnimatedBuilder(
      animation: _typingController,
      builder: (_, __) {
        int dots = (_typingController.value * 3).floor();
        return Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            "Typing${"." * dots}",
            style: const TextStyle(color: Colors.white60),
          ),
        );
      },
    );
  }

  Widget bubble(String text, bool isMe) {
    return Align(
      alignment:
          isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: isMe
              ? const LinearGradient(
                  colors: [
                    Color(0xFFFFD700),
                    Color(0xFFFFB300)
                  ],
                )
              : LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.08),
                  ],
                ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [

          /// 🌈 Premium Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6A0D2F),
                  Color(0xFFB23A48),
                  Color(0xFF8E244D),
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

                /// 🔝 Top Bar
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.chat["image"]),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        widget.chat["name"],
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                            BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.chat["match"],
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),

                const SizedBox(height: 10),

                /// 💬 Chat Messages
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return bubble(
                          msg["text"], msg["isMe"]);
                    },
                  ),
                ),

                typingIndicator(),

                /// ✉️ Message Input
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          style:
                              const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "Type your message...",
                            hintStyle:
                                TextStyle(color: Colors.white54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: sendMessage,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFFD700),
                                Color(0xFFFFB300)
                              ],
                            ),
                          ),
                          child: const Icon(Icons.send,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

