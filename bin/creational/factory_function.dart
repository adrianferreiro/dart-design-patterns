// 🏭 Factory Function en Dart

/*
 * ! Factory Function
 * Es un patrón de diseño que nos permite crear objetos o funciones de manera dinámica que serán
 * usados posteriormente en el código.
 *
 * * Es útil cuando necesitamos crear objetos o funciones de manera dinámica,
 * * es decir, en tiempo de ejecución y no en tiempo de compilación.
 *
 * 🧪 Salida esperada con colores:
 * [INFO:2025-10-21 07:00:00] Aplicación iniciada correctamente.
 * [WARNING:2025-10-21 07:00:00] El uso de memoria está alto.
 * [ERROR:2025-10-21 07:00:00] Error de conexión a la base de datos.
 */

// 🎨 ANSI colors para consola (solo terminales que soporten)
class AnsiColors {
  static const reset = '\x1B[0m';
  static const green = '\x1B[32m';
  static const yellow = '\x1B[33m';
  static const red = '\x1B[31m';
}

// 📆 Función para formatear fecha y hora
String formatDate(DateTime date) {
  final year = date.year.toString().padLeft(4, '0');
  final month = date.month.toString().padLeft(2, '0');
  final day = date.day.toString().padLeft(2, '0');
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  final second = date.second.toString().padLeft(2, '0');

  return '$year-$month-$day $hour:$minute:$second';
}

// 🔧 Tipos de nivel de log
enum LogLevel { info, warn, error }

// 🏭 Función fábrica que retorna un logger específico
Function(String) createLogger(LogLevel level) {
  final prefix = {
    LogLevel.info: 'INFO',
    LogLevel.warn: 'WARNING',
    LogLevel.error: 'ERROR',
  };

  final color = {
    LogLevel.info: AnsiColors.green,
    LogLevel.warn: AnsiColors.yellow,
    LogLevel.error: AnsiColors.red,
  };

  return (String message) {
    final timestamp = formatDate(DateTime.now());
    final output =
        '${color[level]}[${prefix[level]}: $timestamp] $message${AnsiColors.reset}';
    print(output);
  };
}

// 🧪 Código cliente
void main() {
  final infoLogger = createLogger(LogLevel.info);
  final warnLogger = createLogger(LogLevel.warn);
  final errorLogger = createLogger(LogLevel.error);

  infoLogger('Aplicación iniciada correctamente.');
  warnLogger('El uso de memoria está alto.');
  errorLogger('Error de conexión a la base de datos.');
}
