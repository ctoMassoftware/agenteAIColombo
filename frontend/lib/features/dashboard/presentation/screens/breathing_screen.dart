import 'package:flutter/material.dart';
import 'dart:async';

class BreathingScreen extends StatefulWidget {
  const BreathingScreen({super.key});

  @override
  State<BreathingScreen> createState() => _BreathingScreenState();
}

class _BreathingScreenState extends State<BreathingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  String _instruccion = "Breathe in...";
  int _segundosRestantes = 30;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Configuración del AnimationController (4 segundos por ciclo)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Animación de escala (de tamaño 1.0 a 2.0)
    _animation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Escuchar los cambios de la animación para cambiar el texto
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _instruccion = "Breathe out...");
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() => _instruccion = "Breathe in...");
        _controller.forward();
      }
    });

    // Iniciar el ciclo de respiración
    _controller.forward();

    // Temporizador de 30 segundos
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_segundosRestantes > 0) {
        setState(() {
          _segundosRestantes--;
        });
      } else {
        _timer?.cancel();
        _controller.stop();
        setState(() => _instruccion = "Great job! Ready for the challenge.");
        // Aquí iría la redirección al reto gamificado después de unos segundos
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Fondo gris suave institucional
      appBar: AppBar(
        title: const Text('Emotional Check-in', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0033A0), // Azul Colombo
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$_segundosRestantes s",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B7280),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 80),
              
              // Widget animado a 60 FPS
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF0033A0).withOpacity(0.2),
                        border: Border.all(
                          color: const Color(0xFF0033A0).withOpacity(0.5),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0033A0), // Círculo interno sólido
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              
              const SizedBox(height: 100),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  _instruccion,
                  key: ValueKey<String>(_instruccion),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}