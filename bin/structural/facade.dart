// 🖥️ Patrón Facade en Dart

/*
 * ! Patrón Facade
 * Este patrón proporciona una interfaz unificada para un conjunto de interfaces
 * en un subsistema.
 *
 * Facade define una interfaz de nivel más alto que hace que el subsistema
 * sea más fácil de usar.
 *
 * * Es útil cuando un subsistema es complejo o difícil de entender para
 * * proporcionar una interfaz simplificada para el cliente.
 *
 * 🔗 https://refactoring.guru/es/design-patterns/facade
 */

// 1. Clases del Subsistema

class CPU {
  void stopOperations() {
    print('🧠 CPU: Deteniendo operaciones.');
  }

  void jump(int position) {
    print('🧠 CPU: Saltando a la posición de memoria $position.');
  }

  void execute() {
    print('🧠 CPU: Ejecutando instrucciones.');
  }
}

class HardDrive {
  String read(int position, int size) {
    print('💽 HardDrive: Leyendo $size bytes desde la posición $position.');
    return '001010001010100';
  }

  void close() {
    print('💽 HardDrive: Deteniendo disco duro.');
  }
}

class Memory {
  void load(int position, String data) {
    print('🧠 Memory: Cargando datos en la posición $position: $data');
  }

  void free() {
    print('🧠 Memory: Liberando memoria.');
  }
}

// 2. Clase Facade

class ComputerFacade {
  final CPU _cpu = CPU();
  final HardDrive _hardDrive = HardDrive();
  final Memory _memory = Memory();

  void startComputer() {
    print('\n🔌 Iniciando la computadora...\n');

    final data = _hardDrive.read(0, 1024);
    _memory.load(0, data);
    _cpu.jump(0);
    _cpu.execute();

    print('\n✅ Computadora lista para usar.\n');
  }

  void shutDownComputer() {
    print('\n🛑 Apagando la computadora...\n');
    print('💾 Cerrando procesos y guardando datos...');

    _cpu.stopOperations();
    _memory.free();
    _hardDrive.close();

    print('\n🧯 Computadora apagada.\n');
  }
}

// 3. Código Cliente

void main() {
  final computer = ComputerFacade();

  // Encender la computadora usando la fachada
  computer.startComputer();

  // Apagar la computadora usando la fachada
  computer.shutDownComputer();
}
