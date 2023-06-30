class Photos {
  int? id;

  Src? src;
  bool? liked;

  Photos({
    this.id,
    this.src,
    this.liked,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    src = json['src'] != null ? Src.fromJson(json['src']) : null;
    liked = json['liked'];
  }
}

class Src {
  String? original;
  String? large2x;

  Src({
    this.original,
    this.large2x,
  });

  Src.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    large2x = json['large2x'];
  }
}
