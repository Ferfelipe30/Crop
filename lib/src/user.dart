import 'package:flutter/material.dart';

// ignore: camel_case_types
class user extends StatefulWidget{
  const user({super.key});

  @override
  State<user> createState() => userPage();
}

// ignore: camel_case_types
class userPage extends State<user>{
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      backgroundColor: Color.fromRGBO(59, 89, 29, 1),
    );
  }
}