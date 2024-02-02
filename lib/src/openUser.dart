// ignore_for_file: file_names, use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crop/src/nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class openUser extends StatefulWidget{
  const openUser({super.key});

  @override
  State<openUser> createState() => openUserPage();
}

// ignore: camel_case_types
class openUserPage extends State<openUser>{
  final formKey = GlobalKey<FormState>();
  File? image;
  final nombre = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confiPassword = TextEditingController();
  final numCelular = TextInputType.phone;
  final direccion = TextEditingController();
  final fechaNacimiento = TextEditingController();
  bool passwordVisible = false;
  final firebase = FirebaseFirestore.instance;

  Future<void> _getImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  Future<void> seleccionarFecha(BuildContext context) async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), 
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromRGBO(238, 177, 27, 1),
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
      fechaNacimiento.text = DateFormat('dd/MM/yyyy').format(fechaSeleccionada);
    }
  }

  registroUsuario() async {
    try {
      await firebase.collection('usuario').doc().set({
        'nombre': nombre.text,
        'password': password.text,
        'confirmarPassword': confiPassword.text,
        'celular': numCelular.hashCode,
        'direccion': direccion.text,
        'email': email.text,
        'fechaNecimiento': fechaNacimiento.text,
      });
    } catch (e) {
      // ignore: avoid_print
      print('Error ... $e');
    }
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Foto de perfil
                image == null 
                ? const Icon(
                  Icons.image, 
                  color: Color.fromRGBO(50, 35, 12, 1))
                : CircleAvatar(
                    radius: 80, 
                    backgroundColor: const Color.fromRGBO(238, 177, 27, 1),
                    backgroundImage: FileImage(image!),
                  ),
                const SizedBox(height: 20,),
                //Botones de camara y galeria.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[ 
                    ElevatedButton(
                      onPressed: (){
                        _getImage(ImageSource.gallery);
                      }, 
                      child: const Icon(Icons.add_photo_alternate),
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      onPressed: (){
                        _getImage(ImageSource.camera);
                      }, 
                      child: const Icon(Icons.add_a_photo_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                //Nombre de perfil
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
                      return 'Ingrese su nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                //Correo de usuario
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
                      return 'Ingrese su email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                //Password de Usuario
                TextFormField(
                  maxLines: 1,
                  controller: password,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    filled: true,
                    fillColor: const Color.fromRGBO(238, 177, 27, 1),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          passwordVisible =! passwordVisible;
                        });
                      }, 
                      icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese su password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    }
                    if (!value.contains(RegExp(r'[a-z]'))) {
                      return 'Password must contain at least one lowercase letter';
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return 'Password must contain at least one number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                //Confirmar password de usuario
                TextFormField(
                  maxLines: 1,
                  controller: confiPassword,
                  obscureText: !passwordVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Confirma password',
                    fillColor: const Color.fromRGBO(238, 177, 27, 1),
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          passwordVisible =! passwordVisible;
                        });
                      }, 
                      icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese el password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    }
                    if (!value.contains(RegExp(r'[a-z]'))) {
                      return 'Password must contain at least one lowercase letter';
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return 'Password must contain at least one number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                //Fecha de nacimineto de usuario
                TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => seleccionarFecha(context), 
                      icon: const Icon(Icons.calendar_today),
                    ),
                    filled: true,
                    fillColor: const Color.fromRGBO(238, 177, 27, 1),
                    labelText: 'Fecha de Nacimiento',
                    border: const OutlineInputBorder(),
                  ),
                  readOnly: true,
                  controller: fechaNacimiento,
                  maxLines: 1,
                  onTap: () => seleccionarFecha(context),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Seleccione la fecha de nacimiento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                //Numero de celular del Usuario
                TextFormField(
                  maxLines: 1,
                  keyboardType: numCelular,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Numero de Celular',
                    filled: true,
                    fillColor: Color.fromRGBO(238, 177, 27, 1),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese el numero de celular';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
                //Direccion de vivienda del Usuario
                TextFormField(
                  maxLines: 1,
                  controller: direccion,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Direccion',
                    filled: true,
                    fillColor: Color.fromRGBO(238, 177, 27, 1),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese la direccion';
                    }
                    return null;
                  }, 
                ),
                const SizedBox(height: 20,),
                //Boton de registro
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(238, 177, 27, 1),
                    foregroundColor: const Color.fromRGBO(50, 35, 12, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: (){
                    registroUsuario();
                    // ignore: avoid_print
                    print('... Enviado');
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      Navigator.push(context, MaterialPageRoute(builder: (context) => const nav()));
                    }
                  }, 
                  child: const Text('Login'),
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