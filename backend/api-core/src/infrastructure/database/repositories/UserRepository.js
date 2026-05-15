const pool = require('../../../config/database');

class UserRepository {
  // 1. Método para crear la tabla si no existe (Setup inicial)
  static async createTable() {
    const query = `
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        estilo_aprendizaje VARCHAR(50),
        nivel_actual VARCHAR(50) NOT NULL,
        modalidad VARCHAR(50) NOT NULL,
        creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `;
    try {
      await pool.query(query);
      console.log('✅ Tabla "users" verificada/creada en PostgreSQL');
    } catch (error) {
      console.error('❌ Error creando la tabla users:', error);
    }
  }

  // 2. Método nativo para registrar un nuevo estudiante
  static async create(nombre, estilo_aprendizaje, nivel_actual, modalidad) {
    const query = `
      INSERT INTO users (nombre, estilo_aprendizaje, nivel_actual, modalidad)
      VALUES ($1, $2, $3, $4)
      RETURNING *;
    `;
    // Pasamos los valores en un arreglo para máxima seguridad (Prepared Statements)
    const values = [nombre, estilo_aprendizaje, nivel_actual, modalidad];
    
    try {
      const { rows } = await pool.query(query, values);
      return rows[0];
    } catch (error) {
      console.error('❌ Error al insertar usuario:', error);
      throw error;
    }
  }

  // 3. Método para obtener todos los estudiantes (NUEVO GET)
  static async getAll() {
    const query = `
      SELECT * FROM users 
      ORDER BY id ASC;
    `;
    try {
      const { rows } = await pool.query(query);
      return rows;
    } catch (error) {
      console.error('❌ Error al obtener usuarios:', error);
      throw error;
    }
  }
}

module.exports = UserRepository;