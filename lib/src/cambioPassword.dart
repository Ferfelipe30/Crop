// ignore_for_file: file_names
import 'package:crop/src/open.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class cambioPassword extends StatefulWidget{
  const cambioPassword({super.key});

  @override
  State<cambioPassword> createState() => cambioPasswordPage();
}

// ignore: camel_case_types
class cambioPasswordPage extends State<cambioPassword>{
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Form(
        key:  formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                maxLines: 1,
                controller: email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  filled: true,
                  fillColor: Color.fromRGBO(238, 177, 27, 1),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ingrese el correo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(238, 177, 27, 1),
                  foregroundColor: const Color.fromRGBO(50, 35, 12, 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                ),
                onPressed: (){
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    showDialog(
                      context: context, 
                      builder: (context) => AlertDialog(
                        title: const Text('Alerta!!!'),
                        content: const Text('Se mando al correo la contraseña actual que tiene registrada.'),
                        actions: <Widget>[
                          FloatingActionButton(
                            child: const Text('OK'),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const open()));
                            }
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: const Text('Restablecer'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(59, 89, 29, 1),
    );
  }
}