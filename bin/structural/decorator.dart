// 🎭 Patrón Decorator en Dart

/*
 * ! Patrón Decorador
 * Es un patrón de diseño estructural que permite añadir
 * funcionalidades a objetos, colocándolos dentro de
 * objetos decoradores que extienden su comportamiento.
 *
 * No confundir con los decoradores de anotaciones como en TypeScript.
 *
 * * Es útil cuando necesitas añadir funcionalidades a objetos
 *   de manera dinámica y flexible.
 *
 * 🔗 https://refactoring.guru/es/design-patterns/decorator
 */

// 1. Interfaz Character
abstract class Character {
  String getDescription();
  Stats getStats();
}

// Modelo de estadísticas
class Stats {
  final int attack;
  final int defense;

  const Stats({required this.attack, required this.defense});

  @override
  String toString() => 'Ataque: $attack, Defensa: $defense';
}

// 2. Clase base: personaje simple sin equipamiento
class BasicCharacter implements Character {
  @override
  String getDescription() => '🧍 Personaje básico';

  @override
  Stats getStats() => const Stats(attack: 10, defense: 5);
}

// 3. Decorador base
abstract class CharacterDecorator implements Character {
  final Character character;

  CharacterDecorator(this.character);

  @override
  String getDescription() => character.getDescription();

  @override
  Stats getStats() => character.getStats();
}

// 4. Decorador Casco
class HelmetDecorator extends CharacterDecorator {
  HelmetDecorator(super.character);

  @override
  Stats getStats() {
    final stats = super.getStats();
    return Stats(attack: stats.attack, defense: stats.defense + 5);
  }
}

// 5. Decorador Escudo
class ShieldDecorator extends CharacterDecorator {
  ShieldDecorator(super.character);

  @override
  String getDescription() => super.getDescription() + '\n🛡️ con Escudo';

  @override
  Stats getStats() {
    final stats = super.getStats();
    return Stats(attack: stats.attack, defense: stats.defense + 10);
  }
}

// 6. Decorador Espada
class SwordDecorator extends CharacterDecorator {
  SwordDecorator(super.character);

  @override
  String getDescription() => super.getDescription() + '\n⚔️ con Espada';

  @override
  Stats getStats() {
    final stats = super.getStats();
    return Stats(attack: stats.attack + 7, defense: stats.defense);
  }
}

// 7. Decorador Anillo
class RingDecorator extends CharacterDecorator {
  RingDecorator(super.character);

  @override
  String getDescription() => super.getDescription() + '\n💍 con Anillo';

  @override
  Stats getStats() {
    final stats = super.getStats();
    return Stats(attack: stats.attack + 3, defense: stats.defense);
  }
}

// 8. Código Cliente
void main() {
  Character character = BasicCharacter();
  print('\n🔰 Personaje inicial:\n${character.getDescription()}');
  print('📊 Estadísticas: ${character.getStats()}');

  character = HelmetDecorator(character);
  print('\n🪖 Con Casco:\n${character.getDescription()}');
  print('📊 Estadísticas: ${character.getStats()}');

  character = ShieldDecorator(character);
  print('\n🛡️ Con Escudo:\n${character.getDescription()}');
  print('📊 Estadísticas: ${character.getStats()}');

  character = SwordDecorator(character);
  print('\n⚔️ Con Espada:\n${character.getDescription()}');
  print('📊 Estadísticas: ${character.getStats()}');

  character = RingDecorator(character);
  print('\n💍 Con Anillo:\n${character.getDescription()}');
  print('📊 Estadísticas: ${character.getStats()}');
}


/*
✅ Qué hace este código:
  - Define un Character base con sus stats.

  - Crea una clase CharacterDecorator para envolver a cualquier Character.

  - Los decoradores (Helmet, Shield, Sword, Ring) modifican dinámicamente descripción o estadísticas.

  - El cliente puede encadenar decoradores libremente.

 */