// Patrón Memento en Dart

class GameMemento {
  final int level;
  final int health;
  final String position;

  GameMemento(this.level, this.health, this.position);

  int getLevel() => level;
  int getHealth() => health;
  String getPosition() => position;
}

class Game {
  int level = 1;
  int health = 100;
  String position = 'inicio';

  Game() {
    print(
        '''\nJugando en el nivel: $level\n  salud: $health\n  posición: $position''');
  }

  // Guardar el estado actual del juego
  GameMemento save() {
    return GameMemento(level, health, position);
  }

  // Simular jugar y cambiar el estado
  void play(int newLevel, int newHealth, String newPosition) {
    level = newLevel;
    health = newHealth;
    position = newPosition;
    print(
        '''\nJugando en el nivel: $level\n  salud: $health\n  posición: $position''');
  }

  // Restaurar el estado desde un memento
  void restore(GameMemento memento) {
    level = memento.getLevel();
    health = memento.getHealth();
    position = memento.getPosition();

    print('''\n\n🔄 Progreso restaurado
Restauración en el nivel: $level\n  salud: $health\n  posición: $position''');
  }
}

class GameHistory {
  final List<GameMemento> _mementos = [];

  void push(GameMemento memento) {
    _mementos.add(memento);
  }

  GameMemento? pop() {
    if (_mementos.isNotEmpty) {
      return _mementos.removeLast();
    }
    return null;
  }
}

void main() {
  final game = Game();
  final history = GameHistory();

  // Punto inicial
  history.push(game.save());

  // Jugador avanza
  game.play(2, 90, 'Bosque encantado');
  history.push(game.save());

  game.play(3, 70, 'Cueva Oscura');
  history.push(game.save());

  game.play(4, 50, 'Castillo del Dragón');
  print('\n🟢 Estado actual');

  // Restaurar al último estado
  final lastCheckpoint = history.pop();
  if (lastCheckpoint != null) {
    game.restore(lastCheckpoint);
    print('\n🟡 Después de restaurar el último estado guardado');
  }
}

/*
    GameMemento captura el estado del juego (nivel, salud, posición).
    Game permite jugar, guardar y restaurar el estado.
    GameHistory guarda una pila de estados (mementos) para permitir volver atrás.
    main() simula el progreso del juego y luego revierte al último punto guardado.
 */
