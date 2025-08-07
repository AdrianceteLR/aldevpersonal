class AIResponseGenerator {
  static String generateResponse(String userMessage) {
    final message = userMessage.toLowerCase();
    
    if (message.contains('finanzas') || message.contains('dinero') || message.contains('gastos')) {
      return 'Basándome en tus datos, veo que has gastado \$750 este mes. Te recomiendo reducir los gastos en entretenimiento y aumentar tus ahorros en un 15%. ¿Te gustaría que te ayude a crear un plan de ahorro?';
    }
    
    if (message.contains('entrenar') || message.contains('ejercicio') || message.contains('gym')) {
      return 'Has completado 4 entrenamientos esta semana, ¡excelente! Para optimizar tus resultados, te sugiero aumentar el peso en press de banca gradualmente y añadir más cardio los días de descanso.';
    }
    
    if (message.contains('resumen') || message.contains('semana')) {
      return 'Esta semana has tenido un buen rendimiento: 4 entrenamientos completados, gastos controlados en \$750, y 7.2h promedio de sueño. Te recomiendo mantener esta consistencia y enfocarte en mejorar la calidad del sueño.';
    }
    
    if (message.contains('meta') || message.contains('objetivo')) {
      return 'Basándome en tus patrones, te sugiero estas metas para el próximo mes: Ahorrar \$200 adicionales, aumentar a 5 entrenamientos semanales, y mantener 8h de sueño diarias. ¿Te parece alcanzable?';
    }
    
    return 'Entiendo tu consulta. Basándome en tus datos de la app, puedo ayudarte a optimizar tus finanzas, entrenamientos y hábitos. ¿Hay algo específico en lo que te gustaría que me enfoque?';
  }
}