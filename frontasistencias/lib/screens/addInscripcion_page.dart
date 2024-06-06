import 'package:flutter/material.dart';
import '../models/estudiante.dart';
import '../models/materia.dart';
import '../models/grupo.dart';
import '../services/api_service.dart';

class AddInscripcionPage extends StatefulWidget {
  final ApiService apiService;
  final List<Estudiante> estudiantes;
  final List<Materia> materias;
  final List<Grupo> grupos;

  AddInscripcionPage({
    required this.apiService,
    required this.estudiantes,
    required this.materias,
    required this.grupos,
  });

  @override
  _AddInscripcionPageState createState() => _AddInscripcionPageState();
}

class _AddInscripcionPageState extends State<AddInscripcionPage> {
  final _formKey = GlobalKey<FormState>();

  Estudiante? _selectedEstudiante;
  Materia? _selectedMateria;
  Grupo? _selectedGrupo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Inscripción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DropdownButtonFormField<Estudiante>(
                value: _selectedEstudiante,
                hint: Text('Seleccionar Estudiante'),
                onChanged: (Estudiante? newValue) {
                  setState(() {
                    _selectedEstudiante = newValue;
                  });
                },
                items: widget.estudiantes
                    .map<DropdownMenuItem<Estudiante>>((Estudiante estudiante) {
                  return DropdownMenuItem<Estudiante>(
                    value: estudiante,
                    child: Text(estudiante.nombre),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Seleccione un estudiante' : null,
              ),
              DropdownButtonFormField<Materia>(
                value: _selectedMateria,
                hint: Text('Seleccionar Materia'),
                onChanged: (Materia? newValue) {
                  setState(() {
                    _selectedMateria = newValue;
                  });
                },
                items: widget.materias
                    .map<DropdownMenuItem<Materia>>((Materia materia) {
                  return DropdownMenuItem<Materia>(
                    value: materia,
                    child: Text(materia.nombre),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Seleccione una materia' : null,
              ),
              DropdownButtonFormField<Grupo>(
                value: _selectedGrupo,
                hint: Text('Seleccionar Grupo'),
                onChanged: (Grupo? newValue) {
                  setState(() {
                    _selectedGrupo = newValue;
                  });
                },
                items:
                    widget.grupos.map<DropdownMenuItem<Grupo>>((Grupo grupo) {
                  return DropdownMenuItem<Grupo>(
                    value: grupo,
                    child: Text(grupo.nombre),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Seleccione un grupo' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.apiService
                        .addInscripcion(
                      _selectedEstudiante!.idEstudiante,
                      _selectedMateria!.idMateria,
                      _selectedGrupo!.idGrupo,
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
