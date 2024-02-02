// ignore_for_file: file_names

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop/src/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class newProduct extends StatefulWidget{
  const newProduct({super.key});

  @override
  State<newProduct> createState() => newProductPage();
}

// ignore: camel_case_types
class newProductPage extends State<newProduct>{
  final formKey = GlobalKey<FormState>();
  File? image;
  final fechaLanzamiento = TextEditingController();
  final fechaTermino = TextEditingController();
  final nombreProducto = TextEditingController();
  final cantidadProducto = TextInputType.number;
  final direccion = TextEditingController();
  final descripcionProducto = TextEditingController();
  final nombre = TextEditingController();
  final email = TextEditingController();
  final celular = TextInputType.phone;
  final firebase = FirebaseFirestore.instance;

  @override
  void dispose(){
    super.dispose();
    descripcionProducto.dispose();
  }

  Future<void> _getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> seleccionarFechaLanzamiento(BuildContext context) async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900), 
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(238, 117, 27, 1),
            colorScheme: const ColorScheme.light(
              primary: Color.fromRGBO(238, 177, 27, 1),
            ),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ), 
          child: child!
        ); 
      },
    );
    if (fechaSeleccionada != null && fechaSeleccionada != DateTime.now()) {
      fechaLanzamiento.text = DateFormat('dd/MM/yyyy').format(fechaSeleccionada);
    }
  }

  Future<void> seleccionarFechaTermino(BuildContext context) async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900), 
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(238, 117, 27, 1),
            colorScheme: const ColorScheme.light(
              primary: Color.fromRGBO(238, 177, 27, 1),
            ),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ), 
          child: child!
        ); 
      },
    );
    if (fechaSeleccionada != null && fechaSeleccionada != DateTime.now()) {
      fechaTermino.text = DateFormat('dd/MM/yyyy').format(fechaSeleccionada);
    }
  }

  registroProducto() async {
    try {
      await firebase.collection('producto').doc().set({
        'nombreProducto': nombreProducto.text,
        'cantidadProducto': cantidadProducto.hashCode,
        'fechaLanzamiento': fechaLanzamiento.text,
        'fechaTermino': fechaTermino.text,
        'direccion': direccion.text,
        'descripcionProducto': descripcionProducto.text,
        'nombre': nombre.text,
        'email': email.text,
        'celular': celular.hashCode,
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error ...$e');
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  image == null
                  ? const Icon(
                    Icons.image,
                    color: Color.fromRGBO(50, 35, 12, 1),
                  )
                  :CircleAvatar(
                    radius: 80,
                    backgroundColor: const Color.fromRGBO(238, 177, 27, 1),
                    backgroundImage: FileImage(image!),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: (){
                          _getImage(ImageSource.camera);
                        }, 
                        child: const Icon(Icons.add_a_photo_outlined),
                      ),
                      const SizedBox(width: 10,),
                      ElevatedButton(
                        onPressed: (){
                          _getImage(ImageSource.gallery);
                        }, 
                        child: const Icon(Icons.add_photo_alternate),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  //Nombre del producto
                  TextFormField(
                    maxLines: 1,
                    controller: nombreProducto,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre de Producto',
                      filled: true,
                      fillColor: Color.fromRGBO(238, 177, 27, 1),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese el nombre del producto';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  //Cantidad de productos
                  TextFormField(
                    maxLines: 1,
                    keyboardType: cantidadProducto,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Cantidad del producto',
                      fillColor: Color.fromRGBO(238, 177, 27, 1),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese la cantidad de producto a la venta';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  // Fecha de Lanzamiento
                  TextFormField(
                    maxLines: 1,
                    controller: fechaLanzamiento,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => seleccionarFechaLanzamiento(context), 
                        icon: const Icon(Icons.calendar_today),
                      ),
                      fillColor: const Color.fromRGBO(238, 177, 27, 1),
                      filled: true,
                      labelText: 'Fecha de Lanzamiento',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese la fecha de lanzamiento del nuevo producto.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  //Fecha de Termino
                  TextFormField(
                    maxLines: 1,
                    controller: fechaTermino,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () => seleccionarFechaTermino(context), 
                        icon: const Icon(Icons.calendar_today),
                      ), 
                      fillColor: const Color.fromRGBO(238, 177, 27, 1),
                      filled: true,
                      labelText: 'Fecha de Termino',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese la fecha de termino de nuevo producto.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  //direccion
                  TextFormField(
                    maxLines: 1,
                    controller: direccion,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Direccion',
                      fillColor: Color.fromRGBO(238, 177, 27, 1),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese la direccion';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  //Descripcion del Producto
                  TextFormField(
                    maxLines: 10,
                    controller: descripcionProducto,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Descripcion',
                      fillColor: Color.fromRGBO(238, 177, 27, 1),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese la descripcion del producto';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  //Nombre del vendedor
                  TextFormField(
                    maxLines: 1,
                    controller: nombre,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre',
                      fillColor: Color.fromRGBO(238, 177, 27, 1),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese el nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  //Correo
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
                  const SizedBox(height: 16,),
                  //Numero de celular
                  TextFormField(
                    maxLines: 1,
                    keyboardType: celular,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Numero de Celular',
                      fillColor: Color.fromRGBO(238, 177, 27, 1),
                      filled: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese el nuemro de celular';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16,),
                  //Boton de publicar
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(50, 35, 12, 1),
                      backgroundColor: const Color.fromRGBO(238, 177, 27, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    onPressed: (){
                      registroProducto();
                      // ignore: avoid_print
                      print('... Enviado');
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Producto nuevo registrado'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const nav()),
                        );
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error de registro de producto nuevo'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }, 
                    child: const Text('Publicar'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(59, 89, 29, 1),
    );
  }
}