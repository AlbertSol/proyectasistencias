import 'package:flutter/material.dart';
import '../models/docente.dart';
import '../services/api_service.dart';

class AddMateriaPage extends StatefulWidget {
  final ApiService apiService;
  final List<Docente> docentes;

  AddMateriaPage({
    required this.apiService,
    required this.docentes,
  });

  @override
  _AddMateriaPageState createState() => _AddMateriaPageState();
}

class _AddMateriaPageState extends State<AddMateriaPage> {
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  Docente? _selectedDocente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Materia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre de la Materia'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre de la materia';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<Docente>(
                value: _selectedDocente,
                hint: Text('Seleccionar Docente'),
                onChanged: (Docente? newValue) {
                  setState(() {
                    _selectedDocente = newValue;
                  });
                },
                items: widget.docentes
                    .map<DropdownMenuItem<Docente>>((Docente docente) {
                  return DropdownMenuItem<Docente>(
                    value: docente,
                    child: Text(docente.nombre),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Seleccione un docente' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.apiService
                        .addMateria(
                      nombreController.text,
                      _selectedDocente!.idDocente,
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
