document.addEventListener("DOMContentLoaded", function () {
  fetchAsistencias();
  fetchDocentes();
  fetchEstudiantes();
  fetchMaterias();
});

function fetchAsistencias() {
  fetch("http://192.168.0.219:3000/asistencias")
    .then((response) => response.json())
    .then((data) => {
      console.log(data); // Verificar los datos recibidos
      const asistenciasList = document.getElementById("listado-asistencias");
      asistenciasList.innerHTML = ""; // Limpiar la lista antes de agregar elementos nuevos

      data.forEach((asistencia) => {
        const estudianteNombre = asistencia.estudianteNombre;
        const materiaNombre = asistencia.materiaNombre;
        const estado = asistencia.estado;
        const fecha = asistencia.fecha;

        console.log(`Fecha recibida: ${fecha}`); // Verificar el valor de fecha

        const row = document.createElement("tr");

        const cellNombre = document.createElement("td");
        cellNombre.textContent = estudianteNombre;
        row.appendChild(cellNombre);

        const cellMateria = document.createElement("td");
        cellMateria.textContent = materiaNombre;
        row.appendChild(cellMateria);

        const cellFecha = document.createElement("td");
        if (fecha) {
          const date = new Date(fecha);
          cellFecha.textContent = !isNaN(date)
            ? date.toLocaleDateString()
            : "Fecha no disponible";
        } else {
          cellFecha.textContent = "Fecha no disponible";
        }
        row.appendChild(cellFecha);

        const cellEstado = document.createElement("td");
        cellEstado.textContent = estado;
        row.appendChild(cellEstado);

        asistenciasList.appendChild(row);
      });
    })
    .catch((error) =>
      console.error("Error al obtener las asistencias:", error)
    );
}

function fetchDocentes() {
  fetch("http://192.168.0.219:3000/docentes")
    .then((response) => response.json())
    .then((data) => {
      console.log(data); // Verificar los datos recibidos
      const docentesList = document.getElementById("listado-docentes");
      docentesList.innerHTML = ""; // Limpiar la lista antes de agregar elementos nuevos

      data.forEach((docente) => {
        const idDocente = docente.idDocente;
        const nombreDocente = docente.nombre;
        const correo = docente.correo;

        const row = document.createElement("tr");

        const cellId = document.createElement("td");
        cellId.textContent = idDocente;
        row.appendChild(cellId);

        const cellNombre = document.createElement("td");
        cellNombre.textContent = nombreDocente;
        row.appendChild(cellNombre);

        const cellCorreo = document.createElement("td");
        cellCorreo.textContent = correo;
        row.appendChild(cellCorreo);

        docentesList.appendChild(row);
      });
    })
    .catch((error) => console.error("Error al obtener los docentes:", error));
}

function fetchEstudiantes() {
  fetch("http://192.168.0.219:3000/estudiantes")
    .then((response) => response.json())
    .then((data) => {
      console.log(data); // Verificar los datos recibidos
      const estudiantesList = document.getElementById("listado-estudiantes");
      estudiantesList.innerHTML = ""; // Limpiar la lista antes de agregar elementos nuevos

      data.forEach((estudiante) => {
        const nombre = estudiante.nombre;
        const correo = estudiante.correo;
        const numero_registro = estudiante.numero_registro;

        const row = document.createElement("tr");

        const cellNombre = document.createElement("td");
        cellNombre.textContent = nombre;
        row.appendChild(cellNombre);

        const cellCorreo = document.createElement("td");
        cellCorreo.textContent = correo;
        row.appendChild(cellCorreo);

        const cellNRegistro = document.createElement("td");
        cellNRegistro.textContent = numero_registro;
        row.appendChild(cellNRegistro);

        estudiantesList.appendChild(row);
      });
    })
    .catch((error) => console.error("Error al obtener los docentes:", error));
}

function fetchMaterias() {
  fetch("http://192.168.0.219:3000/materias")
    .then((response) => response.json())
    .then((data) => {
      console.log(data); // Verificar los datos recibidos
      const materiasList = document.getElementById("listado-materias");
      materiasList.innerHTML = ""; // Limpiar la lista antes de agregar elementos nuevos

      data.forEach((materia) => {
        const idmateria = materia.idmateria;
        const nombre = materia.nombre;

        const row = document.createElement("tr");

        const cellId = document.createElement("td");
        cellId.textContent = idmateria;
        row.appendChild(cellId);

        const cellNombre = document.createElement("td");
        cellNombre.textContent = nombre;
        row.appendChild(cellNombre);

        materiasList.appendChild(row);
      });
    })
    .catch((error) => console.error("Error al obtener las materias:", error));
}
