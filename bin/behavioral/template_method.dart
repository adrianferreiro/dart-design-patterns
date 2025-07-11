/**
 * ! Patrón Template Method
 *
 * El patrón Template Method es un patrón de diseño de comportamiento
 * que define el esqueleto de un algoritmo en una operación,
 * delegando algunos pasos a las subclases.
 *
 * Permite que las subclases redefinan ciertos pasos de un algoritmo
 * sin cambiar su estructura.
 *
 * * Es útil cuando se tiene un algoritmo que sigue una secuencia de pasos
 * * y se quiere permitir a las subclases que redefinan algunos de esos pasos.
 *
 * https://refactoring.guru/es/design-patterns/template-method
 */

/**
 * !Objetivo: 
 * Implementar el patrón Template Method para simular un sistema de limpieza 
 * de diferentes tipos de habitaciones 
 * (por ejemplo, una habitación de hotel y una sala de conferencias). 
 * 
 * Debes diseñar una clase base que defina el flujo general de limpieza 
 * y subclases que implementen pasos específicos dependiendo del tipo 
 * de habitación.
 * 
 * 
 * 
 * ! Descripción del Ejercicio
  El proceso de limpieza general incluye los siguientes pasos:
    1.	Entrar a la habitación: Abrir la puerta y entrar.
    2.	Recoger basura: Eliminar la basura de los botes.
    3.	Limpieza específica: Depende del tipo de habitación:
    •	En una habitación de hotel, se hacen las camas.
    •	En una sala de conferencias, se limpian las mesas y se organizan las sillas.
    • En una oficina, se limpian los escritorios y se organizan los documentos.
    4.	Desinfectar superficies: Desinfectar las áreas principales.
    5.	Salir de la habitación: Cerrar la puerta y marcar como terminada
 */

// Clase base que define el algoritmo de limpieza
abstract class RoomCleaning {
  // Método plantilla: define el flujo general del proceso de limpieza
  void cleanRoom() {
    _enterRoom();
    _collectTrash();
    specificCleaning(); // Paso personalizado que define cada subclase
    _disinfectSurfaces();
    _exitRoom();

    print('✅ Limpieza terminada.\n');
  }

  // Métodos comunes a todas las habitaciones
  void _enterRoom() {
    print('🚪 Entrando a la habitación...');
  }

  void _collectTrash() {
    print('🗑️ Recogiendo la basura...');
  }

  void _disinfectSurfaces() {
    print('🧴 Desinfectando superficies...');
  }

  void _exitRoom() {
    print('🚪 Saliendo de la habitación y marcándola como limpia.');
  }

  // Método que las subclases deben implementar para su limpieza específica
  void specificCleaning();
}

// Subclase para habitación de hotel
class HotelRoomCleaning extends RoomCleaning {
  @override
  void specificCleaning() {
    print('🛏️ Haciendo las camas y reponiendo artículos de baño.');
  }
}

// Subclase para sala de conferencias
class ConferenceRoomCleaning extends RoomCleaning {
  @override
  void specificCleaning() {
    print('🪑 Limpiando mesas y organizando sillas.');
  }
}

// Subclase para oficina
class OfficeCleaning extends RoomCleaning {
  @override
  void specificCleaning() {
    print('🗂️ Limpiando escritorios y organizando documentos.');
  }
}

// Código cliente que usa las distintas estrategias
void main() {
  print('🧹 Limpieza de una habitación de hotel:');
  final hotelRoom = HotelRoomCleaning();
  hotelRoom.cleanRoom();

  print('🧹 Limpieza de una sala de conferencias:');
  final conferenceRoom = ConferenceRoomCleaning();
  conferenceRoom.cleanRoom();

  print('🧹 Limpieza de una oficina:');
  final office = OfficeCleaning();
  office.cleanRoom();
}
