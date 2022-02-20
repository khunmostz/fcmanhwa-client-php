import 'dart:convert';

List<Manhwalist> manhwalistFromJson(String str) =>
    List<Manhwalist>.from(json.decode(str).map((x) => Manhwalist.fromJson(x)));

String manhwalistToJson(List<Manhwalist> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Manhwalist {
  Manhwalist({
    this.manhId,
    this.manhName,
    this.manhDesc,
    this.manhRating,
    this.cateId,
    this.manhUrl,
  });

  String? manhId;
  String? manhName;
  String? manhDesc;
  String? manhRating;
  String? cateId;
  String? manhUrl;

  factory Manhwalist.fromJson(Map<String, dynamic> json) => Manhwalist(
        manhId: json["manh_id"] == null ? null : json["manh_id"],
        manhName: json["manh_name"] == null ? null : json["manh_name"],
        manhDesc: json["manh_desc"] == null ? null : json["manh_desc"],
        manhRating: json["manh_rating"] == null ? null : json["manh_rating"],
        cateId: json["cate_id"] == null ? null : json["cate_id"],
        manhUrl: json["manh_url"] == null ? null : json["manh_url"],
      );

  Map<String, dynamic> toJson() => {
        "manh_id": manhId == null ? null : manhId,
        "manh_name": manhName == null ? null : manhName,
        "manh_desc": manhDesc == null ? null : manhDesc,
        "manh_rating": manhRating == null ? null : manhRating,
        "cate_id": cateId == null ? null : cateId,
        "manh_url": manhUrl == null ? null : manhUrl,
      };
}
