import 'package:crop/src/home.dart';
import 'package:crop/src/newProduct.dart';
import 'package:crop/src/shop.dart';
import 'package:crop/src/user.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class nav extends StatefulWidget{
  const nav({super.key});

  @override
  State<nav> createState() => navPage();
}

// ignore: camel_case_types
class navPage extends State<nav>{
  int currentIndex = 0;

  final List<Widget> children = [
    const home(),
    const shop(),
    const newProduct(),
    const user(),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTabTapped,
        backgroundColor: const Color.fromRGBO(238,177,27,1),
        selectedItemColor: const Color.fromRGBO(50, 35, 12, 1),
        items: const <BottomNavigationBarItem>[
          //Boton Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          //Boton shop
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Shop',
          ),
          //Boton new Product
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'NewProduct',
          ),
          //Boton User
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index){
    setState(() {
      currentIndex = index;
    });
  }
}