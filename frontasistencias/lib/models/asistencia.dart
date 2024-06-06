class Asistencia {
  final int? idAsistencia;
  final int estudianteId;
  final int materiaId;
  final DateTime fecha;
  final String Estado;

  Asistencia({
    this.idAsistencia,
    required this.estudianteId,
    required this.materiaId,
    required this.fecha,
    required this.Estado,
  });

  factory Asistencia.fromJson(Map<String, dynamic> json) {
    return Asistencia(
      idAsistencia: json['idAsistencia'] as int?,
      estudianteId: json['estudiante_id'] ?? 0,
      materiaId: json['materia_id'] ?? 0,
      fecha: DateTime.parse(json['fecha'] ?? ''),
      Estado: json['Estado'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idAsistencia': idAsistencia,
      'estudiante_id': estudianteId,
      'materia_id': materiaId,
      'fecha': fecha.toIso8601String(),
      'Estado': Estado,
    };
  }
}
