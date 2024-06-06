import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/asistencia.dart';
import '../models/estudiante.dart';
import '../models/materia.dart';
import 'add_asistencia_page.dart';

class AsistenciasScreen extends StatefulWidget {
  @override
  _AsistenciasScreenState createState() => _AsistenciasScreenState();
}

class _AsistenciasScreenState extends State<AsistenciasScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Asistencia>> futureAsistencias;
  late Future<List<Estudiante>> futureEstudiantes;
  late Future<List<Materia>> futureMaterias;

  List<Estudiante> estudiantes = [];
  List<Materia> materias = [];

  @override
  void initState() {
    super.initState();
    futureAsistencias = apiService.fetchAsistencias();
    futureEstudiantes = apiService.fetchEstudiantes();
    futureMaterias = apiService.fetchMaterias();

    fetchData();
  }

  Future<void> fetchData() async {
    estudiantes = await apiService.fetchEstudiantes();
    materias = await apiService.fetchMaterias();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asistencias'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Asistencia>>(
          future: futureAsistencias,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No hay asistencias'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Asistencia asistencia = snapshot.data![index];
                  String estudianteNombre = estudiantes
                      .firstWhere(
                        (e) => e.idEstudiante == asistencia.estudianteId,
                        orElse: () => Estudiante(
                            idEstudiante: 0,
                            nombre: 'Desconocido',
                            correo: '',
                            numeroRegistro: ''),
                      )
                      .nombre;

                  String materiaNombre = materias
                      .firstWhere(
                        (m) => m.idMateria == asistencia.materiaId,
                        orElse: () => Materia(
                            idMateria: 0, nombre: 'Desconocido', docenteId: 0),
                      )
                      .nombre;

                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estudiante: $estudianteNombre.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Materia: $materiaNombre.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Estado: ${asistencia.Estado}.',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (estudiantes.isNotEmpty && materias.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAsistenciaPage(
                  apiService: apiService,
                  estudiantes: estudiantes,
                  materias: materias,
                ),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Datos de estudiantes o materias no disponibles'),
              ),
            );
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
