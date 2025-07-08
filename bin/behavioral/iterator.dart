// ! Patrón Iterator
// Este patrón permite recorrer los elementos de una colección
// sin exponer directamente cómo están almacenados internamente.

/*
 * Es útil cuando queremos recorrer elementos secuencialmente
 * sin depender de la estructura subyacente.
 */

/// Interfaz del Iterador personalizado (evitamos usar Iterable/Iterator nativos para estudiar el patrón)
abstract class MyIterator<T> {
  T? next(); // Retorna el siguiente elemento, o null si no hay más
  bool hasNext(); // Retorna true si hay un siguiente elemento
  T? current(); // Retorna el elemento actual sin avanzar
}

/// Clase que representa una Carta
class Card {
  final String name;
  final int value;

  Card(this.name, this.value);
}

/// Colección que almacena cartas y puede crear un iterador para recorrerlas
class CardCollection {
  final List<Card> _cards = [];

  void addCard(Card card) {
    _cards.add(card);
  }

  Card? getCardAt(int index) {
    if (index >= 0 && index < _cards.length) {
      return _cards[index];
    }
    return null;
  }

  int get length => _cards.length;

  CardIterator createIterator() {
    /*
    Esta función es como decir:
    "¿Querés recorrer mis cartas? Perfecto, acá te doy un iterador que sabe cómo hacerlo,
    sin que tengas que mirar directamente cómo las guardo."
    */
    return CardIterator(this);
  }
}

/// Implementación concreta del iterador para recorrer la colección de cartas
class CardIterator implements MyIterator<Card> {
  final CardCollection _collection;
  int _position = 0;

  CardIterator(this._collection);

  @override
  Card? next() {
    if (hasNext()) {
      return _collection.getCardAt(_position++);
    }
    return null;
  }

  @override
  bool hasNext() {
    return _position < _collection.length;
  }

  @override
  Card? current() {
    return _collection.getCardAt(_position);
  }
}

/// Función main que simula el uso del patrón Iterator
void main() {
  final deck = CardCollection();

  // Agregamos algunas cartas a la baraja
  deck.addCard(Card('As de Corazones', 1));
  deck.addCard(Card('Rey de Corazones', 13));
  deck.addCard(Card('Reina de Corazones', 12));
  deck.addCard(Card('Jota de Corazones', 11));

  // Obtenemos el iterador para recorrer la colección
  final iterator = deck.createIterator();

  // Recorremos la colección usando el patrón Iterator
  while (iterator.hasNext()) {
    final card = iterator.next();
    if (card != null) {
      print('Carta: ${card.name}, Valor: ${card.value}');
    }
  }
}
