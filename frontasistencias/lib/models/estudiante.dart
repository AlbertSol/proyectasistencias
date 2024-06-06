class Estudiante {
  final int idEstudiante;
  final String nombre;
  final String correo;
  final String numeroRegistro;

  Estudiante(
      {required this.idEstudiante,
      required this.nombre,
      required this.correo,
      required this.numeroRegistro});

  factory Estudiante.fromJson(Map<String, dynamic> json) {
    return Estudiante(
      idEstudiante: json['idEstudiante'],
      nombre: json['nombre'],
      correo: json['correo'],
      numeroRegistro: json['numero_registro'],
    );
  }
}
