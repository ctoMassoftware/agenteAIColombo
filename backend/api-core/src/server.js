const express = require('express');
const pool = require('./config/database');
// Importamos nuestro nuevo repositorio de Clean Architecture
const UserRepository = require('./infrastructure/database/repositories/UserRepository');
const SyllabusRepository = require('./infrastructure/database/repositories/SyllabusRepository');
const DailyLogRepository = require('./infrastructure/database/repositories/DailyLogRepository');
const DashboardViewRepository = require('./infrastructure/database/repositories/DashboardViewRepository');
const MarcapasosWorker = require('./infrastructure/workers/marcapasosWorker');


const app = express();
const port = process.env.PORT || 3000;

// Middleware para que Express entienda el formato JSON
app.use(express.json());

// -- NUEVAS LÍNEAS DE RUTAS AQUÍ --
const userRoutes = require('./infrastructure/http/routes/userRoutes');
const syllabusRoutes = require('./infrastructure/http/routes/syllabusRoutes');
const dailyLogRoutes = require('./infrastructure/http/routes/dailyLogRoutes');
const agentRoutes = require('./infrastructure/http/routes/agentRoutes');

app.use('/api/users', userRoutes); 
app.use('/api/syllabus', syllabusRoutes); 
app.use('/api/logs', dailyLogRoutes);
app.use('/api/agent', agentRoutes);
// --------------------------------

// Nuestra ruta de prueba de conexión
app.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT NOW() AS hora_actual');
    res.send(`¡Hola! El Backend Agente AI Colombo está corriendo en Docker 🤖🇨🇴.<br>Hora de la BD: ${result.rows[0].hora_actual}`);
  } catch (error) {
    res.status(500).send('Error conectando a la BD: ' + error.message);
  }
});

// Función central para inicializar el ecosistema
const startServer = async () => {
  try {
    // 1. Construimos/Verificamos las tablas en PostgreSQL usando SQL Nativo
    await UserRepository.createTable();
    await SyllabusRepository.createTable();
    await DailyLogRepository.createTable();
    await DashboardViewRepository.createMaterializedView();

    // 2. Levantamos el servidor Express
    app.listen(port, () => {
      console.log(`🚀 Servidor API Core escuchando en el puerto ${port}`);
      MarcapasosWorker.start();
    });
    
  } catch (error) {
    console.error('❌ Error fatal al iniciar el ecosistema:', error);
  }
};

// Ejecutamos el arranque
startServer();
