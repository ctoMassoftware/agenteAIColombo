const pool = require('../../../config/database');

class DashboardViewRepository {
  // 1. Método para crear la estructura de la Vista Materializada
  static async createMaterializedView() {
    // Cruzamos la tabla de usuarios con sus registros diarios
    const query = `
      CREATE MATERIALIZED VIEW IF NOT EXISTS teacher_dashboard_stats AS
      SELECT
        u.id AS student_id,
        u.nombre,
        u.nivel_actual,
        u.modalidad,
        COUNT(d.id) AS total_clases_registradas,
        COALESCE(AVG(d.porcentaje_aciertos), 0) AS promedio_aciertos,
        COALESCE(AVG(d.porcentaje_fracasos), 0) AS promedio_fracasos,
        MAX(d.creado_en) AS ultimo_registro
      FROM users u
      LEFT JOIN daily_logs d ON u.id = d.user_id
      GROUP BY u.id, u.nombre, u.nivel_actual, u.modalidad;
    `;
    try {
      await pool.query(query);
      console.log('📊 Vista Materializada "teacher_dashboard_stats" verificada/creada en PostgreSQL');
    } catch (error) {
      console.error('❌ Error creando la Vista Materializada:', error);
    }
  }

  // 2. Método para refrescar los datos (Se ejecutará en la madrugada)
  static async refreshView() {
    const query = `REFRESH MATERIALIZED VIEW teacher_dashboard_stats;`;
    try {
      await pool.query(query);
      console.log('🔄 Vista Materializada actualizada con los datos más recientes');
    } catch (error) {
      console.error('❌ Error refrescando la Vista Materializada:', error);
    }
  }
}

module.exports = DashboardViewRepository;