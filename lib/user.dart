class UserData {
  final String number;
  final String name;
  final String lastName;
  final String dni;
  final String sexo;
  final String edad;
  final String fechaNacimiento;
  final String cellphone;
  final String email;
  final String address;
  final String district;
  final String province;
  final String region;
  final String riesgoSocio;
  final String tipoSocio;
  final String tipoCredito;
  final String tipoProducto;
  final String modalidad;
  final String nombrePrestamo;
  final String creditoTotal;
  final String plazo;
  final String tasaInteres;
  final String fechaAprobacion;
  final String ultimaFechaPago;
  final String montoCuota;
  final String saldoVencido;
  final String saldoCredito;
  DateTime? assignedDate;
  UserData(
      this.number,
      this.name,
      this.lastName,
      this.dni,
      this.sexo,
      this.edad,
      this.fechaNacimiento,
      this.cellphone,
      this.email,
      this.address,
      this.district,
      this.province,
      this.region,
      this.riesgoSocio,
      this.tipoSocio,
      this.tipoCredito,
      this.tipoProducto,
      this.modalidad,
      this.nombrePrestamo,
      this.creditoTotal,
      this.plazo,
      this.tasaInteres,
      this.fechaAprobacion,
      this.ultimaFechaPago,
      this.montoCuota,
      this.saldoVencido,
      this.saldoCredito,
      {this.assignedDate});
}
