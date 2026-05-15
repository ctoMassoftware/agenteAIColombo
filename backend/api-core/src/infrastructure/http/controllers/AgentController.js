const UserRepository = require('../../database/repositories/UserRepository');
const SyllabusRepository = require('../../database/repositories/SyllabusRepository');
const DailyLogRepository = require('../../database/repositories/DailyLogRepository');
const GenerateRAGPrompt = require('../../../use-cases/GenerateRAGPrompt');
// IMPORTANTE: Aquí importamos el servicio de la Inteligencia Artificial
const GeminiService = require('../../services/GeminiService');

class AgentController {
  static async generateChallenge(req, res) {
    try {
      const { user_id } = req.params;

      // 1. Obtener el perfil del estudiante
      const users = await UserRepository.getAll();
      const student = users.find(u => u.id === parseInt(user_id));
      if (!student) return res.status(404).json({ error: 'Estudiante no encontrado' });

      // 2. Obtener el Syllabus de su nivel
      const pool = require('../../../config/database');
      const syllabusResult = await pool.query(`SELECT * FROM syllabus WHERE nivel = $1 LIMIT 1`, [student.nivel_actual]);
      const syllabus = syllabusResult.rows[0];

      // 3. Obtener el log del día
      const logResult = await pool.query(`SELECT * FROM daily_logs WHERE user_id = $1 ORDER BY id DESC LIMIT 1`, [student.id]);
      const log = logResult.rows[0];

      if(!syllabus || !log) {
        return res.status(400).json({ error: 'Faltan datos de Syllabus o Logs para este estudiante' });
      }

      // 4. LA MAGIA: Ensamblamos el prompt RAG
      const promptEnsamblado = GenerateRAGPrompt.execute(student, log, syllabus);

      // 5. CONEXIÓN A LA IA: Enviamos el prompt maestro a Google Gemini
      const retoGenerado = await GeminiService.generateResponse(promptEnsamblado);

      // 6. Devolvemos la respuesta final ya procesada por la IA al cliente
      res.status(200).json({
        mensaje: '🤖 Reto personalizado generado con éxito',
        reto_final: retoGenerado
      });

    } catch (error) {
      console.error('Error generando el reto:', error);
      res.status(500).json({ error: 'Error interno en el motor de IA' });
    }
  }
}

module.exports = AgentController;