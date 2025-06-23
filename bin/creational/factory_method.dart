// 🧱 Factory Method en Dart

abstract class Report {
  void generate();
}

// 🧾 Implementaciones concretas
class SalesReport implements Report {
  @override
  void generate() {
    print('Generando reporte de ventas...');
  }
}

class InventoryReport implements Report {
  @override
  void generate() {
    print('Generando reporte de inventario...');
  }
}

class ManagementReport implements Report {
  @override
  void generate() {
    print('Generando reporte de gerencia...');
  }
}

// 🏭 Fábrica base
abstract class ReportFactory {
  Report _createReport();

  void generateReport() {
    final report = _createReport();
    report.generate();
  }
}

// 🏭 Fábricas concretas
class SalesReportFactory extends ReportFactory {
  @override
  Report _createReport() => SalesReport();
}

class InventoryReportFactory extends ReportFactory {
  @override
  Report _createReport() => InventoryReport();
}

class ManagementReportFactory extends ReportFactory {
  @override
  Report _createReport() => ManagementReport();
}

// 🧪 Simulación de cliente
void main() {
  const reportType =
      'sales'; // Cambiar por 'inventory' o 'management' para las pruebas

  late ReportFactory reportFactory;

  switch (reportType) {
    case 'sales':
      reportFactory = SalesReportFactory();
      break;
    case 'management':
      reportFactory = ManagementReportFactory();
      break;
    case 'inventory':
    default:
      reportFactory = InventoryReportFactory();
  }
  reportFactory.generateReport();
}
