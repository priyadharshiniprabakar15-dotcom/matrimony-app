import 'package:flutter/material.dart';

class AdminEmployeesScreen extends StatefulWidget {
  const AdminEmployeesScreen({super.key});

  @override
  State<AdminEmployeesScreen> createState() =>
      _AdminEmployeesScreenState();
}

class _AdminEmployeesScreenState
    extends State<AdminEmployeesScreen> {

  Widget statCard(String title, String value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey)),
            const SizedBox(height: 8),
            Text(value,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget employeeRow(
      String name,
      String email,
      String role,
      String clients) {

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(email,
                      style: const TextStyle(
                          color: Colors.grey)),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: const Text(
                  "Active",
                  style: TextStyle(
                      color: Colors.green),
                ),
              )
            ],
          ),

          const SizedBox(height: 12),

          Text("Role: $role"),
          Text("Clients: $clients"),

          const SizedBox(height: 14),

          Row(
            children: [

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Allocate Clients",
                    style: TextStyle(
                        color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.blue,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                        color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(
                              12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Employee Management",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme:
            const IconThemeData(
                color: Colors.white),
      ),

      backgroundColor:
          const Color(0xFFF5F6FA),

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            Colors.deepPurple,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [

            Row(
              children: [
                statCard(
                    "TOTAL EMPLOYEES", "2"),
                statCard(
                    "ACTIVE EMPLOYEES", "2"),
                statCard(
                    "TOTAL ASSIGNMENTS", "12"),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [

                  employeeRow(
                      "Selva",
                      "badpradii@gmail.com",
                      "Employee",
                      "3/3"),

                  employeeRow(
                      "Badone",
                      "pradeepnatarajan400@gmail.com",
                      "Employee",
                      "9/9"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}