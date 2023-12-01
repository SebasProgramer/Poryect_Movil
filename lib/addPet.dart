import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPetPage extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final List<String> _ageOptions = ['0-1', '1-3', '3-5', '5+'];
  final List<String> _colorOptions = ['Negro', 'Blanco', 'Marrón', 'Gris'];
  final List<String> _typeOptions = ['Perro', 'Gato'];

  String _selectedAge = '0-1';
  String _selectedColor = 'Negro';
  String _selectedType = 'Perro';

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Mascota', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre de la mascota'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              value: _selectedType,
              onChanged: (String? value) {
                if (value != null) {
                  _selectedType = value;
                }
              },
              items: _typeOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Tipo de mascota'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              value: _selectedAge,
              onChanged: (String? value) {
                if (value != null) {
                  _selectedAge = value;
                }
              },
              items: _ageOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Edad de la mascota'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              value: _selectedColor,
              onChanged: (String? value) {
                if (value != null) {
                  _selectedColor = value;
                }
              },
              items: _colorOptions.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              decoration: InputDecoration(labelText: 'Color de la mascota'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _savePet(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
              ),
              child: Text(
                'Agregar Mascota',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _savePet(BuildContext context) async {
    User? user = _auth.currentUser;

    if (user != null) {
      String name = _nameController.text.trim();
      String type = _selectedType;
      String age = _selectedAge;
      String color = _selectedColor;

      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor, ingrese un nombre para la mascota'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      DocumentReference userRef = _firestore.collection('users').doc(user.uid);

      await _firestore.collection('pets').add({
        'name': name,
        'type': type,
        'age': age,
        'color': color,
        'user': userRef,
      });

      _nameController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mascota $name agregada exitosamente'),
        ),
      );
    }
  }
}
