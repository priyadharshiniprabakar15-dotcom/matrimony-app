import 'package:flutter/material.dart';

class NotificationDetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final String message;

  const NotificationDetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.message,
  });

  @override
  State<NotificationDetailScreen> createState() =>
      _NotificationDetailScreenState();
}

class _NotificationDetailScreenState
    extends State<NotificationDetailScreen>
    with TickerProviderStateMixin {

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Stack(
          children: [

            /// Background Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF9B1C31),
                    Color(0xFFB23A48),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

            SafeArea(
              child: Column(
                children: [

                  /// Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// Profile Image
                  Hero(
                    tag: widget.name,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage:
                          NetworkImage(widget.image),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      widget.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Info Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(
                                top: Radius.circular(40)),
                      ),
                      child: Column(
                        children: const [

                          ListTile(
                            leading: Icon(Icons.work,
                                color: Color(0xFFB23A48)),
                            title: Text("Software Engineer"),
                          ),

                          ListTile(
                            leading: Icon(Icons.location_on,
                                color: Color(0xFFB23A48)),
                            title: Text("Chennai"),
                          ),

                          ListTile(
                            leading: Icon(Icons.favorite,
                                color: Color(0xFFB23A48)),
                            title: Text(
                                "Looking for meaningful relationship"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}