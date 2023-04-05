import 'package:doorstep_web_admin/views/screens/side_bar_screens/bookings_screen.dart';
import 'package:doorstep_web_admin/views/screens/side_bar_screens/categories_screen.dart';
import 'package:doorstep_web_admin/views/screens/side_bar_screens/dashboard_screen.dart';
import 'package:doorstep_web_admin/views/screens/side_bar_screens/service_providers.dart';
import 'package:doorstep_web_admin/views/screens/side_bar_screens/service_providers_profile.dart';
import 'package:doorstep_web_admin/views/screens/side_bar_screens/upload_banners.dart';
import 'package:doorstep_web_admin/views/screens/side_bar_screens/users_screen.dart';
import 'package:doorstep_web_admin/views/screens/side_bar_screens/withdrawal_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedItem = DashboardScreen();

  screenSelector(item) {
    switch (item.route) {
      case DashboardScreen.routeName:
        setState(() {
          _selectedItem = DashboardScreen();
        });

        break;
      case ServiceProviderScreen.routeName:
        setState(() {
          _selectedItem = ServiceProviderScreen();
        });

        break;
      case WithdrawalScreen.routeName:
        setState(() {
          _selectedItem = WithdrawalScreen();
        });

        break;
      case BookingScreen.routeName:
        setState(() {
          _selectedItem = BookingScreen();
        });

        break;
      case CategoriesScreen.routeName:
        setState(() {
          _selectedItem = CategoriesScreen();
        });

        break;
      case ServiceProviderProfileScreen.routeName:
        setState(() {
          _selectedItem = ServiceProviderProfileScreen();
        });

        break;

      case UserScreen.routeName:
        setState(() {
          _selectedItem = UserScreen();
        });

        break;

      case UploadBannerScreen.routeName:
        setState(() {
          _selectedItem = UploadBannerScreen();
        });

        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: Colors.white70,
        sideBar: SideBar(
          items: [
            AdminMenuItem(
              title: 'Dashboard',
              icon: Icons.dashboard,
              route: DashboardScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Service Providers',
              icon: CupertinoIcons.person_3,
              route: ServiceProviderScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Withdrawal',
              icon: CupertinoIcons.money_dollar,
              route: WithdrawalScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Bookings',
              icon: CupertinoIcons.shopping_cart,
              route: BookingScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Categories',
              icon: Icons.category,
              route: CategoriesScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Service Provider\'s Profile and Gallery',
              icon: Icons.shop,
              route: ServiceProviderProfileScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Customers',
              icon: CupertinoIcons.person_2,
              route: UserScreen.routeName,
            ),
            AdminMenuItem(
              title: 'Upload Banners',
              icon: CupertinoIcons.add,
              route: UploadBannerScreen.routeName,
            ),
          ],
          selectedRoute: '',
          onSelected: (item) {
            screenSelector(item);
          },
          header: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: const Center(
              child: Text(
                'Door Step service - Web Admin',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          footer: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: const Center(
              child: Text(
                'Portia Mashaba',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: _selectedItem);
  }
}
