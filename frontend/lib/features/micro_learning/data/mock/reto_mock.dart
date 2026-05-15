import '../models/reto_model.dart';

// Simulación de la respuesta del Backend (Node.js)
final Map<String, dynamic> _jsonPresentSimple = {
  "id_reto": "ret_987654",
  "tipo_reto": "grammar_multiple_choice",
  "nivel": "Starter",
  "habilidad_objetivo": "Present Simple",
  "pregunta": "Choose the correct form of the verb to complete the sentence:\n\n'She ___ to the Colombo every Saturday.'",
  "imagen_url": null,
  "opciones": {
    "A": "go",
    "B": "goes",
    "C": "going",
    "D": "is go"
  },
  "respuesta_correcta": "B",
  "explicacion": "¡Casi perfecto! Pero recuerda la regla de oro: cuando usamos 'He, She, It' en Present Simple, le agregamos -s o -es al verbo. Por eso es 'goes'."
}; // [cite: 66]

// Exportamos el modelo ya tipado y listo para usar en la UI
final RetoModel mockRetoPresentSimple = RetoModel.fromJson(_jsonPresentSimple);