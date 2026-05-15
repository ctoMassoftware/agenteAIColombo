import 'package:shared_preferences/shared_preferences.dart';

class LocalPrefs {
  static late SharedPreferences _prefs;

  // 1. Inicializar la base de datos local (Se llama una sola vez al abrir la app)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // --- 2. MÉTODOS PARA GUARDAR DATOS (Setters) ---
  static Future<void> saveUserName(String name) async {
    await _prefs.setString('user_name', name);
  }

  static Future<void> saveXP(int xp) async {
    await _prefs.setInt('user_xp', xp);
  }

  // --- 3. MÉTODOS PARA LEER DATOS (Getters) ---
  // Si no hay nada guardado, devolvemos un valor por defecto usando "??"
  static String get userName => _prefs.getString('user_name') ?? 'Estudiante Colombo';
  static int get xp => _prefs.getInt('user_xp') ?? 0;
}