class Grupo {
  final int idGrupo;
  final String nombre;

  Grupo({required this.idGrupo, required this.nombre});

  factory Grupo.fromJson(Map<String, dynamic> json) {
    return Grupo(
      idGrupo: json['idGrupo'],
      nombre: json['nombre'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idGrupo': idGrupo,
      'nombre': nombre,
    };
  }
}
