// 🌲 Patrón Composite en Dart

/*
 * ! Patrón Composite
 * Es un patrón de diseño estructural que permite componer objetos
 * en estructuras de árbol para representar jerarquías.
 *
 * El patrón permite a los clientes tratar de manera uniforme a los objetos
 * individuales y a sus composiciones.
 *
 * * Es útil cuando necesitas tratar a los objetos individuales
 * * y a sus composiciones de manera uniforme, y la estructura
 * * de los objetos forma una jerarquía en árbol.
 *
 * 🔗 https://refactoring.guru/es/design-patterns/composite
 */

// 1. Interfaz MenuComponent
abstract class MenuComponent {
  void showDetails([String indent = '']);
}

// 2. Clase MenuItem (hoja)
class MenuItem implements MenuComponent {
  final String name;
  final double price;

  MenuItem(this.name, this.price);

  @override
  void showDetails([String indent = '']) {
    print('$indent- $name: \$${price.toStringAsFixed(2)}');
  }
}

// 3. Clase MenuCategory (composite)
class MenuCategory implements MenuComponent {
  final String name;
  final List<MenuComponent> _items = [];

  MenuCategory(this.name);

  void add(MenuComponent item) {
    _items.add(item);
  }

  void addAll(List<MenuComponent> items) {
    _items.addAll(items);
  }

  @override
  void showDetails([String indent = '']) {
    print('$indent+ $name');
    for (final item in _items) {
      item.showDetails('$indent  ');
    }
  }
}

// 4. Código Cliente
void main() {
  // Crear ítems individuales
  final salad = MenuItem('Ensalada', 5.99);
  final soup = MenuItem('Sopa de tomate', 4.99);
  final steak = MenuItem('Bistec', 15.99);
  final soda = MenuItem('Refresco', 2.5);
  final dessert = MenuItem('Pastel de chocolate', 6.5);
  final coffee = MenuItem('Café', 1.99);

  // Crear categorías de menú y añadir ítems
  final appetizers = MenuCategory('Entradas')
    ..add(salad)
    ..add(soup);

  final mainCourse = MenuCategory('Plato Principal')..add(steak);

  final beverages = MenuCategory('Bebidas')
    ..add(soda)
    ..add(coffee);

  final desserts = MenuCategory('Postres')..add(dessert);

  // Crear el menú principal
  final mainMenu = MenuCategory('Menú Principal');
  mainMenu.addAll([appetizers, beverages, desserts, mainCourse]);

  // Mostrar el menú completo
  print('📋 Menú del Restaurante:');
  mainMenu.showDetails();
}


/*

✅ Qué hace este código:
  - MenuComponent es la interfaz común.

  - MenuItem es un objeto hoja.

  - MenuCategory es un composite que puede contener MenuItem o más MenuCategory.

  - El cliente (main()) construye una estructura jerárquica de categorías y las muestra con showDetails.

 */