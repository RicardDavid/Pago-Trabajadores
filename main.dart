void main() {
  double rmv = 1030.0; // remuneración mínima vital
  // Definición de trabajadores

  var admin = Administrativo(
    "Juan Pérez",
    "Gerente",
    5000.0,
    true,
    true,
    500.0,
    "AFP",
    300.0,
  );
  // Datos del administrativo
  var docente = Docente("María García", "Docente", 80, 50.0, "ONP");
  var practicante = Practicante("Carlos López", "Practicante", "AFP");

  admin.calcularPlanilla(rmv);
  admin.mostrarPlanilla();

  print("\n------------------\n");

  docente.calcularPlanilla(rmv);
  docente.mostrarPlanilla();

  print("\n------------------\n");

  practicante.calcularPlanilla(rmv);
  practicante.mostrarPlanilla();
}

// Definición de clases
class Trabajador {
  String nombre;
  String cargo;
  String tipoAporte;
  double ingresoTotal = 0;
  double descuentoTotal = 0;
  double netoPagar = 0;

  Trabajador(this.nombre, this.cargo, this.tipoAporte);

  double calcularAportes() {
    if (tipoAporte == "AFP") {
      double afpObligatorio = ingresoTotal * 0.10;
      double afpSeguro = ingresoTotal * 0.02;
      print("AFP Obligatorio: ${afpObligatorio.toStringAsFixed(2)}");
      print("AFP Seguro: ${afpSeguro.toStringAsFixed(2)}");
      return afpObligatorio + afpSeguro;
    } else {
      double onp = ingresoTotal * 0.13;
      print("ONP: ${onp.toStringAsFixed(2)}");
      return onp;
    }
  }

  /// Método para mostrar la planilla
  void mostrarPlanilla() {
    print("Empleado: $nombre");
    print("Cargo: $cargo");
    print("Ingresos:");
    mostrarIngresos();
    print("Descuentos:");
    mostrarDescuentos();
    print("Neto a pagar: ${netoPagar.toStringAsFixed(2)}");
  }

  void mostrarIngresos() {}
  void mostrarDescuentos() {}
  void calcularPlanilla(double rmv) {}
}

// Definición de clases específica
class Administrativo extends Trabajador {
  double remuneracionBasica;
  bool tieneAsignacionFamiliar;
  bool tieneBonificacion;
  double valorBonificacion;
  double adelanto;
  double asignacionFamiliar = 0;
  double bonificacion = 0;

  Administrativo(
    String nombre,
    String cargo,
    this.remuneracionBasica,
    this.tieneAsignacionFamiliar,
    this.tieneBonificacion,
    this.valorBonificacion,
    String tipoAporte,
    this.adelanto,
  ) : super(nombre, cargo, tipoAporte);

  @override
  void calcularPlanilla(double rmv) {
    asignacionFamiliar = tieneAsignacionFamiliar ? rmv * 0.10 : 0;
    bonificacion = tieneBonificacion ? valorBonificacion : 0;
    ingresoTotal = remuneracionBasica + asignacionFamiliar + bonificacion;

    double aportes = calcularAportes();
    descuentoTotal = aportes + adelanto;

    netoPagar = ingresoTotal - descuentoTotal;
  }

  @override
  void mostrarIngresos() {
    print("Básico: ${remuneracionBasica.toStringAsFixed(2)}");
    print("Asignación familiar: ${asignacionFamiliar.toStringAsFixed(2)}");
    print("Bonificación: ${bonificacion.toStringAsFixed(2)}");
  }

  @override
  void mostrarDescuentos() {
    print("Adelanto: ${adelanto.toStringAsFixed(2)}");
    calcularAportes();
  }
}

class Docente extends Trabajador {
  int horasDictadas;
  double costoPorHora;

  Docente(
    String nombre,
    String cargo,
    this.horasDictadas,
    this.costoPorHora,
    String tipoAporte,
  ) : super(nombre, cargo, tipoAporte);

  @override
  void calcularPlanilla(double rmv) {
    ingresoTotal = horasDictadas * costoPorHora;
    descuentoTotal = calcularAportes();
    netoPagar = ingresoTotal - descuentoTotal;
  }

  @override
  void mostrarIngresos() {
    print("Horas: $horasDictadas");
    print("Costo/hora: ${costoPorHora.toStringAsFixed(2)}");
    print("Total: ${ingresoTotal.toStringAsFixed(2)}");
  }

  @override
  void mostrarDescuentos() {
    calcularAportes();
  }
}

class Practicante extends Trabajador {
  Practicante(String nombre, String cargo, String tipoAporte)
    : super(nombre, cargo, tipoAporte);

  @override
  void calcularPlanilla(double rmv) {
    ingresoTotal = rmv;
    descuentoTotal = calcularAportes();
    netoPagar = ingresoTotal - descuentoTotal;
  }

  @override
  void mostrarIngresos() {
    print("RMV: ${ingresoTotal.toStringAsFixed(2)}");
  }

  @override
  void mostrarDescuentos() {
    calcularAportes();
  }
}
