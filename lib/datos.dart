class Socio {
  final String dni;
  final String fullnombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String nombres;
  final String telefono;
  final String celular;
  final String direccion;
  final String correo;
  final String distrito;
  final String provincia;
  final String departamento;
  final int diasAtraso;
  final List<Credito> creditos;

  Socio({
    required this.dni,
    required this.fullnombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.nombres,
    required this.telefono,
    required this.celular,
    required this.direccion,
    required this.correo,
    required this.distrito,
    required this.provincia,
    required this.departamento,
    required this.creditos,
    required this.diasAtraso,
  });

  factory Socio.fromJson(Map<String, dynamic> json) {
    var creditosList = json['creditos'] as List;
    List<Credito> creditos =
        creditosList.map((credit) => Credito.fromJson(credit)).toList();

    return Socio(
      dni: json['dni'],
      fullnombre: json['fullnombre'],
      diasAtraso: int.parse(json['dias_Atraso']),
      apellidoPaterno: json['apellido_paterno'],
      apellidoMaterno: json['apellido_materno'],
      nombres: json['nombres'],
      telefono: json['telefono'],
      celular: json['celular'],
      direccion: json['direccion'],
      correo: json['correo'],
      distrito: json['distrito'],
      provincia: json['provincia'],
      departamento: json['departamento'],
      creditos: creditos,
    );
  }
}

class Credito {
  final String riesgoSocio;
  final String tipoSocio;
  final String tipoCredito;
  final String producto;
  final String modalidad;
  final double creditoTotal;
  final String fechaAprobacion;
  final int plazoMeses;
  final double tasaMensual;
  final double tasaAnual;
  final String fechaPrimeraCuota;
  final String fechaVencimientoCuota;
  final double cuota;
  final double saldoCapital;

  Credito({
    required this.riesgoSocio,
    required this.tipoSocio,
    required this.tipoCredito,
    required this.producto,
    required this.modalidad,
    required this.creditoTotal,
    required this.fechaAprobacion,
    required this.plazoMeses,
    required this.tasaMensual,
    required this.tasaAnual,
    required this.fechaPrimeraCuota,
    required this.fechaVencimientoCuota,
    required this.cuota,
    required this.saldoCapital,
  });

  factory Credito.fromJson(Map<String, dynamic> json) {
    return Credito(
      riesgoSocio: json['riesgo_socio'],
      tipoSocio: json['tipo_socio'],
      tipoCredito: json['tipo_credito'],
      producto: json['producto'],
      modalidad: json['modalidad'],
      creditoTotal: json['credito_total'],
      fechaAprobacion: json['fecha_aprobacion'],
      plazoMeses: json['plazo_meses'],
      tasaMensual: json['tasa_mensual'],
      tasaAnual: json['tasa_anual'],
      fechaPrimeraCuota: json['fecha_primera_cuota'],
      fechaVencimientoCuota: json['fecha_vencimiento_cuota'],
      cuota: json['cuota'],
      saldoCapital: json['saldo_capital'],
    );
  }
}

class Analista {
  final String nombre;
  final String idanalista;
  final String apellido;
  final String cargo;

  Analista({
    required this.nombre,
    required this.idanalista,
    required this.apellido,
    required this.cargo,
  });

  factory Analista.fromJson(Map<String, dynamic> json) {
    return Analista(
      idanalista: json['idusuario'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      cargo: json['cargo'],
    );
  }
}
