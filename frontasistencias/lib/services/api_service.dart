// lib/services/api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/docente.dart';
import '../models/asistencia.dart';
import '../models/estudiante.dart';
import '../models/materia.dart';
import '../models/grupo.dart';
import '../models/inscripcion.dart';

class ApiService {
  final String baseUrl = 'http://192.168.0.219:5000';

  // Docentes
  Future<List<Docente>> fetchDocentes() async {
    final response = await http.get(Uri.parse('$baseUrl/docentes'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Docente.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load docentes');
    }
  }

  Future<void> addDocente(String nombre, String correo, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/docentes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
        'correo': correo,
        'password': password,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add docente');
    }
  }

  // Asistencias
  Future<List<Asistencia>> fetchAsistencias() async {
    final response = await http.get(Uri.parse('$baseUrl/asistencias'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((asistencia) => Asistencia.fromJson(asistencia))
          .toList();
    } else {
      throw Exception('Failed to load asistencias');
    }
  }

  Future<http.Response> addAsistencia(
      int estudianteId, int materiaId, DateTime fecha, String Estado) async {
    final response = await http.post(
      Uri.parse('$baseUrl/asistencias'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'estudiante_id': estudianteId,
        'materia_id': materiaId,
        'fecha': fecha.toIso8601String(),
        'Estado': Estado,
      }),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to add asistencia');
    }
  }

  // Estudiantes
  Future<List<Estudiante>> fetchEstudiantes() async {
    final response = await http.get(Uri.parse('$baseUrl/estudiantes'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Estudiante.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load estudiantes');
    }
  }

  Future<void> addEstudiante(
      String nombre, String correo, String numeroRegistro) async {
    final response = await http.post(
      Uri.parse('$baseUrl/estudiantes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
        'correo': correo,
        'numero_registro': numeroRegistro,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add estudiante');
    }
  }

  // Materias
  Future<List<Materia>> fetchMaterias() async {
    final response = await http.get(Uri.parse('$baseUrl/materias'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Materia.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load materias');
    }
  }

  Future<void> addMateria(String nombre, int docenteId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/materias'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nombre': nombre,
        'docente_id': docenteId,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add materia');
    }
  }

  // Grupos
  Future<List<Grupo>> fetchGrupos() async {
    final response = await http.get(Uri.parse('$baseUrl/grupos'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Grupo.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load grupos');
    }
  }

  Future<void> addGrupo(String nombre) async {
    final response = await http.post(
      Uri.parse('$baseUrl/grupos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add grupo');
    }
  }

  // Inscripciones
  Future<List<Inscripcion>> fetchInscripciones() async {
    final response = await http.get(Uri.parse('$baseUrl/inscripciones'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Inscripcion.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load inscripciones');
    }
  }

  Future<void> addInscripcion(
      int estudianteId, int materiaId, int grupoId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/inscripciones'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'estudiante_id': estudianteId,
        'materia_id': materiaId,
        'grupo_id': grupoId,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add inscripcion');
    }
  }
}
