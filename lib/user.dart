class UserData {
  final String number;
  final String name;
  final String lastName;
  final String dni;
  final String cellphone;
  final String email;
  final String address;
  final String district;
  final String province;
  final String region;
  DateTime? assignedDate;
  UserData(this.number, this.name, this.lastName, this.dni, this.cellphone,
      this.email, this.address, this.district, this.province, this.region,
      {this.assignedDate});
}
