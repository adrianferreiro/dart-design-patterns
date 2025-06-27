/*
implementamos el patrón Abstract Factory, generando familias de objetos relacionados (Vehicle y Engine) sin especificar sus clases concretas.
*/

// 🚗 Interfaces de productos
abstract class Vehicle {
  void assemble();
}

abstract class Engine {
  void start();
}

// 🔋 Clases concretas de productos - eléctricos
class ElectricCar implements Vehicle {
  @override
  void assemble() {
    print('Ensamblando un auto eléctrico');
  }
}

class ElectricEngine implements Engine {
  @override
  void start() {
    print('Arrancando motor eléctrico');
  }
}

// ⛽ Clases concretas de productos - combustión
class GasCar implements Vehicle {
  @override
  void assemble() {
    print('Ensamblando un auto de combustión');
  }
}

class GasEngine implements Engine {
  @override
  void start() {
    print('Arrancando motor de combustión');
  }
}

// 🏭 Fábrica abstracta
abstract class VehicleFactory {
  Vehicle createVehicle();
  Engine createEngine();
}

// 🔌 Fábrica concreta - eléctrica
class ElectricVehicleFactory implements VehicleFactory {
  @override
  Vehicle createVehicle() => ElectricCar();

  @override
  Engine createEngine() => ElectricEngine();
}

// 🔧 Fábrica concreta - combustión
class GasVehicleFactory implements VehicleFactory {
  @override
  Vehicle createVehicle() => GasCar();

  @override
  Engine createEngine() => GasEngine();
}

// 🧪 Cliente
void runFactory(VehicleFactory factory) {
  final vehicle = factory.createVehicle();
  final engine = factory.createEngine();

  vehicle.assemble();
  engine.start();
}

// 🚀 Simulación
void main() {
  print('🚗 Creando vehículo eléctrico:');
  runFactory(ElectricVehicleFactory());

  print('\n🚙 Creando vehículo de combustión:');
  runFactory(GasVehicleFactory());
}
