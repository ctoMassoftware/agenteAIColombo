class RetoModel {
  final String idReto;
  final String tipoReto;
  final String nivel;
  final String habilidadObjetivo;
  final String pregunta;
  final String? imagenUrl; // Nullable (?) porque a veces no habrá imagen
  final Map<String, String> opciones;
  final String respuestaCorrecta;
  final String explicacion;

  RetoModel({
    required this.idReto,
    required this.tipoReto,
    required this.nivel,
    required this.habilidadObjetivo,
    required this.pregunta,
    this.imagenUrl,
    required this.opciones,
    required this.respuestaCorrecta,
    required this.explicacion,
  });

  // Factory constructor para construir el objeto desde el JSON de Node.js
  factory RetoModel.fromJson(Map<String, dynamic> json) {
    return RetoModel(
      idReto: json['id_reto'] ?? '',
      tipoReto: json['tipo_reto'] ?? '',
      nivel: json['nivel'] ?? '',
      habilidadObjetivo: json['habilidad_objetivo'] ?? '',
      pregunta: json['pregunta'] ?? '',
      imagenUrl: json['imagen_url'], // Puede ser null
      // Convertimos el mapa dinámico a un mapa de Strings fuertemente tipado
      opciones: Map<String, String>.from(json['opciones'] ?? {}),
      respuestaCorrecta: json['respuesta_correcta'] ?? '',
      explicacion: json['explicacion'] ?? '',
    );
  }

  // Método opcional para convertir el objeto de vuelta a JSON (útil para caché)
  Map<String, dynamic> toJson() {
    return {
      'id_reto': idReto,
      'tipo_reto': tipoReto,
      'nivel': nivel,
      'habilidad_objetivo': habilidadObjetivo,
      'pregunta': pregunta,
      'imagen_url': imagenUrl,
      'opciones': opciones,
      'respuesta_correcta': respuestaCorrecta,
      'explicacion': explicacion,
    };
  }
}