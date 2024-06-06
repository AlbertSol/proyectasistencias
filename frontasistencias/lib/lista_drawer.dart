import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontasistencias/screens/asistencias_screen.dart';
import 'package:frontasistencias/screens/docentes_screen.dart';
import 'package:frontasistencias/screens/estudiantes_screen.dart';
import 'package:frontasistencias/screens/grupos_screen.dart';
import 'package:frontasistencias/screens/inscripciones_screen.dart';
import 'package:frontasistencias/screens/materias_screen.dart';

class lista_drawer extends StatelessWidget {
  const lista_drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Juan Alberto León Solano.",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              "pv200120028@vallarta.tecmm.edu.mx",
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/img/sisti.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/semana.jpeg"),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: Icon(
              Icons.assignment_ind,
              color: Colors.blue,
            ),
            title: Text("Lista de Alumnos"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EstudiantesScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.cast_for_education,
              color: Colors.blue,
            ),
            title: Text("Lista de Docentes"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DocentesScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.book_rounded,
              color: Colors.blue,
            ),
            title: Text("Lista de Materias"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MateriasScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.group_add,
              color: Colors.blue,
            ),
            title: Text("Grupos"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GruposScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.app_registration,
              color: Colors.blue,
            ),
            title: Text("Inscripciones"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InscripcionesScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.assignment_turned_in_sharp,
              color: Colors.blue,
            ),
            title: Text("Asistencias"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AsistenciasScreen()));
            },
          ),
        ],
      ),
    );
  }
}
