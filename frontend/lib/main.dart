import 'package:flutter/material.dart';

// --- IMPORTAMOS EL CEREBRO LOCAL AQUÍ ---
import 'core/storage/local_prefs.dart'; 

// --- Importaciones del Módulo de Micro-Learning (Motor Gamificado) ---
import 'features/micro_learning/data/mock/reto_mock.dart';
import 'features/micro_learning/presentation/widgets/master_challenge_widget.dart';

// --- Importación del Módulo de Onboarding ---
import 'features/onboarding/presentation/widgets/onboarding_test_widget.dart';

// --- Importación del Módulo de Perfil ---
import 'features/profile/presentation/screens/profile_screen.dart'; 

// --- Importaciones del Módulo de Dashboard ---
import 'features/dashboard/presentation/screens/checkin_screen.dart';
import 'features/dashboard/presentation/screens/breathing_screen.dart';
import 'features/dashboard/presentation/screens/checkout_screen.dart';

void main() async {
  // 1. Aseguramos que los motores nativos de Flutter estén listos
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Despertamos nuestro Cerebro Local ANTES de abrir la app
  await LocalPrefs.init();

  // 3. Inicializamos datos de prueba si es la primera vez que abre
  if (LocalPrefs.xp == 0) {
    await LocalPrefs.saveUserName("Héctor Prueba");
    await LocalPrefs.saveXP(1250);
  }

  // 4. Arrancamos la aplicación normalmente
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0033A0)),
        useMaterial3: true,
        // Aplicamos el Gris claro de fondo por defecto
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Inter',
      ),
      
      // --- RUTEO TEMPORAL ---
      // Aquí cambiamos qué pantalla queremos ver al abrir la app.
      
      // ACTUAL: Pantalla de Check-out (Al salir de clase) activa para probarla
      home: const CheckoutScreen(),

      // ANTERIOR: Pantalla de Respiración (Regulación Emocional)
      // (Está comentada con /* */ para no borrarla y poder volver a ella después)
      /*
      home: const BreathingScreen(),
      */

      // ANTERIOR: Pantalla de Check-in (Matriz de Emociones)
      /*
      home: const CheckinScreen(),
      */

      // ANTERIOR: Pantalla de Mi Perfil 
      /*
      home: const ProfileScreen(),
      */

      // ANTERIOR: Pantalla de Onboarding 
      /*
      home: const OnboardingTestWidget(),
      */

      // ANTERIOR: Pantalla del Reto Gamificado 
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