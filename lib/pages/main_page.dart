import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/my_drawer.dart';
import 'menu_page.dart';
import 'messages_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;
  final String cardTitle;
  final String cardImagePath;
  final double price;

  const MainPage({
    super.key,
    this.initialIndex = 0,
    this.cardTitle = '',
    this.cardImagePath = '',
    this.price = 0,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final user = FirebaseAuth.instance.currentUser;
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    if (selectedIndex == 1 && widget.cardTitle.isNotEmpty) {
      _pages[1] = MessagesPage(
        cardTitle: widget.cardTitle,
        cardImagePath: widget.cardImagePath,
        price: widget.price,
      );
    }
  }

  static final List<Widget> _pages = <Widget>[
    const MenuPage(),
    MessagesPage(cardTitle: '', cardImagePath: '',price: 0,),
    const ProfilePage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.red,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: IndexedStack(
        index: selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 1.0),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.red),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail, color: Colors.red),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.red),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
