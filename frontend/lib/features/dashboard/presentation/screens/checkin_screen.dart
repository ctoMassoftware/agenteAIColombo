import 'package:flutter/material.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key});

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  // Lista de emociones predefinidas (Ahora en Inglés)
  final List<Map<String, dynamic>> emociones = [
    {"emoji": "🤩", "texto": "Motivated", "color": Colors.orange},
    {"emoji": "😊", "texto": "Happy", "color": Colors.green},
    {"emoji": "🥱", "texto": "Tired", "color": Colors.blueGrey},
    {"emoji": "😰", "texto": "Anxious", "color": Colors.deepPurple},
  ];

  String? emocionSeleccionada;

  void _seleccionarEmocion(String texto) {
    setState(() {
      emocionSeleccionada = texto;
    });
    
    // Aquí es donde simularemos el envío al backend más adelante
    print("The student feels: $texto");
    
    // Mostrar un feedback visual rápido
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thanks for sharing! Preparing your challenge...'),
        backgroundColor: Color(0xFF0033A0),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // Gris claro fondo
      appBar: AppBar(
        title: const Text('Daily Check-in', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0033A0), // Azul Institucional
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Hello Héctor!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Before starting today's challenge,\nhow are you feeling?",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  fontFamily: 'Inter',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              
              // Cuadrícula de Emociones
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columnas
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.1, // Proporción de las tarjetas
                  ),
                  itemCount: emociones.length,
                  itemBuilder: (context, index) {
                    final emocion = emociones[index];
                    final isSelected = emocionSeleccionada == emocion["texto"];

                    return GestureDetector(
                      onTap: () => _seleccionarEmocion(emocion["texto"]),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: isSelected ? emocion["color"].withOpacity(0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? emocion["color"] : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              emocion["emoji"],
                              style: const TextStyle(fontSize: 50),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              emocion["texto"],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? emocion["color"] : const Color(0xFF1F2937),
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}