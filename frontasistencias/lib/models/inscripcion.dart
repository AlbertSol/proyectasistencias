class Inscripcion {
  final int idInscripcion;
  final int estudianteId;
  final int materiaId;
  final int grupoId;

  Inscripcion(
      {required this.idInscripcion,
      required this.estudianteId,
      required this.materiaId,
      required this.grupoId});

  factory Inscripcion.fromJson(Map<String, dynamic> json) {
    return Inscripcion(
      idInscripcion: json['idInscripcion'],
      estudianteId: json['estudiante_id'],
      materiaId: json['materia_id'],
      grupoId: json['grupo_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idInscripcion': idInscripcion,
      'estudiante_id': estudianteId,
      'materia_id': materiaId,
      'grupo_id': grupoId,
    };
  }
}
