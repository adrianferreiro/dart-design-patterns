/*
📦 Implementamos el patrón Prototype:
Permite clonar objetos complejos sin depender de sus clases concretas.

Es útil cuando queremos duplicar objetos como documentos, personajes de videojuegos,
o en este caso, un Pokémon con sus atributos y ataques.

Referencia: https://refactoring.guru/es/design-patterns/prototype
*/

// 🧬 Clase base que representa un Pokémon
class Pokemon {
  String name;
  String type;
  int level;
  List<String> attacks;

  Pokemon(this.name, this.type, this.level, this.attacks);

  // 🧪 Método Prototype: clona el Pokémon evitando compartir la lista de ataques
  Pokemon clone() {
    return Pokemon(
        name, // String → por valor
        type, // String → por valor
        level, // int → por valor
        List.from(
            attacks) // List → se clona para evitar referencias compartidas
        );
  }

  void displayInfo() {
    print('Nombre: $name');
    print('Tipo: $type');
    print('Nivel: $level');
    print('Ataques: ${attacks.join(', ')}');
    print('-----------------------------');
  }
}

// 🧪 Cliente
void main() {
  // 1️⃣ Crear Pokémon base
  final basePokemon =
      Pokemon('Charmander', 'Fuego', 1, ['Llamarada', 'Arañazo']);

  // 2️⃣ Clonar y modificar
  final clone1 = basePokemon.clone();
  clone1.name = 'Charmeleon';
  clone1.level = 16;
  clone1.attacks.add('Lanzallamas');

  // 3️⃣ Mostrar detalles
  basePokemon.displayInfo(); // No debe mostrar "Lanzallamas"
  clone1.displayInfo();
}
