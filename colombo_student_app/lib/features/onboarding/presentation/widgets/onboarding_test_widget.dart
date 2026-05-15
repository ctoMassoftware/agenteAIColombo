import 'package:flutter/material.dart';

class OnboardingTestWidget extends StatefulWidget {
  const OnboardingTestWidget({Key? key}) : super(key: key);

  @override
  State<OnboardingTestWidget> createState() => _OnboardingTestWidgetState();
}

class _OnboardingTestWidgetState extends State<OnboardingTestWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double _sliderValue = 3; // Valor inicial para la pregunta del Slider

  // Mock Data basada exactamente en el JSON de nuestro Cuaderno
  final List<Map<String, dynamic>> _preguntas = [
    {
      "tipo_input": "multiple_choice",
      "enunciado": "Cuando quieres aprender una palabra nueva en inglés, ¿qué te funciona mejor?",
      "opciones": [
        {"id": "visual", "texto": "Verla escrita o asociarla a una imagen 👁️"},
        {"id": "auditivo", "texto": "Escucharla en una canción o repetirla en voz alta 🎧"},
        {"id": "kinestesico", "texto": "Escribirla varias veces o usarla en un juego ✍️"}
      ]
    },
    {
      "tipo_input": "slider",
      "enunciado": "Del 1 al 5, ¿qué tan nervioso te sientes al hablar en inglés frente a tu profesor?",
      "min": 1.0,
      "max": 5.0,
    }
  ];

  void _avanzarPagina() {
    if (_currentPage < _preguntas.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      // Aquí conectaremos SharedPreferences/Hive para guardar el perfil
      print("¡Test completado! Guardando perfil en caché local...");
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // Gris claro fondo
      body: SafeArea(
        child: Column(
          children: [
            // --- Barra de Progreso Superior ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (_currentPage + 1) / _preguntas.length,
                        backgroundColor: const Color(0xFFE3E3E3), // Gris suave
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF43419B)), // Azul institucional
                        minHeight: 8,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "${_currentPage + 1}/${_preguntas.length}",
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
            ),

            // --- Contenedor Deslizable (PageView) ---
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Bloquea el deslizamiento manual, fuerza a responder
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _preguntas.length,
                itemBuilder: (context, index) {
                  final pregunta = _preguntas[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Título de la pregunta
                        Text(
                          pregunta["enunciado"],
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1F2937),
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 40),
                        
                        // Renderizado condicional según el tipo_input
                        if (pregunta["tipo_input"] == "multiple_choice")
                          _buildMultipleChoice(pregunta["opciones"])
                        else if (pregunta["tipo_input"] == "slider")
                          _buildSliderInput(pregunta),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Widget Dinámico: Opciones Múltiples ---
  Widget _buildMultipleChoice(List<dynamic> opciones) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: opciones.map((opcion) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ElevatedButton(
            onPressed: _avanzarPagina, // Al tocar, avanza automáticamente
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(color: Color(0xFFD1D5DB)), // Borde gris suave
              ),
              elevation: 0,
            ),
            child: Text(
              opcion["texto"],
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                color: Color(0xFF43419B), // Azul institucional
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }

  // --- Widget Dinámico: Slider de Confianza ---
  Widget _buildSliderInput(Map<String, dynamic> pregunta) {
    return Column(
      children: [
        Text(
          "Nivel: ${_sliderValue.toInt()}",
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF42A35), // Rojo principal para destacar la emoción
          ),
        ),
        const SizedBox(height: 20),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: const Color(0xFF43419B), // Azul Institucional
            inactiveTrackColor: const Color(0xFFE3E3E3),
            thumbColor: const Color(0xFFF4EB02), // Acento Amarillo
            trackHeight: 8.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 16.0),
          ),
          child: Slider(
            value: _sliderValue,
            min: pregunta["min"],
            max: pregunta["max"],
            divisions: 4,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Súper relajado 😎", style: TextStyle(color: Color(0xFF6B7280), fontFamily: 'Inter')),
            Text("Muy nervioso 😰", style: TextStyle(color: Color(0xFF6B7280), fontFamily: 'Inter')),
          ],
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: _avanzarPagina,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF43419B), // Azul institucional
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 40.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
          child: const Text(
            'Confirmar y Finalizar',
            style: TextStyle(fontFamily: 'Inter', fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}