import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'matches_screen.dart';
import 'messages_screen.dart';
import 'shortlisted_screen.dart';
import 'settings_screen.dart';
import 'help_screen.dart';
import 'profile_details_screen.dart';
import 'my_profile_screen.dart';
import 'pricing_screen.dart';
import 'notification_screen.dart';
import 'interests_screen.dart';
import 'all_profiles_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {

  late AnimationController _fadeController;
  late AnimationController _emojiController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _emojiScale;

  int _selectedIndex = 0;

  final List<String> _emojiList = [
    "😍", "😘", "🥰", "💖", "💘", "💞"
  ];

  String _currentEmoji = "😍";

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _emojiController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _emojiScale =
        Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _emojiController, curve: Curves.easeInOut),
    );

    _fadeController.forward();

    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentEmoji =
            _emojiList[Random().nextInt(_emojiList.length)];
      });
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _emojiController.dispose();
    super.dispose();
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget _statsCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15,
            offset: Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFB23A48), size: 28),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF800000))),
          Text(title,
              style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _profileCard(
      String name, String age, String location, String image) {

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            Image.network(
              image,
              height: 260,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              height: 260,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black54,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$name 💕",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text("$age • $location",
                      style: const TextStyle(
                          color: Colors.white70)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
Widget _drawerStat(String title, String value) {
  return Column(
    children: [
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      const SizedBox(height: 4),
      Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
        ),
      ),
    ],
  );
}
Widget _drawerCard(IconData icon, String title, Widget screen) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
    ),
    child: ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.white,
        size: 16,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(
  child: Container(
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
    child: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              const SizedBox(height: 20),

              /// 💖 Animated Emoji
              ScaleTransition(
                scale: _emojiScale,
                child: Text(
                  _currentEmoji,
                  style: const TextStyle(fontSize: 50),
                ),
              ),

              const SizedBox(height: 15),

              /// 👤 Profile Image
              const CircleAvatar(
                radius: 45,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 45,
                  color: Color(0xFF9B1C31),
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Madhu 💎",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Premium Member ✨",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 25),
              Align(
  alignment: Alignment.centerRight,
  child: TextButton.icon(
    style: TextButton.styleFrom(
      backgroundColor: const Color(0xFF9B1C31),
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AllProfilesScreen(),
        ),
      );
    },
    icon: const Icon(Icons.people,
        color: Colors.white),
    label: const Text(
      "All Profiles",
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold),
    ),
  ),
),

              /// 📊 Profile Completion
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profile Completion",
                  style: TextStyle(color: Colors.white70),
                ),
              ),

              const SizedBox(height: 8),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const LinearProgressIndicator(
                  value: 0.75,
                  minHeight: 8,
                  backgroundColor: Colors.white24,
                  valueColor:
                      AlwaysStoppedAnimation(Color(0xFFFFD700)),
                ),
              ),

              const SizedBox(height: 25),

              /// 📈 Quick Stats
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  _drawerStat("Matches", "12"),
                  _drawerStat("Views", "48"),
                  _drawerStat("Messages", "8"),
                ],
              ),

              const SizedBox(height: 30),

              /// 📋 Navigation Options
             _drawerCard(Icons.home, "Home", const HomeScreen()),
_drawerCard(Icons.favorite, "My Matches", const MatchesScreen()),
_drawerCard(Icons.chat, "Messages", const MessagesScreen(userId: "4")),
_drawerCard(Icons.star, "Shortlisted", const ShortlistedScreen()),
_drawerCard(Icons.workspace_premium, "Pricing Plans", const PricingScreen()),
_drawerCard(Icons.settings, "Settings", const SettingsScreen()),
_drawerCard(Icons.help_outline, "Help & Support", const HelpScreen()),

              const SizedBox(height: 30),

              /// 🚀 Premium Banner
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white.withOpacity(0.15),
                ),
                child: Column(
                  children: const [
                    Icon(Icons.workspace_premium,
                        color: Colors.amber, size: 35),
                    SizedBox(height: 8),
                    Text(
                      "Unlock Unlimited Matches 💖",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// 🔓 Logout Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFFFD700),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 40),
                ),
                onPressed: _logout,
                child: const Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    ),
  ),
),


      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF1E6),
              Color(0xFFFFE0C2),
            ],
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) =>
                            IconButton(
                          icon: const Icon(Icons.menu,
                              color: Color(0xFF800000)),
                          onPressed: () =>
                              Scaffold.of(context)
                                  .openDrawer(),
                        ),
                      ),
                      const Text("Elite 💍",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight:
                                  FontWeight.bold,
                              color:
                                  Color(0xFF800000))),
                     IconButton(
  icon: const Icon(
    Icons.notifications_none,
    color: Color(0xFF800000),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const NotificationScreen(),
      ),
    );
  },
),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF9B1C31),
                          Color(0xFFB23A48),
                        ],
                      ),
                      borderRadius:
                          BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        ScaleTransition(
                          scale: _emojiScale,
                          child: Text(
                            _currentEmoji,
                            style: const TextStyle(
                                fontSize: 50),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Find Love That Lasts Forever ❤️",
                          textAlign:
                              TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    children: [

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const MatchesScreen()),
                            );
                          },
                          child: _statsCard(
                              "New Matches",
                              "12",
                              Icons.favorite),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const MessagesScreen(userId: "4")),
                            );
                          },
                          child: _statsCard(
                              "Messages",
                              "8",
                              Icons.chat),
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Recommended For You ✨",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Color(0xFF800000)),
                  ),

                  const SizedBox(height: 15),

                /// 💕 Madhu Card
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileDetailsScreen(
          name: "Madhu",
          age: "26 yrs",
          location: "Chennai",
          image:
              "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
        ),
      ),
    );
  },
  child: _profileCard(
    "Madhu",
    "26 yrs",
    "Chennai",
    "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
  ),
),

/// 💙 Arjun Card
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileDetailsScreen(
          name: "Arjun",
          age: "28 yrs",
          location: "Coimbatore",
          image:
              "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        ),
      ),
    );
  },
  child: _profileCard(
    "Arjun",
    "28 yrs",
    "Coimbatore",
    "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
  ),
),
  ],
),
),
),
),
),


bottomNavigationBar: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.grey.shade200,
        Colors.grey.shade100,
      ],
    ),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, -2),
      )
    ],
  ),
  child: BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.transparent,
    elevation: 0,
    currentIndex: _selectedIndex,

    selectedItemColor: const Color(0xFFFFD700), // GOLD
    unselectedItemColor: const Color.fromARGB(255, 184, 34, 34),

    selectedLabelStyle: const TextStyle(
      fontWeight: FontWeight.bold,
    ),

    onTap: (index) {
      setState(() {
        _selectedIndex = index;
      });

      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MatchesScreen()),
        );
      } 
      else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const InterestsScreen()),
        );
      }
      else if (index == 3) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MyProfileScreen()),
        );
      }
    },

    items: [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: _selectedIndex == 0
              ? const Color(0xFFFFD700)
              :const Color.fromARGB(255, 184, 34, 34),
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
          color: _selectedIndex == 1
              ? const Color(0xFFFFD700)
              : const Color.fromARGB(255, 184, 34, 34),
        ),
        label: "Matches",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite_border,
          color: _selectedIndex == 2
              ? const Color(0xFFFFD700)
              : const Color.fromARGB(255, 184, 34, 34),
        ),
        label: "Interests",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: _selectedIndex == 3
              ? const Color(0xFFFFD700)
              : const Color.fromARGB(255, 184, 34, 34),
        ),
        label: "Profile",
      ),
    ],
  ),
),
    );
  }
}