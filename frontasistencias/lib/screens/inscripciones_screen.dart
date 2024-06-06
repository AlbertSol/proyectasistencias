import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/inscripcion.dart';
import '../models/estudiante.dart';
import '../models/materia.dart';
import '../models/grupo.dart';
import 'addInscripcion_page.dart';

class InscripcionesScreen extends StatefulWidget {
  @override
  _InscripcionesScreenState createState() => _InscripcionesScreenState();
}

class _InscripcionesScreenState extends State<InscripcionesScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Inscripcion>> futureInscripciones;
  late Future<List<Estudiante>> futureEstudiantes;
  late Future<List<Materia>> futureMaterias;
  late Future<List<Grupo>> futureGrupos;

  List<Estudiante> estudiantes = [];
  List<Materia> materias = [];
  List<Grupo> grupos = [];

  @override
  void initState() {
    super.initState();
    futureInscripciones = apiService.fetchInscripciones();
    futureEstudiantes = apiService.fetchEstudiantes();
    futureMaterias = apiService.fetchMaterias();
    futureGrupos = apiService.fetchGrupos();

    fetchData();
  }

  Future<void> fetchData() async {
    estudiantes = await apiService.fetchEstudiantes();
    materias = await apiService.fetchMaterias();
    grupos = await apiService.fetchGrupos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscripciones'),
      ),
      body: FutureBuilder<List<Inscripcion>>(
        future: futureInscripciones,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay inscripciones'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Inscripcion inscripcion = snapshot.data![index];
                String estudianteNombre = estudiantes
                    .firstWhere(
                        (e) => e.idEstudiante == inscripcion.estudianteId,
                        orElse: () => Estudiante(
                            idEstudiante: 0,
                            nombre: 'Desconocido',
                            correo: '',
                            numeroRegistro: ''))
                    .nombre;

                String materiaNombre = materias
                    .firstWhere((m) => m.idMateria == inscripcion.materiaId,
                        orElse: () => Materia(
                            idMateria: 0, nombre: 'Desconocido', docenteId: 0))
                    .nombre;

                String grupoNombre = grupos
                    .firstWhere((g) => g.idGrupo == inscripcion.grupoId,
                        orElse: () => Grupo(idGrupo: 0, nombre: 'Desconocido'))
                    .nombre;

                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Estudiante: $estudianteNombre.'),
                      Text('Materia: $materiaNombre.'),
                      Text('Grupo: $grupoNombre.'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (estudiantes.isNotEmpty &&
              materias.isNotEmpty &&
              grupos.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddInscripcionPage(
                      apiService: apiService,
                      estudiantes: estudiantes,
                      materias: materias,
                      grupos: grupos)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    'Datos de estudiantes, materias o grupos no disponibles')));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
