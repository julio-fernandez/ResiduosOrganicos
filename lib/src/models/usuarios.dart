class Usuario {
  int usuarioId;
  String usrName;
  String pwd;
  String telefono;
  int rol;
  int puntuacionUsr;
  int puntuacionRec;
  Usuario(
      usuarioId, usrName, pwd, telefono, rol, puntuacionUsr, puntuacionRec) {
    this.usuarioId = usuarioId;
    this.usrName = usrName;
    this.pwd = pwd;
    this.telefono = telefono;
    this.rol = rol;
    this.puntuacionUsr = puntuacionUsr;
    this.puntuacionRec = puntuacionRec;
  }
  Usuario.fromJson(Map<String, dynamic> json)
      : usuarioId = json['usuarioId'],
        usrName = json['usrName'],
        pwd = json['pwd'],
        telefono = json['telefono'],
        rol = json['rol'],
        puntuacionUsr = json['puntuacionUsr'],
        puntuacionRec = json['puntuacionRec'];

  Map<String, dynamic> toJson() => {
        "usuarioId": usuarioId,
        "usrName": usrName,
        "pwd": pwd,
        "telefono": telefono,
        "rol": rol,
        "puntuacionUsr": puntuacionUsr,
        "puntuacionRec": puntuacionRec,
      };
}
