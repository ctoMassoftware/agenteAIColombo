import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para la retroalimentación háptica
import 'package:confetti/confetti.dart';

// --- Importaciones de nuestra arquitectura ---
// Asegúrate de que las rutas relativas coincidan con la estructura de tus carpetas
import '../../data/models/reto_model.dart'; 
import 'explanation_bottom_sheet.dart'; 

class MasterChallengeWidget extends StatefulWidget {
  // Ahora usamos nuestro modelo fuertemente tipado en lugar del Map genérico
  final RetoModel reto; 

  const MasterChallengeWidget({Key? key, required this.reto}) : super(key: key);

  @override
  State<MasterChallengeWidget> createState() => _MasterChallengeWidgetState();
}

class _MasterChallengeWidgetState extends State<MasterChallengeWidget> {
  // 1. Instanciamos el controlador reutilizable
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    // 2. Optimización: Duración corta (1-2 segundos) para no saturar la CPU
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    // 3. ¡Vital para la optimización! Liberamos el controlador de la memoria
    _confettiController.dispose();
    super.dispose();
  }

  // 4. Lógica de validación ensamblada con tu código
  void _validateAnswer(String selectedOption) {
    // Usamos widget.reto gracias a nuestro RetoModel
    bool isCorrect = selectedOption == widget.reto.respuestaCorrecta;

    if (isCorrect) {
      HapticFeedback.mediumImpact(); // Vibración sutil
      _confettiController.play();    // Lluvia de confeti
    } else {
      HapticFeedback.heavyImpact();  // Vibración fuerte si se equivoca
    }
    
    // Disparamos nuestro nuevo BottomSheet
    showExplanationBottomSheet(
      context: context,
      isCorrect: isCorrect,
      explanation: widget.reto.explicacion, // El texto directo desde el JSON tipado
      onNextChallenge: () {
        // Lógica para pedir el siguiente JSON a tu Node.js
        print("Cargar el siguiente reto...");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter, // El confeti nace desde arriba
      children: [
        // --- 🏗️ Tu UI Principal Aquí (Fondo neutro, Tarjeta, Botones A/B/C/D) ---
        _buildDynamicChallengeUI(),

        // --- 🎉 Capa de Micro-interacción: Confeti Superpuesto ---
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirection: pi / 2, // Dirección hacia abajo
          maxBlastForce: 6,       // Fuerza de explosión controlada
          minBlastForce: 2,
          emissionFrequency: 0.05,
          numberOfParticles: 15,  // Optimizado: Pocas partículas, alto impacto visual
          gravity: 0.3,           // Caída suave y natural
          colors: const [
            Color(0xFF43419B), // Azul institucional
            Color(0xFFF42A35), // Rojo principal
            Color(0xFFF4EB02), // Amarillo brillante
          ],
        ),
      ],
    );
  }

  Widget _buildDynamicChallengeUI() {
    return Container(
      color: const Color(0xFFF5F6FA), // Gris claro fondo
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- 🃏 Tarjeta Blanca de la Pregunta ---
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05), // Sombra muy ligera
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            ),
            child: Text(
              widget.reto.pregunta,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937), // Texto principal
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),

          // --- 🔘 Botones de Opciones Dinámicos ---
          // Iteramos sobre el Map de opciones ("A": "go", "B": "goes"...)
          ...widget.reto.opciones.entries.map((entrada) {
            String letra = entrada.key;      // Ej: "A"
            String textoOpcion = entrada.value; // Ej: "go"

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                // Al presionar, enviamos la letra a la función de validación
                onPressed: () => _validateAnswer(letra),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Estado inactivo: Fondo blanco
                  foregroundColor: const Color(0xFF43419B), // Texto azul
                  side: const BorderSide(
                    color: Color(0xFF43419B), // Borde Azul Institucional
                    width: 2.0,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  children: [
                    // Letra de la opción (A, B, C, D)
                    Text(
                      "$letra.   ",
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Texto de la respuesta
                    Expanded(
                      child: Text(
                        textoOpcion,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(), // Convertimos el Iterable de vuelta a una Lista de Widgets
        ],
      ),
    );
  }
}