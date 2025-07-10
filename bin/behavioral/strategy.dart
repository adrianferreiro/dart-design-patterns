// 📦 Este ejemplo implementa el patrón Strategy en Dart
// para calcular impuestos según el país.

// 🎯 Interfaz Strategy que define el contrato para las estrategias de impuestos
abstract class TaxStrategy {
  double calculateTax(double amount);
}

// 🇺🇸 Estrategia para USA - Impuesto del 10%
class USATaxStrategy implements TaxStrategy {
  @override
  double calculateTax(double amount) => amount * 0.10;
}

// 🇨🇦 Estrategia para Canada - Impuesto del 13%
class CanadaTaxStrategy implements TaxStrategy {
  @override
  double calculateTax(double amount) => amount * 0.13;
}

// 🇩🇪 Estrategia para Alemania - Impuesto del 19%
class GermanyTaxStrategy implements TaxStrategy {
  @override
  double calculateTax(double amount) => amount * 0.19;
}

// 💼 Contexto - Usa una estrategia para calcular impuestos
class TaxCalculator {
  TaxStrategy _strategy;

  TaxCalculator(this._strategy);

  // Permite cambiar la estrategia en tiempo de ejecución
  void setStrategy(TaxStrategy strategy) {
    _strategy = strategy;
  }

  // Calcula el impuesto usando la estrategia actual
  double calculate(double amount) {
    return _strategy.calculateTax(amount);
  }
}

// 🧪 Código cliente para probar el patrón Strategy
void main() {
  final taxCalculator = TaxCalculator(USATaxStrategy());

  print('🧾 Cálculo de impuestos:\n');

  print('🇺🇸 USA: \$${taxCalculator.calculate(100).toStringAsFixed(2)}');

  print('\n🔁 Cambiando a estrategia para 🇨🇦 Canada...');
  taxCalculator.setStrategy(CanadaTaxStrategy());
  print('🇨🇦 Canada: \$${taxCalculator.calculate(100).toStringAsFixed(2)}');

  print('\n🔁 Cambiando a estrategia para 🇩🇪 Germany...');
  taxCalculator.setStrategy(GermanyTaxStrategy());
  print('🇩🇪 Germany: \$${taxCalculator.calculate(100).toStringAsFixed(2)}');
}
