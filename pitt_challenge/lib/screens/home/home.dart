import 'package:flutter/material.dart';
import 'package:pitt_challenge/services/authFB.dart';
import 'package:pitt_challenge/screens/home/patients.dart';
import 'package:pitt_challenge/screens/home/chat.dart';
import 'package:pitt_challenge/screens/home/dashboard.dart';
import 'package:pitt_challenge/screens/wrapper.dart';


final AuthService _auth = AuthService();
class Home extends StatefulWidget {

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.home_filled),
                selectedIcon: Icon(Icons.home),
                label: Text('Calendar'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('Patients'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.chat_bubble_outline),
                selectedIcon: Icon(Icons.chat_bubble),
                label: Text('Chatbot'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout_outlined),
                selectedIcon: Icon(Icons.chat_bubble),
                label: Text('Logout'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(
              child: buildPages(_selectedIndex),
            ),
          )

        ],
      ),
    );
  }

Widget buildPages(int index) {
  switch (index) {
    case 0:
      return Dashboard();
    case 1:
      return Patients();
    case 2:
      return Chat();
    case 3:
      _auth.signOut();
      return Wrapper();
    default:
      return Patients();
  }
}

