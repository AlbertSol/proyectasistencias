import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/materia.dart';
import '../models/docente.dart';
import 'add_materia_page.dart';

class MateriasScreen extends StatefulWidget {
  @override
  _MateriasScreenState createState() => _MateriasScreenState();
}

class _MateriasScreenState extends State<MateriasScreen> {
  final ApiService apiService = ApiService();
  late Future<List<Materia>> futureMaterias;
  late Future<List<Docente>> futureDocentes;

  List<Docente> docentes = [];

  @override
  void initState() {
    super.initState();
    futureMaterias = apiService.fetchMaterias();
    futureDocentes = apiService.fetchDocentes();

    fetchData();
  }

  Future<void> fetchData() async {
    docentes = await apiService.fetchDocentes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Materias'),
      ),
      body: FutureBuilder<List<Materia>>(
        future: futureMaterias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay materias'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Materia materia = snapshot.data![index];
                String docenteNombre = docentes
                    .firstWhere((d) => d.idDocente == materia.docenteId,
                        orElse: () => Docente(
                            idDocente: 0,
                            nombre: 'Desconocido',
                            correo: '',
                            password: ''))
                    .nombre;

                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Materia: ${materia.nombre}.'),
                      Text('Docente: $docenteNombre.'),
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
          if (docentes.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddMateriaPage(
                        apiService: apiService,
                        docentes: docentes,
                      )),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Datos de docentes no disponibles')));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
