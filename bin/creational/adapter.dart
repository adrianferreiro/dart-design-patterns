// 🔌 Patrón Adapter en Dart

/*
 * ! Patrón Adapter
 *  Permite que objetos con interfaces incompatibles trabajen juntos. También es muy
 *  útil para utilizar librerías de terceros en nuestra aplicación sin depender
 *  directamente de ellas.
 *
 * * Es útil cuando se quiere reutilizar una clase que no tiene la interfaz que
 * * necesitamos o cuando queremos crear una capa de abstracción para una librería
 * * de terceros.
 *
 * 🔗 https://refactoring.guru/es/design-patterns/adapter
 */

// 1. Interfaz objetivo que el cliente espera usar
abstract class PaymentProcessor {
  void processPayment(double amount);
}

// 2. Servicios de pago externos con interfaces incompatibles

class PayPalService {
  void sendPayment(double amount) {
    print('Procesando pago de \$${amount.toStringAsFixed(2)} con PayPal 💻');
  }
}

class StripeService {
  void makeCharge(double amount) {
    print('Procesando pago de \$${amount.toStringAsFixed(2)} con Stripe 💳');
  }
}

class MercadoPagoService {
  void pay(double amount) {
    print(
        'Procesando pago de \$${amount.toStringAsFixed(2)} con MercadoPago 🛒');
  }
}

// 3. Adaptadores que implementan la interfaz y delegan a los servicios

class PayPalAdapter implements PaymentProcessor {
  final PayPalService _service;

  PayPalAdapter(this._service);

  @override
  void processPayment(double amount) {
    _service.sendPayment(amount);
  }
}

class StripeAdapter implements PaymentProcessor {
  final StripeService _service;

  StripeAdapter(this._service);

  @override
  void processPayment(double amount) {
    _service.makeCharge(amount);
  }
}

class MercadoPagoAdapter implements PaymentProcessor {
  final MercadoPagoService _service;

  MercadoPagoAdapter(this._service);

  @override
  void processPayment(double amount) {
    _service.pay(amount);
  }
}

// 4. Código Cliente para probar los adaptadores

void main() {
  const paymentAmount = 100.0;

  final paypalProcessor = PayPalAdapter(PayPalService());
  final stripeProcessor = StripeAdapter(StripeService());
  final mercadoPagoProcessor = MercadoPagoAdapter(MercadoPagoService());

  print('🧾 Usando PayPal:');
  paypalProcessor.processPayment(paymentAmount);

  print('\n🧾 Usando Stripe:');
  stripeProcessor.processPayment(paymentAmount);

  print('\n🧾 Usando MercadoPago:');
  mercadoPagoProcessor.processPayment(paymentAmount);
}
