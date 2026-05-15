const DailyLogRepository = require('../../database/repositories/DailyLogRepository');

class DailyLogController {
  static async registerLog(req, res) {
    try {
      const { user_id, estado_animo, porcentaje_aciertos, porcentaje_fracasos, tema_dificil } = req.body;
      const newLog = await DailyLogRepository.create(user_id, estado_animo, porcentaje_aciertos, porcentaje_fracasos, tema_dificil);
      
      res.status(201).json({
        mensaje: '📝 Registro diario guardado con éxito',
        log: newLog
      });
    } catch (error) {
      console.error('Error registrando el log diario:', error);
      res.status(500).json({ error: 'Error al registrar la actividad del estudiante' });
    }
  }
}

module.exports = DailyLogController;