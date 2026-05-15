class GenerateRAGPrompt {
  /**
   * Este es nuestro Motor RAG. Recibe el contexto exacto de la base de datos
   * y ensambla las instrucciones precisas para el Modelo de Lenguaje (LLM).
   */
  static execute(studentData, logData, syllabusData) {
    // 1. Extraemos las variables clave
    const { nombre, estilo_aprendizaje, nivel_actual } = studentData;
    const { estado_animo, tema_dificil } = logData;
    const { unidad, tema_gramatical, vocabulario_clave } = syllabusData;

    // 2. Definimos el tono de voz según el estado de ánimo (Empatía)
    let tonoVoz = "motivado, enérgico y directo.";
    if (estado_animo.toLowerCase().includes('cansado') || estado_animo.toLowerCase().includes('frustrado')) {
      tonoVoz = "muy empático, paciente, pausado y alentador. Usa frases cortas y sencillas.";
    }

    // 3. Adaptamos la enseñanza al estilo de aprendizaje
    let enfoquePedagogico = "Usa explicaciones estándar.";
    if (estilo_aprendizaje.toLowerCase() === 'visual') {
      enfoquePedagogico = "Usa emojis, viñetas, analogías visuales y estructuras gráficas claras.";
    } else if (estilo_aprendizaje.toLowerCase() === 'auditivo') {
      enfoquePedagogico = "Usa rimas, patrones de repetición o sugiere cómo suenan las palabras en voz alta.";
    }

    // 4. ENSAMBLAMOS EL PROMPT MAESTRO (El corazón del RAG)
    const promptMaestro = `
      Eres el Agente AI Oficial del Centro Colombo Americano. 
      Actúa como un profesor de inglés nativo y amigable.

      ### PERFIL DEL ESTUDIANTE ###
      - Nombre: ${nombre}
      - Nivel Actual: ${nivel_actual} (${unidad})
      - Estilo de Aprendizaje: ${estilo_aprendizaje}
      - Estado de Ánimo Hoy: ${estado_animo}

      ### REGLAS PEDAGÓGICAS ESTRICTAS (RAG) ###
      - SOLO puedes usar esta gramática: ${tema_gramatical}
      - SOLO puedes usar este vocabulario: ${vocabulario_clave}
      - NUNCA uses estructuras gramaticales más avanzadas que el nivel ${nivel_actual}.
      - Enfoque pedagógico a aplicar: ${enfoquePedagogico}
      - Tono de voz a utilizar: ${tonoVoz}

      ### EL RETO A GENERAR ###
      El estudiante reportó que hoy tuvo dificultades con: "${tema_dificil}".
      
      Genera una breve explicación de apoyo (máximo 2 líneas) para este tema, y luego
      crea un reto de selección múltiple (Opciones A, B, C, D) para que el estudiante 
      practique este tema exacto usando el vocabulario permitido.
    `;

    return promptMaestro;
  }
}

module.exports = GenerateRAGPrompt;