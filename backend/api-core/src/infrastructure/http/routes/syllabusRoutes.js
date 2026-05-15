const express = require('express');
const router = express.Router();
const SyllabusController = require('../controllers/SyllabusController');

router.post('/', SyllabusController.injectUnit);

module.exports = router;