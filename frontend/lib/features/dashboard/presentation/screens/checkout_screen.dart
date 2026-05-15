import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _rating = 0;
  String? _selectedFeedback;

  final List<String> _feedbackOptions = [
    "Excellent! 🤩",
    "A bit difficult 🥵",
    "Interesting 🧠",
    "Too easy 🥱"
  ];

  void _submitFeedback() {
    // Aquí simularemos el envío de la calificación al backend más adelante
    print("Class Rating: $_rating stars. Feedback: $_selectedFeedback");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you! Your feedback helps us improve.'),
        backgroundColor: Color(0xFF0033A0),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Fondo gris suave
      appBar: AppBar(
        title: const Text('Session Check-out', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0033A0), // Azul Colombo
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              
              // Título Principal
              const Text(
                "Class Finished! 🎉",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 10),
              
              // Subtítulo
              const Text(
                "How was your learning experience today?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 30),

              // --- 🌟 Sistema Interactiva de Estrellas ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  int starValue = index + 1;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = starValue;
                      });
                    },
                    child: Icon(
                      starValue <= _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                      size: 50,
                      color: starValue <= _rating ? Colors.amber : Colors.grey[400],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 40),

              // --- 🏷️ Botonera de Feedback Rápido ---
              if (_rating > 0) ...[
                const Text(
                  "What best describes your class?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 15),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: _feedbackOptions.map((option) {
                    bool isSelected = _selectedFeedback == option;
                    return ChoiceChip(
                      label: Text(option),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedFeedback = selected ? option : null;
                        });
                      },
                      selectedColor: const Color(0xFF0033A0).withOpacity(0.1),
                      checkmarkColor: const Color(0xFF0033A0),
                      labelStyle: TextStyle(
                        color: isSelected ? const Color(0xFF0033A0) : const Color(0xFF1F2937),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),
              ],

              const Spacer(),

              // --- 🚀 Botón de Guardar y Enviar ---
              ElevatedButton(
                onPressed: _rating == 0 ? null : _submitFeedback,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0033A0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: Colors.grey[300],
                  elevation: 0,
                ),
                child: const Text(
                  "Submit & Close Session",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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