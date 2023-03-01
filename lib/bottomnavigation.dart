
import 'package:disaster/requirements.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'amount.dart';
import 'camp.dart';
import 'notification.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar ({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar > {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[

    Requirement(),
    Amount(),
    Camp(),
    Noti(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[

            BottomNavigationBarItem(
                icon: Icon(Icons.production_quantity_limits),
                label: 'Needs',
                backgroundColor: Color(0xFF5F9EA0)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.currency_rupee),
                label: 'Donation',
                backgroundColor: Color(0xFF5F9EA0)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Camp',
              backgroundColor:Color(0xFF5F9EA0),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notification',
              backgroundColor:Color(0xFF5F9EA0),
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5
      ),
    );
  }
}
