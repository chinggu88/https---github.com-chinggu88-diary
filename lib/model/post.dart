class Post {
  final int seq;
  final String arr_imgname;
  final String texter;
  final String text;
  final String insertdate;
  final String photourl;
  final String texterid;
  final String filepath;
  final String couplename;

  Post(
      {this.seq,
      this.arr_imgname,
      this.texter,
      this.text,
      this.insertdate,
      this.photourl,
      this.texterid,
      this.filepath,
      this.couplename});

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      seq: json['seq'] as int,
      arr_imgname: json['arr_imgname'] as String,
      texter: json['texter'] as String,
      text: json['text'] as String,
      insertdate: json['insertdate'] as String,
      photourl: json['photourl'] as String,
      texterid: json['texterid'] as String,
      filepath: json['filepath'] as String,
      couplename: json['couplename'] as String,
    );
  }
}
