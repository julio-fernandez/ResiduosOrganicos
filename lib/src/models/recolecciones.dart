class Recolecciones {
  int recoleccionid;
  String direccion;
  String fecha;
  String repetir;
  int usuarioid;
  int recolectorid;

  Recolecciones(
      recoleccionid, direccion, fecha, repetir, usuarioid, recolectorid) {
    this.recoleccionid = recoleccionid;
    this.direccion = direccion;
    this.fecha = fecha;
    this.repetir = repetir;
    this.usuarioid = usuarioid;
    this.recolectorid = recolectorid;
  }
  Recolecciones.fromJson(Map<String, dynamic> json)
      : recoleccionid = json['recoleccionid'],
        direccion = json['direccion'],
        fecha = json['fecha'],
        repetir = json['repetir'],
        usuarioid = json['usuarioid'],
        recolectorid = json['recolectorid'];

  Map<String, dynamic> toJson() => {
        "recoleccionid": recoleccionid,
        "direccion": direccion,
        "fecha": fecha,
        "repetir": repetir,
        "usuarioid": usuarioid,
        "recolectorid": recolectorid,
      };
}
