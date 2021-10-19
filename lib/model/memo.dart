class Memo {
  final int seq;
  final String text;
  final String date;
  final String writer;

  Memo({this.seq, this.text, this.date, this.writer});

  factory Memo.fromJSON(Map<String, dynamic> json) {
    return Memo(
      seq: json['seq'] as int,
      text: json['text'] as String,
      date: json['date'] as String,
      writer: json['writer'] as String,
    );
  }
}
