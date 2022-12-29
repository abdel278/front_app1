import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:my_souq/app/screens/account_screen.dart';
import 'package:my_souq/app/screens/cart_screen.dart';
import 'package:my_souq/app/screens/home_screen.dart';
import 'package:my_souq/components/declarations.dart';
import 'package:my_souq/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class BottomBar extends StatefulWidget {
  static const String routeName = '/bar-home';

  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page =0;
  double nbWidth = 42;

  List<Widget> pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Declarations.selectedNavBarColor,
        unselectedItemColor: Declarations.unselectedNavBarColor,
        backgroundColor: Declarations.backgroundColor,
        iconSize: 28,
        items: [
          getNavBottom(
              icon: Icons.home_outlined,
              title: AppLocalizations.of(context)!.home,
              index: 0,
              ifCart: false
          ),
          getNavBottom(
            icon: Icons.person_outline_outlined,
            title: AppLocalizations.of(context)!.account,
            index: 1,
            ifCart: false
          ),
          getNavBottom(
              icon: Icons.shopping_cart,
              title: AppLocalizations.of(context)!.cart,
              index: 2,
              ifCart: true,
              cartCount: cartCount
          ),
        ],
        onTap: updatePage,
      ),
    );
  }

  BottomNavigationBarItem getNavBottom({
    required IconData icon , required String title, required int index,
    required bool ifCart, int cartCount = 0}) {

    return BottomNavigationBarItem(icon: Container(
      width: nbWidth,
      decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: _page == index
                    ? Declarations.selectedNavBarColor
                    : Declarations.backgroundColor,
                width: 5
            ),

          )
      ),
      child: ifCart
          ? Badge(elevation: 0,badgeContent: Text(cartCount.toString()), badgeColor: Colors.red, child:Icon(icon),)
          : Icon(icon)
    ),
        label: title
    );
  }
}
