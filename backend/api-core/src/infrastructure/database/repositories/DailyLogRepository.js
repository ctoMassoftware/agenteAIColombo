const pool = require('../../../config/database');

class DailyLogRepository {
  // 1. Método para crear la tabla conectada a los estudiantes
  static async createTable() {
    const query = `
      CREATE TABLE IF NOT EXISTS daily_logs (
        id SERIAL PRIMARY KEY,
        user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
        estado_animo VARCHAR(50),
        porcentaje_aciertos DECIMAL(5,2) DEFAULT 0.00,
        porcentaje_fracasos DECIMAL(5,2) DEFAULT 0.00,
        tema_dificil TEXT,
        creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `;
    try {
      await pool.query(query);
      console.log('✅ Tabla "daily_logs" verificada/creada y conectada a "users" en PostgreSQL');
    } catch (error) {
      console.error('❌ Error creando la tabla daily_logs:', error);
    }
  }

  // 2. Método para registrar la actividad diaria del estudiante
  static async create(user_id, estado_animo, porcentaje_aciertos, porcentaje_fracasos, tema_dificil) {
    const query = `
      INSERT INTO daily_logs (user_id, estado_animo, porcentaje_aciertos, porcentaje_fracasos, tema_dificil)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *;
    `;
    const values = [user_id, estado_animo, porcentaje_aciertos, porcentaje_fracasos, tema_dificil];
    
    try {
      const { rows } = await pool.query(query, values);
      return rows[0];
    } catch (error) {
      console.error('❌ Error al insertar el registro diario:', error);
      throw error;
    }
  }
}

module.exports = DailyLogRepository;