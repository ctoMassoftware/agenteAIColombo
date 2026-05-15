const cron = require('node-cron');

class MarcapasosWorker {
  static start() {
    console.log('⏱️ Marcapasos Algorítmico (Cron) iniciado. Escuchando el tiempo...');

    // Explicación de los asteriscos: '* * * * *' significa "Ejecutar CADA MINUTO"
    // En producción usaríamos algo como '0 * * * *' (Cada hora en punto)
    cron.schedule('* * * * *', () => {
      const horaActual = new Date().toLocaleTimeString('es-CO');
      console.log(`\n⏰ [${horaActual}] El Marcapasos está latiendo...`);
      console.log('🔍 Buscando estudiantes que terminaron clase hace exactamente 1 hora...');
      
      // En la vida real, aquí haríamos un SELECT a PostgreSQL cruzando la hora de fin de clase.
      // Por ahora, simularemos que encontramos a nuestro estudiante y le disparamos el Push:
      
      console.log('📲 [Notificación Push Simulada Enviada] -> "Héctor, ¿Qué tal estuvo la clase hoy? 🎒"');
      console.log('-------------------------------------------------------------------');
    });
  }
}

module.exports = MarcapasosWorker;