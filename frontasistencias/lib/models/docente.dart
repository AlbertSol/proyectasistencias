class Docente {
  final int idDocente;
  final String nombre;
  final String correo;
  final String password;

  Docente(
      {required this.idDocente,
      required this.nombre,
      required this.correo,
      required this.password});

  factory Docente.fromJson(Map<String, dynamic> json) {
    return Docente(
      idDocente: json['idDocente'],
      nombre: json['nombre'],
      correo: json['correo'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idDocente': idDocente,
      'nombre': nombre,
      'correo': correo,
      'password': password,
    };
  }
}
