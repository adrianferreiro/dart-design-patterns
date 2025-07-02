// 📦 Inmutabilidad con copia en Dart usando PlayerProps

// 📋 Clase auxiliar para agrupar propiedades
class PlayerProps {
  final String name;
  final int score;
  final int level;

  const PlayerProps({
    required this.name,
    required this.score,
    required this.level,
  });

  PlayerProps copyWith({
    String? name,
    int? score,
    int? level,
  }) {
    return PlayerProps(
      name: name ?? this.name,
      score: score ?? this.score,
      level: level ?? this.level,
    );
  }
}

// 👤 Clase Player inmutable que delega en PlayerProps
class Player {
  final PlayerProps props;

  const Player({required this.props});

  Player copyWith({
    String? name,
    int? score,
    int? level,
  }) {
    return Player(
      props: props.copyWith(
        name: name,
        score: score,
        level: level,
      ),
    );
  }

  void displayState() {
    print('\n🎮 Jugador: ${props.name}');
    print('🏆 Puntaje: ${props.score}');
    print('📈 Nivel: ${props.level}');
  }
}

// 🧪 Código Cliente para probar
void main() {
  // Crear jugador inicial
  var player = Player(
    props: PlayerProps(name: 'Carlos', score: 0, level: 1),
  );
  print('🔰 Estado inicial:');
  player.displayState();

  // Incrementar el puntaje
  player = player.copyWith(score: 10);
  print('\n💯 Después de incrementar el puntaje:');
  player.displayState();

  // Subir de nivel
  player = player.copyWith(level: 2);
  print('\n🚀 Después de subir de nivel:');
  player.displayState();

  // Cambiar el nombre del jugador
  player = player.copyWith(name: 'Carlos Pro');
  print('\n🧑‍💼 Después de cambiar el nombre:');
  player.displayState();
}
