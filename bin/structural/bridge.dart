// 🌉 Patrón Bridge en Dart

/*
 * ! Patrón Bridge
 * Este patrón nos permite desacoplar una abstracción de su implementación,
 * de tal forma que ambas puedan variar independientemente.
 *
 * * Es útil cuando se tienen múltiples implementaciones de una abstracción.
 * * Se puede utilizar para separar la lógica de negocio de la lógica de presentación.
 * * Se puede utilizar para separar la lógica de la interfaz de usuario también.
 *
 * 🔗 https://refactoring.guru/es/design-patterns/bridge
 */

/*

    NotificationChannel es la interfaz de implementación (canales).

    Notification es la abstracción que usa esas implementaciones.

    AlertNotification es una implementación concreta de la abstracción.

    Podés agregar nuevos canales o tipos de notificación sin tocar lo demás. Ese es el poder del patrón Bridge.

 */

// 1. Interfaz NotificationChannel
// Cada canal implementa su propia lógica para enviar un mensaje
abstract class NotificationChannel {
  void send(String message);
}

// 2. Implementaciones concretas de canales de comunicación

class EmailChannel implements NotificationChannel {
  @override
  void send(String message) {
    print('📧 Enviando correo electrónico: $message');
  }
}

class SMSChannel implements NotificationChannel {
  @override
  void send(String message) {
    print('📱 Enviando SMS: $message');
  }
}

class PushNotificationChannel implements NotificationChannel {
  @override
  void send(String message) {
    print('📲 Enviando Push Notification: $message');
  }
}

// 3. Clase abstracta Notification (la abstracción principal)

abstract class Notification {
  final List<NotificationChannel> _channels;

  Notification(this._channels);

  void notify(String message);
  void addChannel(NotificationChannel channel) {
    _channels.add(channel);
  }

  void _sendToAll(String message) {
    for (var channel in _channels) {
      channel.send(message);
    }
  }

  // Método protegido simulado (privado por convención)
  List<NotificationChannel> get channels => _channels;
}

// 4. Implementación concreta de la abstracción

class AlertNotification extends Notification {
  AlertNotification(List<NotificationChannel> channels) : super(channels);

  @override
  void notify(String message) {
    print('\n🚨 Notificación de alerta:');
    _sendToAll(message);
  }
}

// 5. Código Cliente

void main() {
  final channels = [
    EmailChannel(),
    SMSChannel(),
    PushNotificationChannel(),
    SMSChannel(), // Ej: diferentes números de teléfono
  ];

  final alert = AlertNotification(channels);

  alert.notify('Hay alguien frente a la casa.');
}
