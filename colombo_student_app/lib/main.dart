import 'package:flutter/material.dart';

// --- Importaciones del Módulo de Micro-Learning (Motor Gamificado) ---
import 'features/micro_learning/data/mock/reto_mock.dart';
import 'features/micro_learning/presentation/widgets/master_challenge_widget.dart';

// --- Importación del Módulo de Onboarding (NUEVO) ---
import 'features/onboarding/presentation/widgets/onboarding_test_widget.dart';

void main() {
  runApp(const ColomboStudentApp());
}

class ColomboStudentApp extends StatelessWidget {
  const ColomboStudentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Colombo App',
      debugShowCheckedModeBanner: false, // Quitamos la etiqueta roja de debug
      theme: ThemeData(
        // Aplicamos el Gris claro de fondo por defecto
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
        fontFamily: 'Inter',
      ),
      
      // --- RUTEO TEMPORAL ---
      // Aquí cambiamos qué pantalla queremos ver al abrir la app.
      
      // NUEVO: Pantalla de Onboarding activa para probarla
      home: const OnboardingTestWidget(),

      // ANTERIOR: Pantalla del Reto Gamificado 
      // (Está comentada con /* */ para no borrarla y poder volver a ella después)
      /*
      home: Scaffold(
        body: SafeArea(
          child: MasterChallengeWidget(
            reto: mockRetoPresentSimple,
          ),
        ),
      ),
      */
    );
  }
}