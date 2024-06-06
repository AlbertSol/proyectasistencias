class Materia {
  final int idMateria;
  final String nombre;
  final int docenteId;

  Materia(
      {required this.idMateria, required this.nombre, required this.docenteId});

  factory Materia.fromJson(Map<String, dynamic> json) {
    return Materia(
      idMateria: json['idMateria'],
      nombre: json['nombre'],
      docenteId: json['docente_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMateria': idMateria,
      'nombre': nombre,
      'docente_id': docenteId,
    };
  }
}
