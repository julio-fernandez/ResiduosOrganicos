class Recolecciones {
  int recoleccionid;
  String direccion;
  String fechade;
  String fechahasta;
  String cantidad;
  String descripcion;
  String repetir;
  int usuarioid;
  int recolectorid;

  Recolecciones(recoleccionid, direccion, fechade, fechahasta, cantidad,
      descripcion, repetir, usuarioid, recolectorid) {
    this.recoleccionid = recoleccionid;
    this.direccion = direccion;
    this.fechade = fechade;
    this.fechahasta = fechahasta;
    this.cantidad = cantidad;
    this.descripcion = descripcion;
    this.repetir = repetir;
    this.usuarioid = usuarioid;
    this.recolectorid = recolectorid;
  }
  Recolecciones.fromJson(Map<String, dynamic> json)
      : recoleccionid = json['recoleccionid'],
        direccion = json['direccion'],
        fechade = json['fecha'],
        fechahasta = json['fechahasta'],
        cantidad = json['cantidad'],
        descripcion = json['descripcion'],
        repetir = json['repetir'],
        usuarioid = json['usuarioid'],
        recolectorid = json['recolectorid'];

  Map<String, dynamic> toJson() => {
        "recoleccionid": recoleccionid,
        "direccion": direccion,
        "fechade": fechade,
        "fechahasta": fechahasta,
        "cantidad": cantidad,
        "descripcion": descripcion,
        "repetir": repetir,
        "usuarioid": usuarioid,
        "recolectorid": recolectorid,
      };
}
