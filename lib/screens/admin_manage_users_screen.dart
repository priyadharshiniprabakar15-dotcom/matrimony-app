import 'dart:math';
import 'package:flutter/material.dart';

class AdminManageUsersScreen extends StatefulWidget {
  const AdminManageUsersScreen({super.key});

  @override
  State<AdminManageUsersScreen> createState() =>
      _AdminManageUsersScreenState();
}

class _AdminManageUsersScreenState
    extends State<AdminManageUsersScreen>
    with TickerProviderStateMixin {

  late AnimationController _bgController;
  late AnimationController _heartController;

  List<Map<String, String>> users = [
    {"name": "Arjun", "status": "Active"},
    {"name": "Rahul", "status": "Pending"},
    {"name": "Madhu", "status": "Premium"},
    {"name": "Divya", "status": "Blocked"},
    {"name": "Karthik", "status": "Active"},
    {"name": "Sneha", "status": "Premium"},
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

  // 💕 Pink Floating Hearts
  Widget floatingHearts() {
    return AnimatedBuilder(
      animation: _heartController,
      builder: (_, __) {
        return Stack(
          children: List.generate(10, (index) {
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
                  color: Colors.pinkAccent,
                  size: 20 + random.nextDouble() * 30,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  // 🎯 Status Icon
  Widget statusIcon(String status) {
    switch (status) {
      case "Active":
        return const Icon(Icons.verified,
            color: Colors.green);
      case "Pending":
        return const Icon(Icons.access_time,
            color: Colors.orange);
      case "Premium":
        return const Icon(Icons.workspace_premium,
            color: Colors.amber);
      case "Blocked":
        return const Icon(Icons.block,
            color: Colors.redAccent);
      default:
        return const SizedBox();
    }
  }

  // 🗑 Delete Confirmation
  void confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color.fromARGB(255, 207, 193, 113),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Delete User?",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Are you sure you want to delete this user?",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel",
                style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                users.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Delete",
                style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  Widget userCard(Map<String, String> user, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white.withOpacity(0.15),
        border:
            Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.person,
                color: Color(0xFF9B1C31)),
          ),
          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(user["name"]!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Row(
                  children: [
                    statusIcon(user["status"]!),
                    const SizedBox(width: 8),
                    Text(user["status"]!,
                        style: const TextStyle(
                            color: Colors.white70)),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () => confirmDelete(index),
            icon: const Icon(Icons.delete,
                color: Colors.white),
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
        iconTheme:
            const IconThemeData(color: Colors.white),
        title: const Text(
          "Manage Users 👥",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Stack(
        children: [

          // 🌈 Animated Gradient Background
          AnimatedBuilder(
            animation: _bgController,
            builder: (_, __) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(
                          const Color(0xFF7F1D1D),
                          const Color(0xFF9B1C31),
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
          ),

          floatingHearts(),

          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return userCard(users[index], index);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}