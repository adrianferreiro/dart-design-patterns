/**
 * ! Patrón State
 * Este patrón permite a un objeto cambiar su comportamiento
 * cuando su estado interno cambia.
 *
 * * Es útil cuando un objeto tiene un comportamiento que depende de su estado
 * * y debe cambiar su comportamiento en tiempo de ejecución dependiendo de ese estado.
 *
 * https://refactoring.guru/es/design-patterns/state
 */

/**
 * * Objetivo: Implementar el patrón State para simular el funcionamiento
 * * de una máquina expendedora.
 * * La máquina tiene diferentes estados,
 *  * Como Esperando Dinero,
 *  * Seleccionando Producto,
 *  * Entregando Producto,
 * * y su comportamiento varía dependiendo del estado actual.
 */

import 'dart:io';
import 'dart:async';

abstract class State {
  String get name;

  void insertMoney();
  void selectProduct();
  void dispenseProduct();
}

// Clase principal que cambia su comportamiento según el estado actual
class VendingMachine {
  late State _state;

  VendingMachine() {
    _state = WaitingForMoney(this);
  }

  void insertMoney() => _state.insertMoney();
  void selectProduct() => _state.selectProduct();
  void dispenseProduct() => _state.dispenseProduct();

  void setState(State newState) {
    _state = newState;
    print('Estado cambiado a: ${_state.name}\n');
  }

  String getStateName() => _state.name;
}

// Estado: Esperando dinero
class WaitingForMoney implements State {
  @override
  final String name = 'Esperando Dinero';

  final VendingMachine vendingMachine;

  WaitingForMoney(this.vendingMachine);

  @override
  void insertMoney() {
    print('Dinero insertado. Ahora puedes seleccionar un producto.');
    vendingMachine.setState(ProductSelected(vendingMachine));
  }

  @override
  void selectProduct() {
    print('Primero debes insertar dinero.');
  }

  @override
  void dispenseProduct() {
    print('Primero debes insertar dinero.');
  }
}

// Estado: Producto seleccionado
class ProductSelected implements State {
  @override
  final String name = 'Producto Seleccionado';

  final VendingMachine vendingMachine;

  ProductSelected(this.vendingMachine);

  @override
  void insertMoney() {
    print('Ya insertaste dinero. Por favor selecciona un producto.');
  }

  @override
  void selectProduct() {
    print('Producto seleccionado. Preparando para despachar...');
    vendingMachine.setState(DispensingProduct(vendingMachine));
  }

  @override
  void dispenseProduct() {
    print('Selecciona un producto primero.');
  }
}

// Estado: Despachando producto
class DispensingProduct implements State {
  @override
  final String name = 'Despachando Producto';

  final VendingMachine vendingMachine;

  DispensingProduct(this.vendingMachine);

  @override
  void insertMoney() {
    print('Espera a que se entregue el producto.');
  }

  @override
  void selectProduct() {
    print('Producto ya seleccionado. Despachando...');
  }

  @override
  void dispenseProduct() {
    print('Producto entregado. Volviendo al estado inicial.');
    vendingMachine.setState(WaitingForMoney(vendingMachine));
  }
}

Future<void> main() async {
  final vendingMachine = VendingMachine();

  String? selectedOption;
  do {
    print('\nEstado actual: ${vendingMachine.getStateName()}');
    print('Selecciona una opción:');
    print('1. Insertar dinero');
    print('2. Seleccionar producto');
    print('3. Dispensar producto');
    print('4. Salir');
    stdout.write('Opción: ');

    selectedOption = stdin.readLineSync();
    switch (selectedOption) {
      case '1':
        vendingMachine.insertMoney();
        break;
      case '2':
        vendingMachine.selectProduct();
        break;
      case '3':
        vendingMachine.dispenseProduct();
        break;
      case '4':
        print('Saliendo...');
        break;
      default:
        print('Opción no válida.');
    }

    await Future.delayed(Duration(seconds: 2));
  } while (selectedOption != '4');
}
