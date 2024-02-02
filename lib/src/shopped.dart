import 'package:flutter/material.dart';

// ignore: camel_case_types
class shopped extends StatefulWidget{
  const shopped ({super.key});

  @override
  State<shopped> createState() => shoppedPage();
}

// ignore: camel_case_types
class shoppedPage extends State<shopped>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Buscar',
                  filled: true,
                  fillColor: Color.fromRGBO(238, 177, 27, 1),
                  border: OutlineInputBorder(),
                ),
                maxLines: 1,
              ),
            ],
          ),
        )
      ),
      backgroundColor: const Color.fromRGBO(59, 89, 29, 1),
    );
  }
}