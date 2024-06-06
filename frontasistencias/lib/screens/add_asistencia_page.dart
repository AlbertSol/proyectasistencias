import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/estudiante.dart';
import '../models/materia.dart';

class AddAsistenciaPage extends StatefulWidget {
  final ApiService apiService;
  final List<Estudiante> estudiantes;
  final List<Materia> materias;

  AddAsistenciaPage(
      {required this.apiService,
      required this.estudiantes,
      required this.materias});

  @override
  _AddAsistenciaPageState createState() => _AddAsistenciaPageState();
}

class _AddAsistenciaPageState extends State<AddAsistenciaPage> {
  final _formKey = GlobalKey<FormState>();
  int? selectedEstudianteId;
  int? selectedMateriaId;
  final fechaController = TextEditingController();
  final estadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 0.38),
                Color.fromARGB(252, 72, 12, 239)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Agregar Asistencia',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        DropdownButtonFormField<int>(
                          value: selectedEstudianteId,
                          items:
                              widget.estudiantes.map((Estudiante estudiante) {
                            return DropdownMenuItem<int>(
                              value: estudiante.idEstudiante,
                              child: Text(estudiante.nombre),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedEstudianteId = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Seleccione Estudiante',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Por favor seleccione un estudiante';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<int>(
                          value: selectedMateriaId,
                          items: widget.materias.map((Materia materia) {
                            return DropdownMenuItem<int>(
                              value: materia.idMateria,
                              child: Text(materia.nombre),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedMateriaId = value;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Seleccione Materia',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Por favor seleccione una materia';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: fechaController,
                          decoration: InputDecoration(
                            labelText: 'Fecha (YYYY-MM-DD)',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese la fecha';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: estadoController,
                          decoration: InputDecoration(
                            labelText: 'Estado (Presente/Ausente)',
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el estado';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                widget.apiService
                                    .addAsistencia(
                                  selectedEstudianteId!,
                                  selectedMateriaId!,
                                  DateTime.parse(fechaController.text),
                                  estadoController.text,
                                )
                                    .then((_) {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Text('Agregar'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
