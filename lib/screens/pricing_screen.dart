import 'package:flutter/material.dart';

class PricingScreen extends StatelessWidget {
  const PricingScreen({super.key});

  Widget _featureRow(String feature, bool free, bool gold, bool diamond) {
    Widget icon(bool value) => Icon(
          value ? Icons.check_circle : Icons.cancel,
          color: value ? Colors.green : Colors.red,
          size: 18,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(feature)),
          Expanded(child: Center(child: icon(free))),
          Expanded(child: Center(child: icon(gold))),
          Expanded(child: Center(child: icon(diamond))),
        ],
      ),
    );
  }

  Widget _planCard({
    required String title,
    required String price,
    required List<Color> colors,
  }) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            price,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Upgrade 🚀",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      /// 🔥 AppBar with White Title & Back Icon
      appBar: AppBar(
        backgroundColor: const Color(0xFF9B1C31),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Choose Your Plan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Choose Your Perfect Plan",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            /// 🔥 Horizontal Scroll Cards
            SizedBox(
              height: 320,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [

                  _planCard(
                    title: "Free",
                    price: "₹1",
                    colors: const [
                      Color(0xFFBDBDBD),
                      Color(0xFF9E9E9E),
                    ],
                  ),

                  _planCard(
                    title: "Gold",
                    price: "₹29,900",
                    colors: const [
                      Color(0xFFFFD700),
                      Color(0xFFFFA500),
                    ],
                  ),

                  _planCard(
                    title: "Diamond",
                    price: "₹45,599",
                    colors: const [
                      Color(0xFF9C27B0),
                      Color(0xFF6A1B9A),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "Feature Comparison",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _featureRow("Profile Views (per month)", true, true, true),
            _featureRow("View Contact Info", false, true, true),
            _featureRow("Send Interests", false, true, true),
            _featureRow("Chat Access", false, true, true),
            _featureRow("Interests per Day", false, true, true),
            _featureRow("Priority Listing", false, false, true),
            _featureRow("Verified Badge", false, false, true),

            const SizedBox(height: 40),

            const Text(
              "Need Help?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Contact support anytime for plan details.",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}