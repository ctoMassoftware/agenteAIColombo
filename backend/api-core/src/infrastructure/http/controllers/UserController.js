const UserRepository = require('../../database/repositories/UserRepository');
const jwt = require('jsonwebtoken'); // <-- Importación para la seguridad

class UserController {
  // 1. Método para registrar un nuevo estudiante (POST)
  static async registerStudent(req, res) {
    try {
      // Extraemos los datos que nos envían en la petición (el body)
      const { nombre, estilo_aprendizaje, nivel_actual, modalidad } = req.body;
      
      // Llamamos a nuestro repositorio nativo para guardarlo
      const newUser = await UserRepository.create(nombre, estilo_aprendizaje, nivel_actual, modalidad);
      
      // Devolvemos una respuesta exitosa
      res.status(201).json({
        mensaje: '¡Estudiante registrado con éxito! 🎒',
        estudiante: newUser
      });
    } catch (error) {
      console.error('Error en el controlador:', error);
      res.status(500).json({ error: 'Ocurrió un error al registrar al estudiante' });
    }
  }

  // 2. Método para obtener todos los estudiantes (GET)
  static async getAllStudents(req, res) {
    try {
      // Llamamos a nuestro repositorio para traer todos los registros
      const users = await UserRepository.getAll();
      
      // Devolvemos la lista completa al cliente
      res.status(200).json({
        mensaje: 'Lista de estudiantes recuperada con éxito 📋',
        total: users.length,
        estudiantes: users
      });
    } catch (error) {
      console.error('Error al obtener estudiantes:', error);
      res.status(500).json({ error: 'Ocurrió un error al obtener la lista de estudiantes' });
    }
  }

  // 3. Método para loguearse y obtener el Token JWT (POST)
  static async loginStudent(req, res) {
    try {
      const { id } = req.body; // Simulamos que se loguea con su ID
      
      // Buscamos al estudiante en la base de datos
      const users = await UserRepository.getAll();
      const student = users.find(u => u.id === parseInt(id));

      if (!student) {
        return res.status(404).json({ error: 'Estudiante no encontrado' });
      }

      // LA MAGIA: Generamos el Token JWT firmado digitalmente
      const token = jwt.sign(
        { id: student.id, nombre: student.nombre, nivel: student.nivel_actual },
        process.env.JWT_SECRET,
        { expiresIn: '2h' } // El token se auto-destruirá en 2 horas
      );

      res.status(200).json({
        mensaje: '✅ Login exitoso',
        token: token
      });
    } catch (error) {
      console.error('Error en el login:', error);
      res.status(500).json({ error: 'Ocurrió un error al generar el token' });
    }
  }
}

module.exports = UserController;