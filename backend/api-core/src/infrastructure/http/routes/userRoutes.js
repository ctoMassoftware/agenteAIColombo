const express = require('express');
const router = express.Router();
const UserController = require('../controllers/UserController');
const authMiddleware = require('../middlewares/authMiddleware'); // <-- Importamos el "portero"

// 🔓 Rutas Públicas (No necesitan token)
router.post('/', UserController.registerStudent);
router.post('/login', UserController.loginStudent); // Nueva ruta para pedir el token

// 🔒 Ruta PROTEGIDA (Necesita token) -> ¡Fíjate que pasamos el authMiddleware en el medio!
router.get('/', authMiddleware, UserController.getAllStudents);

module.exports = router;