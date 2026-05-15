import 'package:flutter/material.dart';

/// Función que despliega el panel inferior con la explicación del reto.
void showExplanationBottomSheet({
  required BuildContext context,
  required bool isCorrect,
  required String explanation,
  required VoidCallback onNextChallenge,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: false, // Evita que se cierre tocando afuera, forzando a leer
    enableDrag: false,    // Evita que lo cierren deslizando
    backgroundColor: Colors.transparent, // Transparente para aplicar los bordes redondeados
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
          color: Color(0xFFFFFFFF), // Blanco 
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Se adapta al contenido
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- 🎯 Título y Feedback Visual ---
            Row(
              children: [
                Icon(
                  isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  color: isCorrect ? Colors.green : const Color(0xFFF42A35), // Rojo principal si falla [cite: 48]
                  size: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  isCorrect ? '¡Excelente!' : '¡Casi lo tienes!',
                  style: const TextStyle(
                    fontFamily: 'Inter', // [cite: 83]
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937), // Texto principal [cite: 50]
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // --- 📚 Texto de Explicación ---
            Text(
              explanation, // Aquí inyectaremos el texto del JSON 
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Color(0xFF6B7280), // Texto secundario [cite: 50]
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            
            // --- 🚀 Botón Siguiente Reto ---
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el BottomSheet
                onNextChallenge();      // Llama a la función para avanzar
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF43419B), // Azul institucional 
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Siguiente Reto',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}