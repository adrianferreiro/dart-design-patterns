// 🔗 Patrón Chain of Responsibility en Dart

/*
 * ! Patrón Chain of Responsibility
 * Es un patrón de diseño de comportamiento que te permite pasar solicitudes
 * a lo largo de una cadena de manejadores.
 *
 * * Es útil cuando se necesita procesar datos de diferentes maneras, pero no
 * * se sabe de antemano qué tipo de procesamiento se necesita o en qué orden,
 * * pero se sabe que se necesita procesar en una secuencia.
 */

// 1. Interfaz Approver
abstract class Approver {
  Approver setNext(Approver approver);
  void approveRequest(double amount);
}

// 2. Clase base con lógica común
abstract class BaseApprover implements Approver {
  Approver? _nextApprover;

  @override
  Approver setNext(Approver approver) {
    _nextApprover = approver;
    return approver;
  }

  void next(double amount) {
    if (_nextApprover != null) {
      _nextApprover!.approveRequest(amount);
    } else {
      print('❌ Solicitud no pudo ser aprobada.');
    }
  }

  @override
  void approveRequest(double amount); // Implementado por subclases
}

// 3. Aprobadores concretos

class Supervisor extends BaseApprover {
  @override
  void approveRequest(double amount) {
    if (amount <= 1000) {
      print('✅ Aprobado por el Supervisor.');
    } else {
      print('➡️ Pasando solicitud al Gerente...');
      next(amount);
    }
  }
}

class Manager extends BaseApprover {
  @override
  void approveRequest(double amount) {
    if (amount <= 5000) {
      print('✅ Aprobado por el Gerente.');
    } else {
      print('➡️ Pasando solicitud al Director...');
      next(amount);
    }
  }
}

class Director extends BaseApprover {
  @override
  void approveRequest(double amount) {
    print('✅ Aprobado por el Director.');
  }
}

// 4. Código Cliente
void main() {
  final supervisor = Supervisor(); // puede aprobar hasta $1000
  final manager = Manager(); // puede aprobar hasta $5000
  final director = Director(); // aprueba todo

  // Configurar cadena de responsabilidad
  supervisor.setNext(manager).setNext(director);

  print('\n📝 Solicitud de compra de \$500:');
  supervisor.approveRequest(500);

  print('\n📝 Solicitud de compra de \$3000:');
  supervisor.approveRequest(3000);

  print('\n📝 Solicitud de compra de \$7000:');
  supervisor.approveRequest(7000);
}
