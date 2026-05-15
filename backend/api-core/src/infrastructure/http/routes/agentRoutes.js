const express = require('express');
const router = express.Router();
const AgentController = require('../controllers/AgentController');

// Ruta para generar el reto (Recibe el ID del usuario en la URL)
router.get('/challenge/:user_id', AgentController.generateChallenge);

module.exports = router;