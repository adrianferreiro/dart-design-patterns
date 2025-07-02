// 🔒 Singleton en Dart

//🔧 ejemplo simple para entender la diferencia entre Eager Loading y Lazy loading
/*

Lazy loading:
“Voy a hacer el café cuando alguien lo pida.”

Eager loading:
“Voy a preparar el café apenas empiece el día, por si alguien lo pide.”

 */

/*
 * ! Singleton:
 * Es un patrón de diseño creacional que garantiza que una clase
 * tenga una única instancia y proporciona un punto de acceso global a ella.
 *
 * * Es útil cuando necesitas controlar el acceso a una única instancia
 * * de una clase, como por ejemplo, en un objeto de base de datos o en un
 * * objeto de configuración.
 */

//Ejemplo sin lazy loading
// En éste ejemplo tenemos EAGER LOADING (carga anticipada)

class DatabaseConnection {
  //internal es una convención popular para indicarque:
  // 1.- la instancia se construye dentro de la clase.
  // 2.- no debería usarse desde afuera porque es privada.
  static final DatabaseConnection _instance = DatabaseConnection._internal();
  bool _connected = false;

  // 🔐 Constructor privado
  DatabaseConnection._internal() {}

  // 📦 Punto de acceso global
  static DatabaseConnection get instance => _instance;

  // 🔌 Método para conectar
  void connect() {
    if (_connected) {
      print('Ya existe una conexión abierta.');
      return;
    }
    _connected = true;
    print('Conexión exitosa.');
  }

  // 🔌 Método para desconectar
  void disconnect() {
    if (!_connected) {
      print('No hay ninguna conexión activa.');
      return;
    }
    _connected = false;
    print('Fin de la conexión.');
  }
}

// 🧪 Código Cliente
void main() {
  final db1 = DatabaseConnection.instance;
  db1.connect(); // Conectar a la base de datos

  final db2 = DatabaseConnection.instance;
  db2.connect(); // Mostrar que ya existe una conexión activa

  print('Son iguales: ${db1 == db2}'); // Debería mostrar true

  db1.disconnect(); // Cerrar la conexión

  db2.connect(); // Conectar de nuevo
}

//////////////////////////////////////////////////////////////////////////////////////////////

// Ejemplo con lazy loading (carga perezosa)

class DatabaseConnectionLazyLoading {
  static DatabaseConnection? _instance;
  bool _connected = false;

  DatabaseConnectionLazyLoading._internal() {
    print('Conectado a la base de datos.');
  }

  static DatabaseConnection getInstance() {
    _instance ??= DatabaseConnection._internal(); // Lazy loading aquí
    return _instance!;
  }

  void connect() {
    if (_connected) {
      print('Ya existe una conexión abierta.');
      return;
    }
    _connected = true;
    print('Conexión exitosa.');
  }

  void disconnect() {
    if (!_connected) {
      print('No hay ninguna conexión activa.');
      return;
    }
    _connected = false;
    print('Fin de la conexión.');
  }
}
