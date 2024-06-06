import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontasistencias/lista_drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Asistencias',
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Registro de Asistencias',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            elevation: 10,
            shadowColor: Color.fromARGB(255, 223, 219, 219),
            centerTitle: true,
            backgroundColor: Color.fromARGB(226, 73, 73, 73),
            actions: [
              IconButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ))
            ],
          ),
          drawer: lista_drawer(),
          backgroundColor: Color.fromARGB(255, 68, 65, 65),
          body: Center(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(children: [
                      CircleAvatar(
                        radius: 100,
                        foregroundImage: AssetImage('assets/img/TSdJ.jpg'),
                      ),
                      Text(
                        'Tecnológico Superior de Jalisco',
                        style: TextStyle(
                          fontFamily: 'Pacifico',
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Campus Puerto Vallarta',
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 20,
                          color: Colors.white70,
                          letterSpacing: 10.5,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
