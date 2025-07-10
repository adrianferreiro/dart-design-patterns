/**
 * ! Patrón Observer
 * El patrón Observer es un patrón de diseño de comportamiento que establece
 * una relación de uno a muchos entre un objeto, llamado sujeto,
 * y otros objetos, llamados observadores, que son notificados
 * y actualizados automáticamente por el sujeto
 * cuando se producen cambios en su estado.
 *
 * * Es útil cuando necesitamos que varios objetos estén
 * * pendientes de los cambios

 *
 * https://refactoring.guru/es/design-patterns/observer
 */

abstract class Observer {
  void notify(String videoTitle);
}

// Clase Subject (sujeto): el canal
class YoutubeChannel {
  final List<Observer> _subscribers = [];
  final String name;

  YoutubeChannel(this.name);

  void subscribe(Observer observer) {
    _subscribers.add(observer);
    print('🟢 Nuevo suscriptor al canal "$name"');
  }

  void unsubscribe(Observer observer) {
    _subscribers.remove(observer);
    print('🔴 Un suscriptor se ha dado de baja del canal "$name"');
  }

  void uploadVideo(String videoTitle) {
    print('\n📢 Canal "$name" ha subido un nuevo video: "$videoTitle"');
    for (final subscriber in _subscribers) {
      subscriber.notify(videoTitle);
    }
  }
}

// Clase Observer concreta: los suscriptores
class Subscriber implements Observer {
  final String name;

  Subscriber(this.name);

  @override
  void notify(String videoTitle) {
    print('🔔 $name ha sido notificado: Nuevo video disponible: "$videoTitle"');
  }
}

// Código cliente
void main() {
  final channel = YoutubeChannel('Cursos programación');

  final adrian = Subscriber('Adrian');
  final omar = Subscriber('Omar');
  final bastian = Subscriber('Bastian');

  channel.subscribe(adrian);
  channel.subscribe(omar);

  channel.uploadVideo('Dart: Lección 1');

  channel.subscribe(bastian);
  channel.uploadVideo('Dart: Lección 2');

  channel.unsubscribe(bastian);

  channel.uploadVideo('Dart: Lección 3');
}

/*
🧠 Explicación breve:
  - YoutubeChannel es el Sujeto (Subject): mantiene una lista de observadores (suscriptores) y los notifica cuando sube un video.
  - Subscriber implementa Observer, que define el método notify.
  - Cada vez que el canal sube un video, todos los suscriptores activos reciben una notificación automática.
*/