// Patron Mediator en Dart
// Este ejemplo simula una sala de chat donde los usuarios se comunican a través de un mediador central (ChatRoom).

class ChatRoom {
  final String title;
  final List<User> _users = [];

  ChatRoom(this.title);

  void addUser(User user) {
    _users.add(user);
  }

  void sendMessage(User sender, String message) {
    final usersToReceive = _users.where((u) => u != sender);
    for (final user in usersToReceive) {
      user.receiveMessage(sender, message);
    }
  }
}

class User {
  final String username;
  final ChatRoom chatRoom;

  User(this.username, this.chatRoom) {
    chatRoom.addUser(this);
  }

  void sendMessage(String message) {
    print('$username envía: $message');
    chatRoom.sendMessage(this, message);
  }

  void receiveMessage(User sender, String message) {
    print('$username recibe de ${sender.username}: $message');
  }
}

void main() {
  final chatRoom = ChatRoom('Grupo de trabajo');

  final user1 = User('Adrian', chatRoom);
  final user2 = User('Enrique', chatRoom);
  final user3 = User('Omar', chatRoom);

  user1.sendMessage('Hola a todos!');
  print('\n');
  user2.sendMessage('¡Hola Adrian! ¿Cómo estás?');
  print('\n');
  user3.sendMessage('¡Hola Adrian y Enrique! ¿Cómo están?');
}


/*

✅ ¿Para qué sirve este patrón?
Evita que los objetos (usuarios) se comuniquen directamente entre sí, reduciendo el acoplamiento y facilitando el mantenimiento y extensión del sistema.
 En este caso, si cambia la lógica de envío de mensajes, solo se modifica en ChatRoom.


🧠 ¿Qué hace este código?
Simula un chat grupal donde varios usuarios pueden enviarse mensajes, pero sin comunicarse entre ellos directamente.
En cambio, todos los mensajes pasan por un mediador central, que es la clase ChatRoom.



🧩 ¿Cómo funciona?
1. ChatRoom (el mediador):
    Tiene una lista de usuarios (_users).
    Cada vez que un usuario envía un mensaje, el ChatRoom reenvía ese mensaje a todos los usuarios excepto al remitente.

2. User (los colegas):
    Representa un usuario del chat.
    Cada usuario está vinculado a un ChatRoom cuando se crea.
    Tiene dos métodos:
      sendMessage: para enviar mensajes.
      receiveMessage: para recibir mensajes.

3. main() (el cliente):
    Crea un ChatRoom y tres usuarios (Adrian, Enrique, Omar).
    Simula que cada uno envía un mensaje al grupo.
 */