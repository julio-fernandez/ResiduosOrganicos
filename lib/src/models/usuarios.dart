class Usuario {
  int usuarioId;
  String usrName;
  String pwd;
  String telefono;
  int rol;
  Usuario(usuarioId, usrName, pwd, telefono, rol) {
    this.usuarioId = usuarioId;
    this.usrName = usrName;
    this.pwd = pwd;
    this.telefono = telefono;
    this.rol = rol;
  }
  Usuario.fromJson(Map<String, dynamic> json)
      : usuarioId = json['usuarioId'],
        usrName = json['usrName'],
        pwd = json['pwd'],
        telefono = json['telefono'],
        rol = json['rol'];

  Map<String, dynamic> toJson() => {
        "usuarioId": usuarioId,
        "usrName": usrName,
        "pwd": pwd,
        "telefono": telefono,
        "rol": rol,
      };
}
