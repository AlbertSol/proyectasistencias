const express = require("express");
const mysql = require("mysql");
const cors = require("cors");

const app = express();

// Detalles de la conexion a la base de datos
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'hatsunemiku',
    database: 'proyectasistencias',
});

connection.connect((err)=>{
    if(err){
        console.log('error al conectarse' + err.stack);
        return;
    }
    console.log('conexion a la base de datos')
});

app.use(cors());
app.use(express.json()); // Habilitar el análisis de JSON en las solicitudes

// Rutas para CRUD de estudiantes
app.post('/estudiantes', (req, res) => {
    const { nombre, correo, numero_registro } = req.body;
    const sql = 'INSERT INTO estudiantes (nombre, correo, numero_registro) VALUES (?, ?, ?)';
    connection.query(sql, [nombre, correo, numero_registro], (err, result) => {
        if (err) throw err;
        res.send('¡Estudiante creado exitosamente!');
    });
});

app.get('/estudiantes', (req, res) => {
    const sql = 'SELECT * FROM estudiantes';
    connection.query(sql, (err, results) => {
        if (err) throw err;
        res.json(results);
    });
});

// Rutas para CRUD de materias

app.post('/materias', (req, res)=>{
    const materia = req.body;
    connection.query('INSERT INTO materias SET ?', materia, (err, result) => {
        if(err){
            console.error('Error al insertar la Materia en la base de datos:', err);
            res.status(500).send('Error al insertar la Materia en la base de datos');
            return;
        }
        console.log('Materia insertado correctamente');
        res.status(200).send('Materia insertado correctamente');
    }); 
});

app.get('/materias', (req, res) => {
    connection.query('SELECT * FROM materias', (err, results) => {
        if (err) {
            console.error('Error al obtener los materias de la base de datos:', err);
            res.status(500).send('Error al obtener los materias de la base de datos');
        } else {
            console.log('materias obtenidos correctamente');
            res.status(200).json(results);
        }
    });
});

// Rutas para CRUD de grupos

app.post('/grupos', (req, res)=>{
    const grupo = req.body;
    connection.query('INSERT INTO grupos SET ?', grupo, (err, result) => {
        if(err){
            console.error('Error al insertar la grupo en la base de datos:', err);
            res.status(500).send('Error al insertar la grupo en la base de datos');
            return;
        }
        console.log('Grupo insertado correctamente');
        res.status(200).send('Grupo insertado correctamente');
    }); 
});

app.get('/grupos', (req, res) => {
    connection.query('SELECT * FROM grupos', (err, results) => {
        if (err) {
            console.error('Error al obtener los grupos de la base de datos:', err);
            res.status(500).send('Error al obtener los grupos de la base de datos');
        } else {
            console.log('grupos obtenidos correctamente');
            res.status(200).json(results);
        }
    });
});

// Rutas para CRUD de inscripciones

app.post('/inscripciones', (req, res)=>{
    const inscripcion = req.body;
    connection.query('INSERT INTO inscripciones SET ?', inscripcion, (err, result) => {
        if(err){
            console.error('Error al insertar la inscripcion en la base de datos:', err);
            res.status(500).send('Error al insertar la inscripcion en la base de datos');
            return;
        }
        console.log('Inscripcion insertado correctamente');
        res.status(200).send('Inscripcion insertado correctamente');
    }); 
});

app.get('/inscripciones', (req, res) => {
    connection.query('SELECT * FROM inscripciones', (err, results) => {
        if (err) {
            console.error('Error al obtener los inscripciones de la base de datos:', err);
            res.status(500).send('Error al obtener los inscripciones de la base de datos');
        } else {
            console.log('inscripciones obtenidos correctamente');
            res.status(200).json(results);
        }
    });
});

// Rutas para registro de asistencias

app.post('/asistencias', (req, res)=>{
    const asistencia = req.body;
    connection.query('INSERT INTO asistencias SET ?', asistencia, (err, result) => {
        if(err){
            console.error('Error al insertar la asistencia en la base de datos:', err);
            res.status(500).send('Error al insertar la asistencia en la base de datos');
            return;
        }
        console.log('Asistencia insertado correctamente');
        res.status(200).send('Asistencia insertado correctamente');
    }); 
});

app.get('/asistencias', (req, res) => {
    connection.query('SELECT * FROM asistencias', (err, results) => {
        if (err) {
            console.error('Error al obtener los asistencias de la base de datos:', err);
            res.status(500).send('Error al obtener los asistencias de la base de datos');
        } else {
            console.log('asistencias obtenidos correctamente');
            res.status(200).json(results);
        }
    });
});

//ruta para registro de Docentes
app.post('/docentes', (req, res)=>{
    const docente = req.body;
    connection.query('INSERT INTO docentes SET ?', docente, (err, result) => {
        if(err){
            console.error('Error al insertar el docente en la base de datos:', err);
            res.status(500).send('Error al insertar el docente en la base de datos');
            return;
        }
        console.log('Docente insertado correctamente');
        res.status(200).send('Docente insertado correctamente');
    }); 
});

app.get('/docentes', (req, res) => {
    connection.query('SELECT * FROM docentes', (err, results) => {
        if (err) {
            console.error('Error al obtener los docentes de la base de datos:', err);
            res.status(500).send('Error al obtener los docentes de la base de datos');
        } else {
            console.log('Docentes obtenidos correctamente');
            res.status(200).json(results);
        }
    });
});

app.listen(5000,()=>{
    console.log('Servidor en línea en el puerto 5000');
});
