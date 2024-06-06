const express = require("express");
const mysql = require("mysql");
const cors = require("cors");

const app = express();

// Detalles de la conexion a la base de datos
const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "hatsunemiku",
  database: "proyectasistencias",
});

connection.connect((err) => {
  if (err) {
    console.log("Error al conectarse: " + err.stack);
    return;
  }
  console.log("Conexión a la base de datos");
});

app.use(cors());
app.use(express.json()); // Habilitar el análisis de JSON en las solicitudes

// Ruta para obtener asistencias con los nombres de los estudiantes y materias
app.get("/asistencias", (req, res) => {
  const sql = `
        SELECT 
            a.idasistencia,
            e.nombre AS estudianteNombre,
            m.nombre AS materiaNombre,
            a.fecha,
            a.estado
        FROM 
            asistencias a
        JOIN 
            estudiantes e ON a.estudiante_id = e.idEstudiante
        JOIN 
            materias m ON a.materia_id = m.idMateria;
    `;
  connection.query(sql, (err, results) => {
    if (err) {
      console.error(
        "Error al obtener las asistencias de la base de datos:",
        err
      );
      res
        .status(500)
        .send("Error al obtener las asistencias de la base de datos");
    } else {
      console.log("Asistencias obtenidas correctamente");
      res.status(200).json(results);
    }
  });
});

app.get("/docentes", (req, res) => {
  const sql = `
        SELECT 
            idDocente, nombre, correo
        from docentes    
    `;
  connection.query(sql, (err, results) => {
    if (err) {
      console.error(
        "Error al obtener las asistencias de la base de datos:",
        err
      );
      res
        .status(500)
        .send("Error al obtener las asistencias de la base de datos");
    } else {
      console.log("Docentes obtenidos correctamente");
      res.status(200).json(results);
    }
  });
});

app.get("/estudiantes", (req, res) => {
  const sql = `
        SELECT 
            nombre, correo, numero_registro
        from estudiantes    
    `;
  connection.query(sql, (err, results) => {
    if (err) {
      console.error(
        "Error al obtener los estudiantes de la base de datos:",
        err
      );
      res
        .status(500)
        .send("Error al obtener los estudiantes de la base de datos");
    } else {
      console.log("Estudiantes obtenidos correctamente");
      res.status(200).json(results);
    }
  });
});

app.get("/materias", (req, res) => {
  const sql = `
        SELECT 
            idmateria, nombre
        from materias    
    `;
  connection.query(sql, (err, results) => {
    if (err) {
      console.error("Error al obtener las materias de la base de datos:", err);
      res.status(500).send("Error al obtener las materias de la base de datos");
    } else {
      console.log("Materias obtenidas correctamente");
      res.status(200).json(results);
    }
  });
});

// Otras rutas para estudiantes, materias, grupos, inscripciones y docentes

app.listen(3000, () => {
  console.log("Servidor en línea en el puerto 3000");
});