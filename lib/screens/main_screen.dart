import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:multi_vendor_shop_app/screens/account_screen.dart';
import 'package:multi_vendor_shop_app/screens/cart_screen.dart';
import 'package:multi_vendor_shop_app/screens/category_screen.dart';
import 'package:multi_vendor_shop_app/screens/message_screen.dart';
import 'home_screen.dart';


class MainScreen extends StatefulWidget {
  final int? index;
  const MainScreen({Key? key,this.index}) : super(key: key);
  static const String id='home-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CategoryScreen(),
    MessageScreen(),
    CartScreen(),
    AccountScreen()

  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if(widget.index != null){
      _selectedIndex = widget.index!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade300
            )
          )
        ),
        child: BottomNavigationBar(
          elevation: 4,
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 0 ? Icons.home : Icons.home_outlined),
              label: 'Home',
              //backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1 ? IconlyBold.category : IconlyLight.category),
              label: 'Categories',
              //backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 2 ? IconlyBold.chat : IconlyLight.chat),
              label: 'Messages',
              //backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 3 ? IconlyBold.buy : IconlyLight.buy),
              label: 'Cart',
              //backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 4 ? CupertinoIcons.person_solid:CupertinoIcons.person),
              label: 'Account',
              //backgroundColor: Colors.pink,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepOrange,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
        ),
      ),
    );
  }
}
