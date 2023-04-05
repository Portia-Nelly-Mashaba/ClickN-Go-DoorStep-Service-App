import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../users/nav_screens/home_screen.dart';
import '../users/nav_screens/category_screen.dart';
import '../users/nav_screens/mybookings_screens.dart';
import '../users/nav_screens/bookings_screen.dart';
import '../users/nav_screens/search_screen.dart';
import '../users/nav_screens/account_screen.dart';

import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    MyBookingScreen(),
    BookingScreen(),
    SearchScreen(),
    AccountScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.amberAccent.shade700,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/explore.svg',
              width: 20,
            ),
            label: 'CATEGORIES',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar_badge_plus),
            label: 'BOOKINGS',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.doc_text),
            label: 'MY BOOKINGS',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              width: 20,
            ),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/account.svg',
              width: 20,
            ),
            label: 'ACCOUNTS',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
