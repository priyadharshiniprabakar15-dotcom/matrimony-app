import 'dart:ui';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool notifications = true;
  bool privateAccount = false;

  Widget glassTile(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
                color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB23A48),
              Color(0xFF5C1120),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [

              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Settings ⚙️",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              glassTile(
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Private Account 🔒",
                        style:
                            TextStyle(color: Colors.white)),
                    Switch(
                      value: privateAccount,
                      activeColor: Colors.amber,
                      onChanged: (val) {
                        setState(() {
                          privateAccount = val;
                        });
                      },
                    ),
                  ],
                ),
              ),

              glassTile(
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Notifications 🔔",
                        style:
                            TextStyle(color: Colors.white)),
                    Switch(
                      value: notifications,
                      activeColor: Colors.amber,
                      onChanged: (val) {
                        setState(() {
                          notifications = val;
                        });
                      },
                    ),
                  ],
                ),
              ),

              glassTile(
                const Text("Language 🌍",
                    style:
                        TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
