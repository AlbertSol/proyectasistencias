import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/docente.dart';

class DocentesScreen extends StatefulWidget {
  @override
  _DocentesScreenState createState() => _DocentesScreenState();
}

class _DocentesScreenState extends State<DocentesScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Docente>> futureDocentes;

  @override
  void initState() {
    super.initState();
    futureDocentes = apiService.fetchDocentes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Docentes'),
      ),
      body: FutureBuilder<List<Docente>>(
        future: futureDocentes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay docentes'));
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
                builder: (context) => AddDocentePage(apiService: apiService)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddDocentePage extends StatefulWidget {
  final ApiService apiService;
  AddDocentePage({required this.apiService});

  @override
  _AddDocentePageState createState() => _AddDocentePageState();
}

class _AddDocentePageState extends State<AddDocentePage> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final correoController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Docente'),
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
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Contraseña'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la contraseña';
                  }
                  return null;
                },
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.apiService
                        .addDocente(
                      nombreController.text,
                      correoController.text,
                      passwordController.text,
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
