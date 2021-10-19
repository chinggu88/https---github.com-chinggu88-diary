class Users {
  final int seq;
  final String id;
  final String name;
  final String age;
  final String sexuality;
  final String couplename;
  final String photourl;
  final String backgroundphoto;
  final String profilephoto;
  Users(
      {this.seq,
      this.id,
      this.name,
      this.age,
      this.sexuality,
      this.couplename,
      this.photourl,
      this.backgroundphoto,
      this.profilephoto});

  factory Users.fromJSON(Map<String, dynamic> json) {
    return Users(
      seq: json['seq'] as int,
      id: json['id'] as String,
      name: json['name'] as String,
      age: json['age'] as String,
      sexuality: json['sexuality'] as String,
      couplename: json['couplename'] as String,
      photourl: json['photourl'] as String,
      backgroundphoto: json['backgroundphoto'] as String,
      profilephoto: json['profilephoto'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seq'] = this.seq;
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['sexuality'] = this.sexuality;
    data['couplename'] = this.couplename;
    data['photourl'] = this.photourl;
    data['backgroundphoto'] = this.backgroundphoto;
    data['profilephoto'] = this.profilephoto;
    return data;
  }
}
