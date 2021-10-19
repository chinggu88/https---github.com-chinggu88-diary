class Schedulelist {
  final int seq;
  final String text;
  final String date;
  final String writer;
  final String couplename;
  final String calendarcolor;

  Schedulelist(
      {this.seq,
      this.text,
      this.date,
      this.writer,
      this.couplename,
      this.calendarcolor});

  factory Schedulelist.fromJSON(Map<String, dynamic> json) {
    return Schedulelist(
      seq: json['seq'] as int,
      text: json['text'] as String,
      date: json['date'] as String,
      writer: json['writer'] as String,
      couplename: json['couplename'] as String,
      calendarcolor: json['calendarcolor'] as String,
    );
  }
}
