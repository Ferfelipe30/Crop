import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop/src/shopped.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class home extends StatefulWidget{
  const home({super.key});

  @override
  State<home> createState() => homePage();
}

// ignore: camel_case_types
class homePage extends State<home>{
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Form(
        key: formkey,
        child: Center(
          child: SingleChildScrollView(    
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('producto').snapshots(), 
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((doc){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //color: const Color.fromRGBO(238, 177, 27, 1),
                          
                              ListTile(
                                leading: const FlutterLogo(size: 60.0,),
                                title: Text(doc['nombreProducto']),
                                subtitle: Text(doc['descripcionProducto']),
                                trailing: IconButton(
                                  style: IconButton.styleFrom(
                                    backgroundColor: const Color.fromRGBO(50, 35, 12, 1),
                                    foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
                                  ),
                                  onPressed: (){}, 
                                  icon: const Icon(Icons.shopify_rounded),
                                ),
                              ),
                            ],                            
                        );
                    }).toList(),
                  );
                }
              ),
            ],
          ),
          ), 
          ),
        ),
      ),
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