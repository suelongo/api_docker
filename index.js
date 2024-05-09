const express = require('express');
const { Pool } = require('pg');
const cors = require('cors');

const app = express();
const PORT = 3000;

// Configura la conexión a la base de datos
const pool = new Pool({
  connectionString: 'postgres://api_suelongo_postgres_user:hkPghuIpOfQh4eYhbMRvJUptgMohndXS@dpg-co3kub779t8c738p6dmg-a.oregon-postgres.render.com/api_suelongo_postgres',
  ssl: {
    rejectUnauthorized: false
  }
});

app.use(express.json());
app.use(cors()); // Agregar middleware de CORS

// Endpoint para obtener todas las carreras
app.get('/carreras', async (req, res) => {
  try {
    const { rows } = await pool.query('SELECT * FROM carrera');
    res.json(rows);
  } catch (error) {
    console.error('Error al obtener las carreras:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});

// Endpoint para obtener las especialidades de una carrera específica
app.get('/especialidades/:carrera_id', async (req, res) => {
  const { carrera_id } = req.params;
  try {
    const { rows } = await pool.query('SELECT * FROM especialidad WHERE carrera_id = $1', [carrera_id]);
    res.json(rows);
  } catch (error) {
    console.error('Error al obtener las especialidades:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});

// Endpoint para obtener las materias de especialidad filtradas por especialidad_id para una carrera específica
app.get('/materias_especialidad/:carrera_id', async (req, res) => {
  const { carrera_id } = req.params;
  const { especialidad } = req.query; // Obtenemos el parámetro de consulta "especialidad"
  
  let query = 'SELECT * FROM materia_especialidad WHERE especialidad_id = $1 AND especialidad_id IN (SELECT id FROM especialidad WHERE carrera_id = $2)';
  let queryParams = [especialidad, carrera_id];

  if (especialidad === undefined) {
    // Si no se proporciona el parámetro "especialidad", devolver un error
    return res.status(400).json({ message: 'Especifique la especialidad' });
  }

  try {
    const { rows } = await pool.query(query, queryParams);
    res.json(rows);
  } catch (error) {
    console.error('Error al obtener las materias de especialidad:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});

// Endpoint para obtener solo las materias básicas de una carrera específica
app.get('/materias/:carrera_id', async (req, res) => {
  const { carrera_id } = req.params;
  try {
    // Obtener todas las materias básicas
    const { rows } = await pool.query('SELECT * FROM materia WHERE carrera_id = $1', [carrera_id]);
    res.json(rows);
  } catch (error) {
    console.error('Error al obtener las materias de la carrera:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});
// Endpoint para registrar un nuevo usuario
app.post('/registro', async (req, res) => {
  const { name, last_name, email, career, student_id, password } = req.body;

  try {
      // Verificar si el correo ya está registrado
      const correoExistente = await pool.query('SELECT * FROM usuarios WHERE correo = $1', [email]);
      if (correoExistente.rows.length > 0) {
          return res.status(400).json({ message: 'El correo electrónico ya está registrado' });
      }

      // Insertar el nuevo usuario en la base de datos
      const query = `
          INSERT INTO usuarios (nombre, apellidos, correo, carrera, num_control, contrasena)
          VALUES ($1, $2, $3, $4, $5, $6)
          RETURNING *`;
      const values = [name, last_name, email, career, student_id, password];

      const nuevoUsuario = await pool.query(query, values);

      res.status(201).json({ message: 'Usuario registrado correctamente', usuario: nuevoUsuario.rows[0] });
  } catch (error) {
      console.error('Error al registrar el usuario:', error);
      res.status(500).json({ message: 'Error interno del servidor' });
  }
});

// Endpoint para iniciar sesión
app.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    // Buscar al usuario en la base de datos por correo electrónico
    const result = await pool.query('SELECT * FROM usuarios WHERE correo = $1', [email]);
    
    if (result.rows.length === 0) {
      // El usuario no fue encontrado
      return res.status(401).json({ message: 'Credenciales inválidas' });
    }
    
    const user = result.rows[0];
    
    // Verificar la contraseña
    if (user.contrasena !== password) {
      // La contraseña no coincide
      return res.status(401).json({ message: 'Credenciales inválidas' });
    }

    // Las credenciales son válidas, inicio de sesión exitoso
    res.status(200).json({ message: 'Inicio de sesión exitoso' });
  } catch (error) {
    console.error('Error al iniciar sesión:', error);
    res.status(500).json({ message: 'Error interno del servidor' });
  }
});


app.listen(PORT, () => {
  console.log(`Servidor en funcionamiento en http://localhost:${PORT}`);
});
