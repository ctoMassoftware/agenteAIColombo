const { Pool } = require('pg');

// Configuramos la conexión usando las variables de entorno que definimos en Docker
const pool = new Pool({
    user: process.env.DB_USER,
    host: process.env.DB_HOST,
    database: process.env.DB_NAME,
    password: process.env.DB_PASSWORD,
    port: process.env.DB_PORT,
});

// Evento para confirmar en consola que la conexión fue exitosa
pool.on('connect', () => {
    console.log('🐘 🔗 Conectado exitosamente a la Base de Datos PostgreSQL pura');
});

// Evento para capturar errores inesperados
pool.on('error', (err) => {
    console.error('❌ Error inesperado en la base de datos', err);
    process.exit(-1);
});

module.exports = pool;