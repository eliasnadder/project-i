import 'package:flutter/material.dart';
import 'package:example1/Views/client/messages_page.dart';
import 'package:example1/Views/client/profile_page.dart';
import 'package:example1/Views/client/trips_page.dart';
import 'package:example1/Views/client/wishlist_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Dashboard/home_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    WishlistPage(),
    TripsPage(),
    MessagesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 22),
            label: localizations.explore,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart, size: 22),
            label: localizations.wishlists,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.suitcaseRolling, size: 22),
            label: localizations.trips,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.message, size: 22),
            label: localizations.messages,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidUser, size: 22),
            label: localizations.profile,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        useLegacyColorScheme: false,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
        elevation: 5.0,
      ),
    );
  }
}
