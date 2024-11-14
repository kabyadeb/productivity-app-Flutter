import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:productivity/pages/ui/calendar_screen.dart';
import 'package:productivity/pages/ui/timer_screen.dart';
import 'package:productivity/pages/ui/todo_screen.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  List titles = ['Todo', 'Timer', 'Calendar'];
  List<Icon> items = const [
    Icon(Icons.post_add, size: 30),
    Icon(Icons.timer, size: 30),
    Icon(Icons.calendar_month, size: 30),
  ];
  List<Widget> widgetsList = [
    const TodoScreen(),
    const TimerScreen(),
    CalendarScreen(),
  ];

  void onTapBottom(int v) {
    log(v.toString());
    setState(() {
      _selectedIndex = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_selectedIndex],
          style: const TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: widgetsList[_selectedIndex],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.deepOrange,
        items: items,
        index: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        height: 70,
      ),
    );
  }
}
