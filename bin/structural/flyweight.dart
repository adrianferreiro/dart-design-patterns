// 🪶 Patrón Flyweight en Dart

/*
 * ! Patrón Flyweight
 * Es un patrón de diseño estructural que nos permite usar objetos compartidos
 * para soportar eficientemente grandes cantidades de objetos.
 *
 * * Es útil cuando necesitamos una gran cantidad de objetos y queremos reducir
 * * la cantidad de memoria que utilizan.
 *
 * 🔗 https://refactoring.guru/es/design-patterns/flyweight
 */

// 1. Interfaz base para mostrar ubicación
abstract class Location {
  void display(Coordinates coordinates);
}

// Clase simple para representar coordenadas
class Coordinates {
  final int x;
  final int y;

  Coordinates(this.x, this.y);
}

// 2. Clase Flyweight: LocationIcon
class LocationIcon implements Location {
  final String type; // Ej: hospital, escuela, parque
  final String iconImage; // Ej: imagen_de_hospital.png

  LocationIcon(this.type, this.iconImage);

  @override
  void display(Coordinates coordinates) {
    print(
        '📍 ${type.toUpperCase()} en (${coordinates.x}, ${coordinates.y}) con icono [$iconImage]');
  }
}

// 3. Fábrica de Flyweight: crea y reutiliza íconos compartidos

class LocationFactory {
  final Map<String, LocationIcon> _icons = {};

  LocationIcon getLocationIcon(String type) {
    if (!_icons.containsKey(type)) {
      print('🛠️ Creando una instancia del ícono de $type');
      final iconImage = 'imagen_de_${type.toLowerCase()}.png';
      // Crea la instancia solamente si no fue creada anteriormente.
      _icons[type] = LocationIcon(type, iconImage);
    }
    return _icons[type]!;
  }
}

// 4. Clase con estado extrínseco (posiciones individuales)

class MapLocation {
  final Coordinates coordinates;
  final LocationIcon icon;

  MapLocation(int x, int y, this.icon) : coordinates = Coordinates(x, y);

  void display() {
    icon.display(coordinates);
  }
}

// 5. Código Cliente
void main() {
  final factory = LocationFactory();

  final locations = [
    MapLocation(10, 20, factory.getLocationIcon('hospital')),
    MapLocation(20, 40, factory.getLocationIcon('hospital')),
    MapLocation(30, 60, factory.getLocationIcon('hospital')),
    MapLocation(35, 65, factory.getLocationIcon('parque')),
    MapLocation(35, 65, factory.getLocationIcon('parque')),
    MapLocation(35, 65, factory.getLocationIcon('parque')),
    MapLocation(30, 60, factory.getLocationIcon('hospital')),
    MapLocation(30, 60, factory.getLocationIcon('escuela')),
    MapLocation(30, 60, factory.getLocationIcon('escuela')),
    MapLocation(30, 60, factory.getLocationIcon('escuela')),
    MapLocation(30, 60, factory.getLocationIcon('escuela')),
  ];

  print('\n🗺️ Mostrando ubicaciones en el mapa:\n');
  for (final location in locations) {
    location.display();
  }
}


/*
✅ Qué hace el código:
  - LocationIcon es el Flyweight: comparte una sola instancia por tipo (hospital, escuela, etc.).
  
  - MapLocation contiene estado extrínseco (posición única de cada ícono).
  
  - LocationFactory se asegura de que no se creen íconos duplicados para el mismo tipo.
  



 */