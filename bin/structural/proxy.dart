// 🛡️ Patrón Proxy en Dart

/*
 * ! Patrón Proxy
 * Este patrón se utiliza para controlar el acceso a un objeto, es decir,
 * se crea un objeto que actúa como intermediario entre el cliente y el objeto real.
 *
 * * Es útil cuando necesitamos controlar el acceso a un objeto,
 * * por ejemplo, para verificar si el cliente tiene permiso
 * * para acceder a ciertos métodos o propiedades.
 *
 * 🔗 https://refactoring.guru/es/design-patterns/proxy
 */

// 1. Interfaz Document
abstract class Document {
  void displayContent(User user);
}

// 2. Documento real (ConfidentialDocument)
class ConfidentialDocument implements Document {
  final String content;

  ConfidentialDocument(this.content);

  @override
  void displayContent(User user) {
    print('📄 Contenido del documento:\n${content}\n');
  }
}

// 3. Clase Proxy - controla el acceso
class DocumentProxy implements Document {
  final Document _document;
  final List<String> _mustHaveRole;

  DocumentProxy(this._document, [this._mustHaveRole = const []]);

  @override
  void displayContent(User user) {
    if (_mustHaveRole.contains(user.role)) {
      _document.displayContent(user);
    } else {
      print(
        '⛔ Acceso denegado. ${user.name}, no tienes permisos suficientes para ver este documento.',
      );
    }
  }
}

// 4. Clase User
class User {
  final String name;
  final String role; // 'admin' o 'user'

  User(this.name, this.role);
}

// 5. Código Cliente
void main() {
  final confidentialDoc = ConfidentialDocument(
    'Este es el contenido confidencial del documento.',
  );

  final proxy = DocumentProxy(
      confidentialDoc, ['admin']); // si agrego 'user', acceden los dos

  final user1 = User('Juan', 'user');
  final user2 = User('Ana', 'admin');

  print('🔐 Intento de acceso del usuario 1:');
  proxy.displayContent(user1); // Denegado

  print('\n🔐 Intento de acceso del usuario 2:');
  proxy.displayContent(user2); // Permitido
}

/*
✅ Qué hace este código:
  - Document es la interfaz esperada por el cliente.
  - ConfidentialDocument es el objeto real que contiene la información.
  - DocumentProxy es el intermediario que controla si el User tiene acceso.
  - El cliente (main()) no interactúa directamente con el documento real.
 */
