import 'package:flutter/material.dart';
import 'package:gazzer/features/nav_bar/main_bnb.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome to Home Screen', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      bottomNavigationBar: MainBnb(
        onItemSelected: (index) {
          // Handle item selection
          print('Selected index: $index');
          setState(() {});
        },
      ),
    );
  }
}
