import 'package:cloud_firestore/cloud_firestore.dart';
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
              const SizedBox(height: 16,),
              //Traer los datos y lea en la aplicacion de la base de datos de firebase
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('producto').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    return ListTile(
                      title: Text(doc['nombre']),
                      subtitle: Text(doc['nombreProducto']),
                    );
                  }).toList(),
                );
                }
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