import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String name;
  final String type;
  final String age;
  final String color;

  Pet({
    required this.name,
    required this.type,
    required this.age,
    required this.color,
  });
}

class MyPetsPage extends StatefulWidget {
  @override
  _MyPetsPageState createState() => _MyPetsPageState();
}

class _MyPetsPageState extends State<MyPetsPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String selectedType = 'Todos';
  String selectedAge = 'Todos';
  String selectedColor = 'Todos';

  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    _loadPets();
  }

  Future<void> _loadPets() async {
    User? user = _auth.currentUser;

    if (user != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('pets')
          .where('user',
              isEqualTo: _firestore.collection('users').doc(user.uid))
          .get();

      setState(() {
        pets = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data()!;
          return Pet(
            name: data['name'],
            type: data['type'],
            age: data['age'],
            color: data['color'],
          );
        }).toList();
      });
    }
  }

  List<Pet> getFilteredPets() {
    return pets.where((pet) {
      bool typeCondition = selectedType == 'Todos' || pet.type == selectedType;
      bool ageCondition = selectedAge == 'Todos' || pet.age == selectedAge;
      bool colorCondition =
          selectedColor == 'Todos' || pet.color == selectedColor;

      return typeCondition && ageCondition && colorCondition;
    }).toList();
  }

  Future<void> _deletePet(Pet pet) async {
    User? user = _auth.currentUser;

    if (user != null) {
      await _firestore
          .collection('pets')
          .where('user',
              isEqualTo: _firestore.collection('users').doc(user.uid))
          .where('name', isEqualTo: pet.name)
          .get()
          .then((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.first.reference.delete();
          _loadPets();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Pet> filteredPets = getFilteredPets();

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Mascotas', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DropdownButton<String>(
                value: selectedType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedType = newValue!;
                  });
                },
                items: <String>['Todos', 'Perro', 'Gato']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: selectedAge,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAge = newValue!;
                  });
                },
                items: <String>['Todos', '0-1', '1-3', '3-5', '5+']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: selectedColor,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedColor = newValue!;
                  });
                },
                items: <String>['Todos', 'Marrón', 'Gris', 'Blanco', 'Negro']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPets.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredPets[index].name),
                  subtitle: Text(
                    'Tipo: ${filteredPets[index].type}, Edad: ${filteredPets[index].age}, Color: ${filteredPets[index].color}',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deletePet(filteredPets[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
