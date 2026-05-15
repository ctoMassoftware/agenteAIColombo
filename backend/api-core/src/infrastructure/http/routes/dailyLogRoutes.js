const express = require('express');
const router = express.Router();
const DailyLogController = require('../controllers/DailyLogController');

router.post('/', DailyLogController.registerLog);

module.exports = router;