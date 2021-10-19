class Aply {
  final int seq;
  final String image_seq;
  final String name;
  final String aply_text;
  final String profilephoto;
  final String textid;
  final String couplename;
  final String date;

  Aply({
    this.seq,
    this.image_seq,
    this.name,
    this.aply_text,
    this.profilephoto,
    this.textid,
    this.couplename,
    this.date,
  });

  factory Aply.fromJSON(Map<String, dynamic> json) {
    return Aply(
      seq: json['seq'] as int,
      image_seq: json['image_seq'] as String,
      name: json['name'] as String,
      aply_text: json['aply_text'] as String,
      profilephoto: json['profilephoto'] as String,
      textid: json['textid'] as String,
      couplename: json['couplename'] as String,
      date: json['date'] as String,
    );
  }
}
