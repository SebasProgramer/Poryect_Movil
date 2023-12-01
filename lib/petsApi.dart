import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_petsapp/petDetails.dart';
import 'package:http/http.dart' as http;

class PetsApiPage extends StatefulWidget {
  @override
  _PetsApiPageState createState() => _PetsApiPageState();
}

class _PetsApiPageState extends State<PetsApiPage> {
  final String apiKey = 'OFUmz5bc1yZ3GC8R76JdwLKupiv2MLK4Zqm6NCwektrvbiQMKX';
  final String apiSecret = 'FcNI6yKT99tHdo2b2gGqurIfK14QIEdNEtRitXcS';
  String accessToken = '';

  @override
  void initState() {
    super.initState();
    _getAccessToken();
  }

  Future<void> _getAccessToken() async {
    final response = await http.post(
      Uri.parse('https://api.petfinder.com/v2/oauth2/token'),
      body: {
        'grant_type': 'client_credentials',
        'client_id': apiKey,
        'client_secret': apiSecret,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      accessToken = data['access_token'];
      _getPetsList();
    } else {
      print('Error de autenticación');
    }
  }

  Future<void> _getPetsList() async {
    final response = await http.get(
      Uri.parse('https://api.petfinder.com/v2/animals?type=dog&page=1'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> animals = data['animals'];

      List<Map<String, dynamic>> petsData = [];

      for (var animal in animals) {
        List<String> photoUrls = [];
        if (animal['photos'] != null) {
          for (var photo in animal['photos']) {
            photoUrls.add(photo['small']);
          }
        }

        petsData.add({
          'name': animal['name'],
          'breed': animal['breeds']['primary'],
          'photos': photoUrls,
        });
      }

      setState(() {
        _petsData = petsData;
      });
    } else {
      print('Error al obtener la lista de mascotas');
    }
  }

  List<Map<String, dynamic>> _petsData = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue, // Establece el color base a azul
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Mascotas'),
        ),
        body: _buildPetsList(),
      ),
    );
  }

  Widget _buildPetsList() {
    return ListView.builder(
      itemCount: _petsData.length,
      itemBuilder: (context, index) {
        return _buildPetCard(_petsData[index]);
      },
    );
  }

  Widget _buildPetCard(Map<String, dynamic> petData) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PetDetailsPage(petData: petData),
            ),
          );
        },
        child: Column(
          children: [
            if (petData['photos'] != null && petData['photos'].isNotEmpty)
              Image.network(
                petData['photos'][0],
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ListTile(
              title: Text(petData['name']),
              subtitle: Text(petData['breed']),
            ),
          ],
        ),
      ),
    );
  }
}
