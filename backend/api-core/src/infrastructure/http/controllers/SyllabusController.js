const SyllabusRepository = require('../../database/repositories/SyllabusRepository');

class SyllabusController {
  static async injectUnit(req, res) {
    try {
      const { nivel, unidad, tema_gramatical, vocabulario_clave } = req.body;
      const newUnit = await SyllabusRepository.create(nivel, unidad, tema_gramatical, vocabulario_clave);
      
      res.status(201).json({
        mensaje: '📖 Unidad inyectada al Syllabus con éxito',
        unidad: newUnit
      });
    } catch (error) {
      console.error('Error inyectando syllabus:', error);
      res.status(500).json({ error: 'Error al inyectar la unidad al Syllabus' });
    }
  }
}

module.exports = SyllabusController;