import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register.dart';
import 'navigationBar.dart'; // Asegúrate de importar tu archivo NavigationBarPage.dart

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white)),
        backgroundColor:
            Colors.blue, // Cambia el color de la barra de aplicación a azul
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Iniciar sesión con Firebase Auth
                  UserCredential userCredential =
                      await _auth.signInWithEmailAndPassword(
                    email: _usernameController.text,
                    password: _passwordController.text,
                  );

                  // Si el inicio de sesión es exitoso, navegar a la página de navegación
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationBarPage()),
                  );
                } catch (e) {
                  // Si hay un error durante el inicio de sesión, mostrar un mensaje de error
                  print('Error al iniciar sesión: $e');
                  // Puedes mostrar un diálogo o un SnackBar con el mensaje de error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Error al iniciar sesión. Verifica tus credenciales.'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Cambia el color del botón a azul
              ),
              child: Text(
                'Iniciar Sesión',
                style: TextStyle(
                  color: Colors
                      .white, // Cambia el color del texto del botón a blanco
                ),
              ),
            ),
            SizedBox(height: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("¿No tienes una cuenta aún?"),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la pantalla de registro (register.dart)
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, // Cambia el color del botón a azul
                  ),
                  child: Text(
                    'Regístrate',
                    style: TextStyle(
                      color: Colors
                          .white, // Cambia el color del texto del botón a blanco
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
