import 'package:flutter/material.dart';
import 'package:ui/screen/home.dart';
import 'package:ui/screen/profile.dart';
import '../screen/search.dart';
import '../screen/ticket.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static const List<Widget> pages = <Widget>[Home(),Search(),Ticket(),Profile()];

  void selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        body: Center(
            child:pages[_selectedIndex]
        ),
          bottomNavigationBar:  BottomNavigationBar(
              showSelectedLabels: false,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              selectedItemColor: const Color(0xff212E52),
              unselectedItemColor: Colors.grey,
              onTap: selectedPage,
              currentIndex: _selectedIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
                BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket), label: "Ticket"),
                BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
              ]
          )
      )
    );
  }
}
