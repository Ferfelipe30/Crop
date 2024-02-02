import 'package:crop/src/cambioPassword.dart';
import 'package:crop/src/nav.dart';
import 'package:crop/src/openUser.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class open extends StatefulWidget{
  const open({super.key});

  @override
  State<open> createState() => openPage();
}

// ignore: camel_case_types
class openPage extends State<open> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Form(
        key:  formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Imagen de entrada
                Image.asset(
                  'imagen/logoApp.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20,),
                //ingreso de correo
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
                      return 'Ingrese el email';
                    }
                    return null;
                  },
                ),
                const SizedBox( height: 20,),
                //ingreso de password
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
                          passwordVisible = !passwordVisible;
                        });
                      }, 
                      icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ingrese la contraseña';
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
                //Se le olvido el password
                TextButton(
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const cambioPassword(),)
                    );
                  }, 
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                      color: Color.fromRGBO(50, 35, 12, 1),
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                // Boton de iniciar seccion.
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(238, 177, 27, 1),
                    foregroundColor: const Color.fromRGBO(50, 35, 12, 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  onPressed: (){
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      // ignore: avoid_print
                      print('Email: $email, Contraseña: $password');
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => const nav(),
                        )
                      );
                    }
                  }, 
                  child: const Text('Login'),
                ),
                const SizedBox(height: 16,),
                //Nuevo Usuario
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Does not have account?',
                      style: TextStyle(fontSize: 20),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context) => const openUser(),)
                        );
                      }, 
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(50, 35, 12, 1),
                        ),
                      ),
                    ),
                  ],
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