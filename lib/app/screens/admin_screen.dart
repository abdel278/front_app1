import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/admin_orders_screen.dart';
import 'package:my_souq/app/screens/analytics_screen.dart';
import 'package:my_souq/app/screens/post_screen.dart';
import 'package:my_souq/components/declarations.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  static const String routeName = "/admin";

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double nbWidth = 42;

  List<Widget> pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const AdminOrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:
              const BoxDecoration(gradient: Declarations.appBarGradient),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Admin Penal',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Declarations.selectedNavBarColor,
        unselectedItemColor: Declarations.unselectedNavBarColor,
        backgroundColor: Declarations.backgroundColor,
        iconSize: 28,
        items: [
          getNavBottom(
            icon: Icons.post_add_outlined,
            title: 'Posts',
            index: 0,
          ),
          getNavBottom(
            icon: Icons.analytics_outlined,
            title: 'Analytics',
            index: 1,
          ),
          getNavBottom(
            icon: Icons.all_inbox_outlined,
            title: 'Orders',
            index: 2,
          ),
        ],
        onTap: updatePage,
      ),
    );
  }

  BottomNavigationBarItem getNavBottom(
      {required IconData icon, required String title, required int index}) {
    return BottomNavigationBarItem(
        icon: Container(
            width: nbWidth,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(
                  color: _page == index
                      ? Declarations.selectedNavBarColor
                      : Declarations.backgroundColor,
                  width: 5),
            )),
            child: Icon(icon)),
        label: title);
  }
}
