import 'package:crop/src/shopped.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class shop extends StatefulWidget{
  const shop({super.key});

  @override
  State<shop> createState() => shopPage();
}

// ignore: camel_case_types
class shopPage extends State<shop>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefix: Icon(Icons.search),
                        labelText: 'Buscar',
                        filled: true,
                        fillColor: Color.fromRGBO(238, 177, 27, 1),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),)),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(238, 177, 27, 1),
          ),
        ),
        child: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const shopped()));
          },
          child: const Icon(Icons.shopping_cart),
        ),
      ),
      backgroundColor: const Color.fromRGBO(59, 89, 29, 1),
    );
  }
}