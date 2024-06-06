import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/estudiante.dart';

class EstudiantesScreen extends StatefulWidget {
  @override
  _EstudiantesScreenState createState() => _EstudiantesScreenState();
}

class _EstudiantesScreenState extends State<EstudiantesScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Estudiante>> futureEstudiantes;

  @override
  void initState() {
    super.initState();
    futureEstudiantes = apiService.fetchEstudiantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estudiantes'),
      ),
      body: FutureBuilder<List<Estudiante>>(
        future: futureEstudiantes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay estudiantes'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].nombre),
                  subtitle: Text(snapshot.data![index].correo),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    AddEstudiantePage(apiService: apiService)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddEstudiantePage extends StatefulWidget {
  final ApiService apiService;
  AddEstudiantePage({required this.apiService});

  @override
  _AddEstudiantePageState createState() => _AddEstudiantePageState();
}

class _AddEstudiantePageState extends State<AddEstudiantePage> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final numeroRegistroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Estudiante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: correoController,
                decoration: InputDecoration(labelText: 'Correo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el correo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: numeroRegistroController,
                decoration: InputDecoration(labelText: 'Número de Registro'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el número de registro';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.apiService
                        .addEstudiante(
                      nombreController.text,
                      correoController.text,
                      numeroRegistroController.text,
                    )
                        .then((_) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text('Agregar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
