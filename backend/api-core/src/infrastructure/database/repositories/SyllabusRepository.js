const pool = require('../../../config/database');

class SyllabusRepository {
  // 1. Método para crear la tabla de conocimiento si no existe
  static async createTable() {
    const query = `
      CREATE TABLE IF NOT EXISTS syllabus (
        id SERIAL PRIMARY KEY,
        nivel VARCHAR(50) NOT NULL,
        unidad VARCHAR(50) NOT NULL,
        tema_gramatical TEXT NOT NULL,
        vocabulario_clave TEXT NOT NULL,
        creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `;
    try {
      await pool.query(query);
      console.log('✅ Tabla "syllabus" (Base RAG) verificada/creada en PostgreSQL');
    } catch (error) {
      console.error('❌ Error creando la tabla syllabus:', error);
    }
  }

  // 2. Método para inyectar una nueva unidad al currículo
  static async create(nivel, unidad, tema_gramatical, vocabulario_clave) {
    const query = `
      INSERT INTO syllabus (nivel, unidad, tema_gramatical, vocabulario_clave)
      VALUES ($1, $2, $3, $4)
      RETURNING *;
    `;
    const values = [nivel, unidad, tema_gramatical, vocabulario_clave];
    
    try {
      const { rows } = await pool.query(query, values);
      return rows[0];
    } catch (error) {
      console.error('❌ Error al insertar en syllabus:', error);
      throw error;
    }
  }
}

module.exports = SyllabusRepository;