import 'package:flutter/material.dart';
import 'package:matrimony_app/views/nav_screen/home_screen.dart';
import 'package:matrimony_app/views/nav_screen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  List<Widget> pages = [
    HomeScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pink.shade100,
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
          ]
      ),
    );
  }
}
