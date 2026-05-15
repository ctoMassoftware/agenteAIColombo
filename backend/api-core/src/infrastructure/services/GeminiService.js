const { GoogleGenerativeAI } = require('@google/generative-ai');

class GeminiService {
  static async generateResponse(prompt) {
    try {
      // Inicializamos el SDK con la llave que pusimos en docker-compose
      const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
      
      // Usamos el modelo optimizado para texto rápido
      const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

      // Enviamos nuestro prompt maestro a la IA
      const result = await model.generateContent(prompt);
      const response = await result.response;
      
      // Retornamos el texto puro generado por la IA
      return response.text();
    } catch (error) {
      console.error('❌ Error comunicándose con Gemini API:', error);
      throw new Error('Fallo al conectar con el cerebro de IA');
    }
  }
}

module.exports = GeminiService;