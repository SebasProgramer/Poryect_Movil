// dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_petsapp/MyPets.dart';
import 'package:flutter_application_petsapp/addPet.dart';
import 'package:flutter_application_petsapp/petsApi.dart';
import 'package:flutter_application_petsapp/profile.dart';

class NavigationBarPage extends StatefulWidget {
  @override
  _NavigationBarPage createState() => _NavigationBarPage();
}

class _NavigationBarPage extends State<NavigationBarPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    MyPetsPage(),
    AddPetPage(),
    ProfilePage(),
    PetsApiPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicación de Mascotas',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        unselectedItemColor: const Color.fromARGB(255, 88, 88, 88),
        selectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Mis Mascotas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Agregar Mascota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'API',
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
