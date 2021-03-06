import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_car/playground.dart';
import 'package:quick_car/services/currency_service.dart';
import 'package:quick_car/view/pages/cars_list/results_view.dart';
import 'package:quick_car/view/pages/map/map.dart';
import 'package:quick_car/view/pages/profile/profile.dart';

import 'constants/cars_globals.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final tabs = [ ResultsView(),
    GMap(), Profile()];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyCurrencyService>(
        create: (context) => CarsGlobals.currencyService,
        child: Builder(builder: (context) {
      return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              backgroundColor: Colors.blue,
              title: Text("list view")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              backgroundColor: Colors.blue,
              title: Text("map view")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              backgroundColor: Colors.blue,
              title: Text("profile")
          )],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),

    );
  }
  ));}
}
