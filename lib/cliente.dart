class Cliente {
  String foto;
  String nombre;
  String apellido;
  String profesion;
  DateTime fechaNacimiento;
  int edad;

  Cliente(
      {this.foto,
      this.nombre,
      this.apellido,
      this.profesion,
      this.fechaNacimiento});

  int calcularEdad() {
    double edad = DateTime.now().difference(this.fechaNacimiento).inDays / 365;
    return edad.toInt();
  }

  String mostrarFechaYEdad() {
    String fechaYhora = this.fechaNacimiento.day.toString() +
        '/' +
        this.fechaNacimiento.month.toString() +
        '/' +
        this.fechaNacimiento.year.toString() +
        '\n' +
        this.calcularEdad().toString() +
        ' años';
    return fechaYhora;
  }
}