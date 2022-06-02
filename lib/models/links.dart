import 'dart:convert';

Links linksFromJson(String str) => Links.fromJson(json.decode(str));

String linksToJson(Links data) => json.encode(data.toJson());

class Links {
  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  String? first;
  String? last;
  String? prev;
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}
