import 'package:flutter/material.dart';
// Ruta actualizada para conectar la pantalla con el modelo en nuestra arquitectura Feature-First
import '../../data/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulamos los datos que vendrán del JSON
    final user = UserModel(
      nombre: "Héctor Prueba",
      nivel: "Starter (A1)",
      modalidad: "Intensivo",
      perfilAprendizaje: "Visual",
      xp: 1250,
      racha: 5,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('Mi Perfil Colombo', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0033A0), // Azul Colombo
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con Avatar
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF0033A0),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 60, color: Color(0xFF0033A0)),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    user.nombre,
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Student ID: #001",
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Tarjetas de Racha y XP
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  _buildStatCard("Racha", "${user.racha} días", Icons.local_fire_department, Colors.orange),
                  const SizedBox(width: 15),
                  _buildStatCard("Puntos XP", "${user.xp}", Icons.star, Colors.amber),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Detalles del Perfil
            _buildDetailTile("Nivel Actual", user.nivel, Icons.school),
            _buildDetailTile("Modalidad", user.modalidad, Icons.calendar_month),
            _buildDetailTile("Tipo de Aprendizaje", user.perfilAprendizaje, Icons.remove_red_eye),
            
            const SizedBox(height: 30),
            
            // Botón Cerrar Sesión (Rojo Colombo)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFCE1126),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                child: const Text("Cerrar Sesión", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 5),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF0033A0)),
        title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
      ),
    );
  }
}