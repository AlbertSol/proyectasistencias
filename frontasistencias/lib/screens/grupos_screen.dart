import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/grupo.dart';

class GruposScreen extends StatefulWidget {
  @override
  _GruposScreenState createState() => _GruposScreenState();
}

class _GruposScreenState extends State<GruposScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Grupo>> futureGrupos;

  @override
  void initState() {
    super.initState();
    futureGrupos = apiService.fetchGrupos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grupos'),
      ),
      body: FutureBuilder<List<Grupo>>(
        future: futureGrupos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay grupos'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].nombre),
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
                builder: (context) => AddGrupoPage(apiService: apiService)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddGrupoPage extends StatefulWidget {
  final ApiService apiService;
  AddGrupoPage({required this.apiService});

  @override
  _AddGrupoPageState createState() => _AddGrupoPageState();
}

class _AddGrupoPageState extends State<AddGrupoPage> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Grupo'),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.apiService
                        .addGrupo(
                      nombreController.text,
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
